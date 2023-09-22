//
//  BookingModel.swift
//  SletatRu
//
//  Created by Constantin on 07.09.2023.
//

// MARK: - Booking

struct Booking: Codable {
	// MARK: - Internal properties

	let id: Int
	let hotelName, hotelAdress: String
	let horating: Int
	let ratingName, departure, arrivalCountry, tourDateStart: String
	let tourDateStop: String
	let numberOfNights: Int
	let room, nutrition: String
	let tourPrice, fuelCharge, serviceCharge: Int
}
