//
//  HotelWorker.swift
//  SletatRu
//
//  Created by Constantin on 06.09.2023.
//

import Foundation

// MARK: - HotelWorker

final class HotelWorker {
	// MARK: - Private properties

	private let jsonDecoder = JSONDecoder()
	private let urlSting = L10n.Url.hotel
	private let lock = NSLock()
	private var hotel: Hotel?

	// MARK: - Internal methods

	// Загрузка данных.
	func fetchHotels() -> Hotel? {
		guard let url = URL(string: urlSting) else { return nil }
		jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

		lock.lock()
		let session = URLSession.shared.dataTask(with: url) { [jsonDecoder] data, _, _ in
			guard let data else { return }

			if let hotelJSON = try? jsonDecoder.decode(Hotel.self, from: data) {
				self.hotel = hotelJSON
			}

			self.lock.unlock()
		}
		session.resume()

		lock.lock()
		lock.unlock()

		return hotel
	}
}
