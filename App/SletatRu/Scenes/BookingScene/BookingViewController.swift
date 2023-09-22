//
//  BookingViewController.swift
//  SletatRu
//
//  Created by Constantin on 06.09.2023.
//

import UIKit

// MARK: - IBookingViewControllerDelegate

protocol IBookingViewControllerDelegate: AnyObject {
	func pressButtom()
}

// MARK: - BookingViewController

final class BookingViewController: UIViewController {
	// MARK: - Private properties

	private let bookingWorker = BookingWorker()
	private let bookingView: BookingView?
	private let booking: Booking?
	private lazy var navigationItemLabel = createNavigationItemLabel()

	// MARK: - Lifecycle

	init() {
		booking = bookingWorker.fetchBooking()
		bookingView = BookingView(booking: booking)
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder _: NSCoder) {
		fatalError(L10n.FatalError.required)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		view = bookingView
		bookingView?.delegate = self
		setupNavigationItem()
	}

	// MARK: - Private methods

	private func createNavigationItemLabel() -> UILabel {
		let label = UILabel()
		label.text = L10n.NavigationItem.booking
		label.font = UIFont.preferredFont(forTextStyle: .headline)

		return label
	}

	private func setupNavigationItem() {
		navigationItem.titleView = navigationItemLabel
		navigationController?.navigationBar.tintColor = .black
		navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
	}
}

// MARK: IBookingViewControllerDelegate

extension BookingViewController: IBookingViewControllerDelegate {
	// MARK: - Internal methods

	// Переход на экран PaidViewController.
	func pressButtom() {
		let paidViewController = PaidViewController()

		navigationController?.pushViewController(paidViewController, animated: true)
	}
}
