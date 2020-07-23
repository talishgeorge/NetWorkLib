//
//  Created by TCS.
//  Copyright © 2020 TCS. All rights reserved.
//

import Foundation

public struct ResponseModel<T: Decodable>: Decodable {
    
    var status: String
    var totalResults: Int
    var error: ErrorModel {
        return ErrorModel(status)
    }
    var rawData: Data?
    var data: T?
    var json: String? {
        guard let rawData = rawData else { return nil }
        return String(data: rawData, encoding: String.Encoding.utf8)
    }
    var request: RequestModel?
    
    public init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        status = (try? keyedContainer.decode(String.self, forKey: CodingKeys.status)) ?? ""
        totalResults = (try? keyedContainer.decode(Int.self, forKey: CodingKeys.totalResults)) ?? 0
        data = try? keyedContainer.decode(T.self, forKey: CodingKeys.articles)
    }
}

// MARK: - Internal Functions

public extension ResponseModel {
    enum CodingKeys: String, CodingKey {
        case status
        case totalResults
        case data
        case articles
    }
}

public struct WeatherResponseModel<T: Decodable>: Decodable {
    
    var coord: T?
    var weather: T?
    var base: T?
    var main: T?
    var visibility: T?
    var wind: T?
    var clouds: T?
    var dt: T?
    var sys: T?
    var timezone: T?
    var id: T?
    var name: T?
    var cod: T?
    var data: T?
    
//    var error: ErrorModel {
//        return ErrorModel(status)
//    }
    var rawData: Data?
    var json: String? {
        guard let rawData = rawData else { return nil }
        return String(data: rawData, encoding: String.Encoding.utf8)
    }
    var request: RequestModel?
    
    public init(from decoder: Decoder) throws {
        let keyedContainer = try decoder.container(keyedBy: CodingKeys.self)
        coord = try? keyedContainer.decode(T.self, forKey: CodingKeys.coord)
        weather = try? keyedContainer.decode(T.self, forKey: CodingKeys.weather)
        base = try? keyedContainer.decode(T.self, forKey: CodingKeys.base)
        main = try? keyedContainer.decode(T.self, forKey: CodingKeys.main)
        visibility = try? keyedContainer.decode(T.self, forKey: CodingKeys.visibility)
        wind = try? keyedContainer.decode(T.self, forKey: CodingKeys.wind)
        clouds = try? keyedContainer.decode(T.self, forKey: CodingKeys.clouds)
        dt = try? keyedContainer.decode(T.self, forKey: CodingKeys.dt)
        sys = try? keyedContainer.decode(T.self, forKey: CodingKeys.sys)
        timezone = try? keyedContainer.decode(T.self, forKey: CodingKeys.timezone)
        id = try? keyedContainer.decode(T.self, forKey: CodingKeys.id)
        name = try? keyedContainer.decode(T.self, forKey: CodingKeys.name)
        cod = try? keyedContainer.decode(T.self, forKey: CodingKeys.coord)
        
    }
}

// MARK: - Internal Functions

public extension WeatherResponseModel {
    enum CodingKeys: String, CodingKey {
        case coord
        case weather
        case base
        case main
        case visibility
        case wind
        case clouds
        case dt
        case sys
        case timezone
        case id
        case name
        case cod
    }
}
