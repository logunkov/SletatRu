//
//  HotelViewController.swift
//  SletatRu
//
//  Created by Constantin on 06.09.2023.
//

import UIKit

// MARK: - IHotelViewControllerDelegate

protocol IHotelViewControllerDelegate: AnyObject {
	func pressButtom(hotel: String)
}

// MARK: - HotelViewController

final class HotelViewController: UIViewController {
	// MARK: - Private properties

	private let hotel: Hotel?
	private let hotelView: HotelView?
	private let hotelWorker = HotelWorker()
	private lazy var navigationItemLabel = createNavigationItemLabel()

	// MARK: - Lifecycle

	init() {
		hotel = hotelWorker.fetchHotels()
		hotelView = HotelView(hotel: hotel)
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder _: NSCoder) {
		fatalError(L10n.FatalError.required)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		view = hotelView
		hotelView?.delegate = self
		setupNavigationItem()
	}

	// MARK: - Private methods

	private func createNavigationItemLabel() -> UILabel {
		let label = UILabel()
		label.text = L10n.NavigationItem.hotel
		label.font = UIFont.preferredFont(forTextStyle: .headline)

		return label
	}

	private func setupNavigationItem() {
		navigationItem.titleView = navigationItemLabel
		navigationController?.navigationBar.tintColor = .black
		navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
	}
}

// MARK: IHotelViewControllerDelegate

extension HotelViewController: IHotelViewControllerDelegate {
	// MARK: - Internal methods

	// Переход на экран RoomViewController.
	func pressButtom(hotel: String) {
		let roomViewController = RoomViewController(hotel: hotel)

		navigationController?.pushViewController(roomViewController, animated: true)
	}
}
