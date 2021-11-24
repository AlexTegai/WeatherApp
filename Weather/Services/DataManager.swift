//
//  DataManager.swift
//  Weather
//
//  Created by Alex Tegai on 26.10.2021.
//

import Foundation
import UIKit

class DataManager {
    static let shared = DataManager()
    
    private let userDefaults = UserDefaults.standard
    private let key = "city"
    
    private init() {}
    
    func save(city: CityWeather) {
        var cities = fetchCities()
        cities.append(city)
        guard let data = try? JSONEncoder().encode(cities) else { return }
        userDefaults.set(data, forKey: key)
    }
    
    func fetchCities() -> [CityWeather] {
        guard let data = userDefaults.object(forKey: key) as? Data,
              let cities = try? JSONDecoder().decode([CityWeather].self, from: data)
        else { return [] }
        return cities
    }
    
    func getCity(at index: Int) -> CityWeather {
        let cities = fetchCities()
        let city = cities[index]
        return city
    }
    
    func deleteCity(at index: Int) {
        var cities = fetchCities()
        cities.remove(at: index)
        guard let data = try? JSONEncoder().encode(cities) else { return }
        userDefaults.set(data, forKey: key)
    }
    
    func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let request = URLRequest(url: url)
        let cachedResponse = CachedURLResponse(response: response, data: data)
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
    
    func getCachedImage(from url: URL) -> Data? {
        let request = URLRequest(url: url)
        if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
            let cachedResponseData = cachedResponse.data
            return cachedResponseData
        }
        return nil
    }
}
