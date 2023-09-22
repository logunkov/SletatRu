//
//  BookingWorker.swift
//  SletatRu
//
//  Created by Constantin on 07.09.2023.
//

import Foundation

// MARK: - BookingWorker

final class BookingWorker {
	// MARK: - Private properties

	private let jsonDecoder = JSONDecoder()
	private let urlSting = L10n.Url.booking
	private var booking: Booking?
	private let semaphore = DispatchSemaphore(value: 0)

	// MARK: - Internal methods

	// Загрузка данных.
	func fetchBooking() -> Booking? {
		guard let url = URL(string: urlSting) else { return nil }
		jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

		let session = URLSession.shared.dataTask(with: url) { [jsonDecoder] data, _, _ in
			guard let data else { return }

			if let bookingJSON = try? jsonDecoder.decode(Booking.self, from: data) {
				self.booking = bookingJSON
			}

			self.semaphore.signal()
		}
		session.resume()
		semaphore.wait()

		return booking
	}
}
