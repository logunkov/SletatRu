//
//  PaidView.swift
//  SletatRu
//
//  Created by Constantin on 18.09.2023.
//

import UIKit

// MARK: - PaidView

final class PaidView: UIView {
	// MARK: - Internal properties

	weak var delegate: IPaidViewControllerDelegate?

	// MARK: - Private properties

	private lazy var mainStackView = createMainStackView()
	private lazy var emojiLabel = createEmojiLabel()
	private lazy var acceptedForWorkLabel = createAcceptedForWorkLabel()
	private lazy var orderConfirmationLabel = createOrderConfirmationLabel()
	private lazy var button = createButton()

	// MARK: - Life Cycle

	init() {
		super.init(frame: .zero)
		setupView()
	}

	required init?(coder _: NSCoder) {
		fatalError(L10n.FatalError.required)
	}

	// MARK: - Private methods

	private func setupView() {
		backgroundColor = Theme.backgroundColor

		addSubviews([
			mainStackView,
			button,
		])

		mainStackView.addArrangedSubviews([
			emojiLabel,
			acceptedForWorkLabel,
			orderConfirmationLabel,
		])

		NSLayoutConstraint.activate([
			mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
			mainStackView.centerYAnchor.constraint(equalTo: centerYAnchor),
			button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Sizes.Medium.padding),
			button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Sizes.Medium.padding),
			button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Sizes.Medium.doublePadding),
		])
	}
}

// MARK: - Actions

private extension PaidView {
	@objc private func buttonPaidTapped() {
		delegate?.pressButtom()
	}
}

// MARK: - Element

private extension PaidView {
	func createMainStackView() -> UIStackView {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.alignment = .center
		stackView.spacing = Sizes.Medium.padding
		stackView.layoutMargins = UIEdgeInsets(
			top: Sizes.Medium.halfPadding,
			left: Sizes.Medium.halfPadding,
			bottom: Sizes.Medium.halfPadding,
			right: Sizes.Medium.halfPadding
		)
		stackView.isLayoutMarginsRelativeArrangement = true
		stackView.translatesAutoresizingMaskIntoConstraints = false

		return stackView
	}

	func createEmojiLabel() -> UILabel {
		let label = PaddingLabel()
		label.text = L10n.Paid.emoji
		label.clipsToBounds = true
		label.backgroundColor = Theme.accentColor
		label.paddingLeft = Sizes.Emoji.padding
		label.paddingRight = Sizes.Emoji.padding
		label.paddingTop = Sizes.Emoji.padding
		label.paddingBottom = Sizes.Emoji.padding
		label.layer.cornerRadius = Sizes.Emoji.cornerRadius
		label.font = UIFont.preferredFont(forTextStyle: .largeTitle)

		return label
	}

	func createAcceptedForWorkLabel() -> UILabel {
		let label = UILabel()
		label.text = L10n.Paid.acceptedForWork
		label.font = UIFont.preferredFont(forTextStyle: .headline)

		return label
	}

	func createOrderConfirmationLabel() -> UILabel {
		let label = UILabel()
		label.text = L10n.Paid.orderConfirmation
		label.numberOfLines = .zero
		label.textAlignment = .center
		label.textColor = Theme.gray
		label.font = UIFont.preferredFont(forTextStyle: .subheadline)

		return label
	}

	func createButton() -> UIButton {
		var configuration = UIButton.Configuration.filled()
		configuration.title = L10n.Paid.button
		configuration.baseBackgroundColor = Theme.blue
		configuration.cornerStyle = .large

		let button = UIButton(configuration: configuration)
		button.addTarget(self, action: #selector(buttonPaidTapped), for: .touchUpInside)

		button.translatesAutoresizingMaskIntoConstraints = false

		return button
	}
}
