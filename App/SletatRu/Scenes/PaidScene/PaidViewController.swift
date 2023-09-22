//
//  PaidViewController.swift
//  SletatRu
//
//  Created by Constantin on 06.09.2023.
//

import UIKit

// MARK: - IPaidViewControllerDelegate

protocol IPaidViewControllerDelegate: AnyObject {
	func pressButtom()
}

// MARK: - PaidViewController

final class PaidViewController: UIViewController {
	// MARK: - Private properties

	private let paidView: PaidView?
	private lazy var navigationItemLabel = createNavigationItemLabel()

	// MARK: - Lifecycle

	init() {
		paidView = PaidView()
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder _: NSCoder) {
		fatalError(L10n.FatalError.required)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		view = paidView
		paidView?.delegate = self
		setupNavigationItem()
	}

	// MARK: - Private methods

	private func createNavigationItemLabel() -> UILabel {
		let label = UILabel()
		label.text = L10n.NavigationItem.paid
		label.font = UIFont.preferredFont(forTextStyle: .headline)

		return label
	}

	private func setupNavigationItem() {
		navigationItem.titleView = navigationItemLabel
		navigationController?.navigationBar.tintColor = .black
		navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
	}
}

// MARK: IPaidViewControllerDelegate

extension PaidViewController: IPaidViewControllerDelegate {
	// MARK: - Internal methods

	// Возврат на начальный экран.
	func pressButtom() {
		if let navigationController = navigationController {
			navigationController.popToRootViewController(animated: true)
		}
	}
}
