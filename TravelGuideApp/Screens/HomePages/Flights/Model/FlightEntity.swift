//
//  FlightEntity.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 4.10.2022.
//

// MARK: - Flight
struct Flight: Codable {
    let flights: [FlightElement]?
}

// MARK: - FlightElement
struct FlightElement: Codable {
    let id: Int?
    let flightCompany, flightNumber, flightTitle: String?
    let departAirport, arrivalAirport, departDate, arrivalDate, day: String?
    let price: String?
    let image: String?
}


// MARK: - FlightEntity CORE_DATA
struct FlightCoreDataEntity{
    let id: Int?
    let flightCompany, flightNumber, flightTitle: String?
    let departAirport, arrivalAirport, departDate, arrivalDate, day: String?
    let price: String?
    let image: String?
}

