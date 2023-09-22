//
//  RoomModel.swift
//  SletatRu
//
//  Created by Constantin on 06.09.2023.
//

// MARK: - Room

struct Room: Codable {
	// MARK: - Internal properties

	let rooms: [Apartment]
}

// MARK: - Apartment

struct Apartment: Codable {
	// MARK: - Internal properties

	let id: Int
	let name: String
	let price: Int
	let pricePer: String
	let peculiarities: [String]
	let imageUrls: [String]
}
