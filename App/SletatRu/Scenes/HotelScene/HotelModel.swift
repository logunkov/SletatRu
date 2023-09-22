//
//  HotelModel.swift
//  SletatRu
//
//  Created by Constantin on 06.09.2023.
//

// MARK: - Hotel

struct Hotel: Codable {
	// MARK: - Internal properties

	let id: Int
	let name: String
	let adress: String
	let minimalPrice: Int
	let priceForIt: String
	let rating: Int
	let ratingName: String
	let imageUrls: [String]
	let aboutTheHotel: AboutTheHotel
}

// MARK: - AboutTheHotel

struct AboutTheHotel: Codable {
	// MARK: - Internal properties

	let description: String
	let peculiarities: [String]
}
