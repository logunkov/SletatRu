//
//  RoomViewController.swift
//  SletatRu
//
//  Created by Constantin on 06.09.2023.
//

import UIKit

// MARK: - IRoomViewControllerDelegate

protocol IRoomViewControllerDelegate: AnyObject {
	func pressButtom()
}

// MARK: - RoomViewController

final class RoomViewController: UITableViewController {
	// MARK: - Internal properties

	let hotel: String

	// MARK: - Private properties

	private let roomWorker = RoomWorker()
	private let room: Room?
	private lazy var navigationItemLabel = createNavigationItemLabel()

	// MARK: - Lifecycle

	init(hotel: String) {
		self.hotel = hotel
		room = roomWorker.fetchRooms()
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder _: NSCoder) {
		fatalError(L10n.FatalError.required)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 44.0
		tableView.showsVerticalScrollIndicator = false
		tableView.bounces = false

		tableView.register(RoomTableViewCell.self, forCellReuseIdentifier: L10n.TableViewCell.room)
		setupNavigationItem()
	}

	override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
		guard let room else { return .zero }
		return room.rooms.count
	}

	override func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let apartment = room?.rooms[indexPath.row]

		let cell = RoomTableViewCell(style: .default, reuseIdentifier: L10n.TableViewCell.room, apartment: apartment)

		cell.delegate = self

		return cell
	}

	override func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
		UITableView.automaticDimension
	}

	override func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
		16
	}

	// MARK: - Private methods

	private func createNavigationItemLabel() -> UILabel {
		let label = UILabel()
		label.numberOfLines = .zero
		label.textAlignment = .center
		label.font = UIFont.preferredFont(forTextStyle: .headline)

		return label
	}

	private func setupNavigationItem() {
		navigationItemLabel.text = hotel
		navigationItem.titleView = navigationItemLabel
		navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
	}
}

// MARK: IRoomViewControllerDelegate

extension RoomViewController: IRoomViewControllerDelegate {
	// MARK: - Internal methods

	// Переход на экран BookingViewController.
	func pressButtom() {
		let bookingViewController = BookingViewController()
		navigationController?.pushViewController(bookingViewController, animated: true)
	}
}
