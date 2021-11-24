//
//  oNrkManager.swift
//  Weather
//
//  Created by Alex Tegai on 19.10.2021.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let iconUrl = "https://openweathermap.org/img/wn/"
    let apiKey = "&appid=560293aa41e20a9533cb4b4f0be70396"
    
    private init() {}
    
    func fetchData(city: String, completion: @escaping (Result<CityWeather, Error>) -> Void) {
        let baseURL = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric"
        
        guard let url = URL(string: baseURL + apiKey) else {return}

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No Description")
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let cityWeather = try decoder.decode(CityWeather.self, from: data)

                DispatchQueue.main.async {
                    completion(.success(cityWeather))
                }
                
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}

extension NetworkManager {    
    func fetchIcon(from url: URL, completion: @escaping (Data, URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No Description")
                return
            }
            
            guard url == response.url else { return }
            
            DispatchQueue.main.async {
                completion(data, response)
            }
        }.resume()
    }
}



