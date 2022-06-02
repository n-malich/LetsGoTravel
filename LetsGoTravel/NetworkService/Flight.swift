//
//  Flight.swift
//  LetsGoTravel
//
//  Created by Natali Malich
//

import Foundation

// MARK: - Flights
struct Flights: Decodable {
    let meta: Meta
    let data: [Flight]
}

// MARK: - Flight
struct Flight: Decodable {
    let startCity: String
    let startCityCode: String
    let endCity: String
    let endCityCode: String
    let startDate: String
    let endDate: String
    let price: Int
    let searchToken: String
}

// MARK: - Meta
struct Meta: Decodable {
}
