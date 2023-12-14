//
//  RoomView.swift
//  SletatRu
//
//  Created by Constantin on 11.09.2023.
//

import UIKit

// MARK: - RoomTableViewCell

class RoomTableViewCell: UITableViewCell {
	// MARK: - Internal properties

	weak var delegate: IRoomViewControllerDelegate?
	var apartment: Apartment?

	// MARK: - Private properties

	private lazy var mainStackView = createmMainStackView()
	private lazy var carouselView = createCarouselView()

	// MARK: - Life Cycle

	init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, apartment: Apartment?) {
		self.apartment = apartment
		super.init(style: style, reuseIdentifier: reuseIdentifier)

		setupView()
		createRoomView()
		loadImage()
	}

	required init?(coder _: NSCoder) {
		fatalError(L10n.FatalError.required)
	}

	// MARK: - Private methods

	private func setupView() {
		backgroundColor = Theme.accentColor
		contentView.isUserInteractionEnabled = true
		addSubview(mainStackView)

		NSLayoutConstraint.activate([
			mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
			mainStackView.topAnchor.constraint(equalTo: topAnchor),
			mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),

			carouselView.heightAnchor.constraint(equalTo: carouselView.widthAnchor, multiplier: Sizes.Medium.multiplier)
		])
	}

	private func createRoomView() {
		guard let apartment else { return }

		let apartmentStackView = createStackView()
		apartmentStackView.spacing = .zero

		let aboutApartmentStackView = createStackView()

		let nameLabel = createLabel()
		nameLabel.text = apartment.name
		nameLabel.font = UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .title3).pointSize)

		let peculiaritiesVerticalStackView = createPeculiaritiesVerticalStackView()

		let configurationRoomButton = createConfigurationButton()
		let aboutRoomButton = UIButton(configuration: configurationRoomButton)

		let aboutRoomStackView = createStackView(top: .zero, left: .zero)
		aboutRoomStackView.alignment = .leading

		let priceStackView = createStackView(top: .zero, left: .zero)
		priceStackView.alignment = .center
		priceStackView.axis = .horizontal

		let priceLabel = createPriceLabel()

		let flyLabel = createLabel()
		flyLabel.text = apartment.pricePer
		flyLabel.textColor = Theme.gray
		flyLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)

		let choiseRoomButton = createChoiseRoomButton()

		aboutRoomStackView.addArrangedSubview(aboutRoomButton)

		priceStackView.addArrangedSubviews([
			priceLabel,
			flyLabel
		])

		aboutApartmentStackView.addArrangedSubviews([
			nameLabel,
			peculiaritiesVerticalStackView,
			aboutRoomStackView,
			priceStackView
		])

		apartmentStackView.addArrangedSubviews([
			carouselView,
			aboutApartmentStackView,
			choiseRoomButton
		])

		mainStackView.addArrangedSubview(apartmentStackView)
	}

	private func loadImage() {
		var images = [UIImage]()
		let session = URLSession.shared
		let urls = apartment?.imageUrls

		// Создаем группу диспетчеризации
		let group = DispatchGroup()

		urls?.forEach { urlString in
			guard let url = URL(string: urlString) else { return }
			// Увеличиваем счетчик группы перед началом загрузки
			group.enter()

			session.dataTask(with: url) { data, _, _ in
				defer {
					// Уменьшаем счетчик группы после завершения загрузки
					group.leave()
				}

				if let data = data, let image = UIImage(data: data) {
					images.append(image)
				}
			}
			.resume()
		}

		group.notify(queue: .main) {
			// Выполняем после того, как все картинки загрузились
			self.carouselView.setImages(images)
		}
	}
}

// MARK: - Actions

private extension RoomTableViewCell {
	@objc private func choiseRoomButtonTapped() {
		delegate?.pressButtom()
	}
}

// MARK: - Main Element

private extension RoomTableViewCell {
	func createmMainStackView() -> UIStackView {
		let stackView = createStackView(left: .zero)
		stackView.backgroundColor = Theme.accentColor
		stackView.layer.cornerRadius = .zero
		stackView.isLayoutMarginsRelativeArrangement = true
		stackView.translatesAutoresizingMaskIntoConstraints = false
		return stackView
	}

	func createCarouselView() -> CarouselView {
		let carouselView = CarouselView()
		carouselView.layer.cornerRadius = Sizes.Medium.cornerRadius
		carouselView.clipsToBounds = true
		carouselView.translatesAutoresizingMaskIntoConstraints = false

		return carouselView
	}
}

// MARK: - Element

private extension RoomTableViewCell {
	func createStackView(
		top: CGFloat = Sizes.Medium.halfPadding,
		left: CGFloat = Sizes.Medium.halfPadding
	) -> UIStackView {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.alignment = .fill
		stackView.spacing = Sizes.Medium.halfPadding
		stackView.backgroundColor = Theme.backgroundColor
		stackView.layer.cornerRadius = Sizes.Medium.cornerRadius
		stackView.layoutMargins = UIEdgeInsets(
			top: top,
			left: left,
			bottom: top,
			right: left
		)
		stackView.isLayoutMarginsRelativeArrangement = true

		return stackView
	}

	func createLabel() -> UILabel {
		let label = UILabel()
		label.textColor = Theme.black
		label.numberOfLines = .zero

		return label
	}

	func createPaddingLabel(text: String) -> PaddingLabel {
		let label = PaddingLabel()
		label.text = text
		label.clipsToBounds = true
		label.textColor = Theme.gray
		label.backgroundColor = Theme.accentColor
		label.paddingLeft = Sizes.Medium.paddingText
		label.paddingRight = Sizes.Medium.paddingText
		label.paddingTop = Sizes.Medium.halfPaddingText
		label.paddingBottom = Sizes.Medium.halfPaddingText
		label.layer.cornerRadius = Sizes.Medium.halfCornerRadius
		label.font = UIFont.preferredFont(forTextStyle: .subheadline)

		return label
	}

	func createConfigurationButton() -> UIButton.Configuration {
		var configuration = UIButton.Configuration.borderedProminent()
		configuration.title = L10n.Room.aboutRoom
		configuration.image = UIImage(systemName: L10n.SystemImage.chevronRight)
		configuration.imagePlacement = .trailing
		configuration.baseBackgroundColor = Theme.blue.withAlphaComponent(Sizes.Alfa.button)
		configuration.cornerStyle = .large
		configuration.imagePadding = Sizes.Medium.padding
		configuration.titleAlignment = .trailing
		configuration.baseForegroundColor = Theme.blue

		return configuration
	}

	func createPriceLabel() -> UILabel {
		let numberFormatter = NumberFormatter()
		numberFormatter.numberStyle = .currency
		numberFormatter.maximumFractionDigits = .zero
		numberFormatter.locale = Locale(identifier: L10n.Hotel.localization)

		guard let apartment,
		      let formattedNumber = numberFormatter.string(from: NSNumber(value: apartment.price))
		else { return UILabel() }

		let label = createLabel()
		label.text = L10n.Hotel.fron + formattedNumber
		label.font = UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .title2).pointSize)

		return label
	}

	func createChoiseRoomButton() -> UIButton {
		var configuration = UIButton.Configuration.filled()
		configuration.title = L10n.Room.chooseNumber
		configuration.baseBackgroundColor = Theme.blue
		configuration.cornerStyle = .large

		let button = UIButton(configuration: configuration)
		button.addTarget(self, action: #selector(choiseRoomButtonTapped), for: .touchUpInside)

		return button
	}

	func createPeculiaritiesVerticalStackView() -> UIStackView {
		let peculiaritiesVerticalStackView = createStackView(top: .zero, left: .zero)
		peculiaritiesVerticalStackView.alignment = .leading

		let peculiaritiesHorizontalStackView = createStackView(top: .zero, left: .zero)
		peculiaritiesHorizontalStackView.axis = .horizontal

		var index = Int.zero
		apartment?.peculiarities.forEach { text in
			if text.count >= Sizes.Medium.maxTextCount + 1 || index >= Sizes.Medium.maxTextIndex {
				peculiaritiesVerticalStackView.addArrangedSubview(createPaddingLabel(text: text))
			} else {
				peculiaritiesHorizontalStackView.addArrangedSubview(createPaddingLabel(text: text))
			}
			index += 1
		}

		peculiaritiesVerticalStackView.addArrangedSubview(peculiaritiesHorizontalStackView)

		return peculiaritiesVerticalStackView
	}
}
