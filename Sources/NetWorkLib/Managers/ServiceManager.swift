//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//

import Foundation

public struct Resource<T> {
    public init(url: URL, parse: @escaping (Data) -> T?) {
        self.url = url
        self.parse = parse
    }
    
    public let url: URL
    public let parse: (Data) -> T?
}

public class ServiceManager {
    
    // MARK: - Properties
    public static let shared: ServiceManager = ServiceManager()
    public var baseURL: String = "https://newsapi.org/v2/"
}

// MARK: - Public Functions

public extension ServiceManager {
    
    /// Load genric resources
    func load<T>(_ resource: Resource<T>, completion: @escaping (T?) -> Void) {
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    completion(resource.parse(data))
                }
            } else {
                completion(nil)
            }
        }
        .resume()
    }
    
    func sendRequest<T: Decodable>(request: RequestModel, completion: @escaping(Swift.Result<T, ErrorModel>) -> Void) {
        if request.isLoggingEnabled.0 {
            LogManager.req(request)
        }
        URLSession.shared.dataTask(with: request.urlRequest()) { data, response, error in
            guard let data = data, var responseModel = try? JSONDecoder().decode(ResponseModel<T>.self, from: data), let model = try? JSONDecoder().decode(T.self, from: data) else {
                let error: ErrorModel = ErrorModel(ErrorKey.parsing.rawValue)
                LogManager.err(error)
                completion(Result.failure(error))
                return
            }
            responseModel.rawData = data
            responseModel.request = request
            responseModel.data = model
            if request.isLoggingEnabled.1 {
                LogManager.res(responseModel)
            }
            if !responseModel.status.isEmpty, let data = responseModel.data {
                completion(Result.success(data))
            } else {
                completion(Result.failure(ErrorModel.generalError()))
            }
        }
        .resume()
    }
    
    func sendWeatherRequest<T: Decodable>(request: RequestModel, completion: @escaping(Swift.Result<T, ErrorModel>) -> Void) {
        if request.isLoggingEnabled.0 {
            LogManager.req(request)
        }
        URLSession.shared.dataTask(with: request.urlRequest()) { data, response, error in
            guard let data = data, var responseModel = try? JSONDecoder().decode(WeatherResponseModel<T>.self, from: data), let model = try? JSONDecoder().decode(T.self, from: data) else {
                let error: ErrorModel = ErrorModel(ErrorKey.parsing.rawValue)
                LogManager.err(error)
                completion(Result.failure(error))
                return
            }
            responseModel.rawData = data
            responseModel.request = request
            responseModel.data = model
            if request.isLoggingEnabled.1 {
                //LogManager.res(responseModel)
            }
            if let data = responseModel.data {
                completion(Result.success(data))
            } else {
                completion(Result.failure(ErrorModel.generalError()))
            }
        }
        .resume()
    }
}
