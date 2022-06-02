//
//  NetworkService.swift
//  LetsGoTravel
//
//  Created by Natali Malich
//

import Foundation

struct NetworkService {
    
    // MARK: - Properties
    static let shared = NetworkService()
    private let url = URL(string: "https://travel.wildberries.ru/statistics/v1/cheap")
        
    // MARK: - Funcs
    func fetchFlights(completion: @escaping ([Flight]) -> Void) {
        guard let url = url else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, responce, error in
            guard let data = data else { return }
            do {
                let responce = try JSONDecoder().decode(Flights.self, from: data)
                let flights = responce.data
                
                DispatchQueue.main.async {
                    completion(flights)
                }
            } catch let error {
                print("Web service didn't respond: \(error.localizedDescription)")
            }
        }.resume()
    }
 }
