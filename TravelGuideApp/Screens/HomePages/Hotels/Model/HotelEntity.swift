//
//  HotelEntity.swift
//  TravelGuideApp
//
//  Created by Ahmet Ozkan on 4.10.2022.
//

// MARK: - Hotel
struct Hotel: Codable {
    let hotels: [HotelElement]?
}

// MARK: - HotelElement
struct HotelElement: Codable {
    let id: Int?
    let name, description, price, address: String?
    let image: String?
}

// MARK: - HotelEntity CORE_DATA
struct HotelCoreDataEntity {
    let id: Int?
    let name, hotelDescription, price, address: String?
    let image: String?
}
