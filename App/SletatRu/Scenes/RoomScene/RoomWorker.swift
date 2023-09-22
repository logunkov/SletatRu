//
//  RoomWorker.swift
//  SletatRu
//
//  Created by Constantin on 06.09.2023.
//

import Foundation

// MARK: - RoomWorker

final class RoomWorker {
	// MARK: - Private properties

	private let jsonDecoder = JSONDecoder()
	private let urlSting = L10n.Url.room
	private let semaphore = DispatchSemaphore(value: 0)
	private var room: Room?

	// MARK: - Internal methods

	// Загрузка данных.
	func fetchRooms() -> Room? {
		guard let url = URL(string: urlSting) else { return nil }
		jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

		let session = URLSession.shared.dataTask(with: url) { [jsonDecoder] data, _, _ in
			guard let data else { return }

			if let roomJSON = try? jsonDecoder.decode(Room.self, from: data) {
				self.room = roomJSON
			}
			self.semaphore.signal()
		}
		session.resume()
		semaphore.wait()

		return room
	}
}
