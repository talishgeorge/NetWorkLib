//
//  File.swift
//  
//
//  Created by Talish George on 24/07/20.
//

import Foundation

extension URL {
    static func urlForWeather(for cityName: String) -> URL {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&Appid=315a5a4dae4ad2b0554677c7fdfdada1")!
    }
}
