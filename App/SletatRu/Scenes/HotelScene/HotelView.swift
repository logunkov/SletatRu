//
//  HotelView.swift
//  SletatRu
//
//  Created by Constantin on 07.09.2023.
//

import UIKit

// MARK: - HotelView

class HotelView: UIView {
	// MARK: - Internal properties

	weak var delegate: IHotelViewControllerDelegate?

	// MARK: - Private properties

	private var hotel: Hotel?
	private lazy var scrollView = createScrollView()
	private lazy var mainStackView = createMainStackView()
	private lazy var carouselView = createCarouselView()

	// MARK: - Life Cycle

	init(hotel: Hotel?) {
		super.init(frame: .zero)
		self.hotel = hotel

		setupView()
		createHotelView()
		createAboutHotelView()
		createButtonView()
		loadImage()
	}

	required init?(coder _: NSCoder) {
		fatalError(L10n.FatalError.required)
	}

	// MARK: - Private methods

	private func setupView() {
		backgroundColor = Theme.backgroundColor
		addSubview(scrollView)
		scrollView.addSubview(mainStackView)
		scrollView.contentSize = mainStackView.bounds.size

		NSLayoutConstraint.activate([
			scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
			scrollView.topAnchor.constraint(equalTo: topAnchor),
			scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

			mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
			mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),

			carouselView.heightAnchor.constraint(equalTo: carouselView.widthAnchor, multiplier: Sizes.Medium.multiplier),
		])
	}

	private func createHotelView() {
		guard let hotel else { return }

		let hotelStackView = createStackView()
		hotelStackView.spacing = .zero

		let nameHotelStackView = createStackView()
		nameHotelStackView.alignment = .leading

		let ratinHotelgtext = L10n.Hotel.star + " \(hotel.rating) " + hotel.ratingName
		let ratingHotelLabel = createPaddingLabel(text: ratinHotelgtext)
		ratingHotelLabel.textColor = Theme.ratingText
		ratingHotelLabel.backgroundColor = Theme.rating

		let nameHotelLabel = createLabel()
		nameHotelLabel.text = hotel.name
		nameHotelLabel.font = UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .title3).pointSize)

		let mapHotelButton = UIButton(type: .system)
		mapHotelButton.setTitle(hotel.adress, for: .normal)
		mapHotelButton.setTitleColor(Theme.blue, for: .normal)

		let priceHotelStackView = createStackView(top: .zero)
		priceHotelStackView.alignment = .center
		priceHotelStackView.axis = .horizontal

		let numberFormatter = NumberFormatter()
		numberFormatter.numberStyle = .currency
		numberFormatter.maximumFractionDigits = .zero
		numberFormatter.locale = Locale(identifier: L10n.Hotel.localization)

		guard let formattedNumber = numberFormatter.string(from: NSNumber(value: hotel.minimalPrice)) else { return }

		let priceHotelLabel = createLabel()
		priceHotelLabel.text = L10n.Hotel.fron + formattedNumber
		priceHotelLabel.font = UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .title1).pointSize)

		let flyHotelLabel = createLabel()
		flyHotelLabel.text = hotel.priceForIt
		flyHotelLabel.textColor = Theme.gray
		flyHotelLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)

		mainStackView.addArrangedSubview(hotelStackView)

		hotelStackView.addArrangedSubviews([
			carouselView,
			nameHotelStackView,
			priceHotelStackView,
		])

		nameHotelStackView.addArrangedSubviews([
			ratingHotelLabel,
			nameHotelLabel,
			mapHotelButton,
		])

		priceHotelStackView.addArrangedSubviews([
			priceHotelLabel,
			flyHotelLabel,
		])
	}

	private func createAboutHotelView() {
		guard let hotel else { return }

		let aboutHotelStackView = createStackView(left: Sizes.Medium.padding)

		let aboutHotelLabel = createLabel()
		aboutHotelLabel.text = L10n.Hotel.aboutHotel
		aboutHotelLabel.font = UIFont.preferredFont(forTextStyle: .headline)

		let descriptionAboutHotelLabel = createLabel()
		descriptionAboutHotelLabel.textAlignment = .justified
		descriptionAboutHotelLabel.numberOfLines = .zero
		descriptionAboutHotelLabel.text = hotel.aboutTheHotel.description
		descriptionAboutHotelLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)

		let peculiaritiesVerticalStackView = createStackView(top: .zero, left: .zero)
		peculiaritiesVerticalStackView.alignment = .leading

		let peculiaritiesHorizontalStackView = createStackView(top: .zero, left: .zero)
		peculiaritiesHorizontalStackView.axis = .horizontal

		hotel.aboutTheHotel.peculiarities.forEach { text in
			if text.count >= Sizes.Medium.maxTextCount {
				peculiaritiesVerticalStackView.addArrangedSubview(createPaddingLabel(text: text))
			} else {
				peculiaritiesHorizontalStackView.addArrangedSubview(createPaddingLabel(text: text))
			}
		}

		let transitionAboutHotelStackView = createStackView(top: .zero, left: .zero)

		mainStackView.addArrangedSubview(aboutHotelStackView)

		aboutHotelStackView.addArrangedSubviews([
			aboutHotelLabel,
			peculiaritiesVerticalStackView,
			descriptionAboutHotelLabel,
			transitionAboutHotelStackView,
		])

		peculiaritiesVerticalStackView.addArrangedSubview(peculiaritiesHorizontalStackView)

		transitionAboutHotelStackView.addArrangedSubviews([
			createTransitionStackView(
				imageString: L10n.SystemImage.face,
				title: L10n.HotelButton.conveniences,
				subtitle: L10n.HotelButton.mostNecessary
			),
			createTransitionStackView(
				imageString: L10n.SystemImage.checkmark,
				title: L10n.HotelButton.included,
				subtitle: L10n.HotelButton.mostNecessary
			),
			createTransitionStackView(
				imageString: L10n.SystemImage.xmark,
				title: L10n.HotelButton.notIncluded,
				subtitle: L10n.HotelButton.mostNecessary
			),
		])
	}

	private func createButtonView() {
		let selectionStackView = createStackView()

		var configuration = UIButton.Configuration.filled()
		configuration.title = L10n.Hotel.button
		configuration.baseBackgroundColor = Theme.blue
		configuration.cornerStyle = .large

		let buttonSelectionHotelView = UIButton(configuration: configuration)
		buttonSelectionHotelView.addTarget(self, action: #selector(buttonSelectionHotelTapped), for: .touchUpInside)

		mainStackView.addArrangedSubview(selectionStackView)
		selectionStackView.addArrangedSubview(buttonSelectionHotelView)
	}

	private func loadImage() {
		var images = [UIImage]()
		let session = URLSession.shared
		let urls = hotel?.imageUrls
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

private extension HotelView {
	@objc func buttonSelectionHotelTapped() {
		guard let hotel else { return }
		delegate?.pressButtom(hotel: hotel.name)
	}
}

// MARK: - Main Element

private extension HotelView {
	func createScrollView() -> UIScrollView {
		let scrollView = UIScrollView(frame: .zero)
		scrollView.bounces = false
		scrollView.showsVerticalScrollIndicator = false
		scrollView.showsHorizontalScrollIndicator = false
		scrollView.translatesAutoresizingMaskIntoConstraints = false

		return scrollView
	}

	func createMainStackView() -> UIStackView {
		let stackView = createStackView(left: .zero)
		stackView.backgroundColor = Theme.accentColor
		stackView.layer.cornerRadius = .zero
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

private extension HotelView {
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

	func createTransitionStackView(imageString: String, title: String?, subtitle: String?) -> UIStackView {
		let stackView = createStackView()
		stackView.distribution = .equalSpacing
		stackView.axis = .horizontal
		stackView.backgroundColor = Theme.accentColor
		stackView.addArrangedSubviews([
			createButton(
				imageString: imageString,
				title: title,
				subtitle: subtitle
			),
			createButton(
				imageString: L10n.SystemImage.chevronRight,
				title: nil,
				subtitle: nil
			),
		])

		stackView.layer.borderWidth = Sizes.Medium.borderWidth
		stackView.layer.borderColor = Theme.gray.cgColor

		return stackView
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

	func createLabel() -> UILabel {
		let label = UILabel()
		label.textColor = Theme.black
		label.numberOfLines = .zero

		return label
	}

	func createButton(imageString: String, title: String?, subtitle: String?) -> UIButton {
		var configuration = UIButton.Configuration.borderedProminent()
		configuration.title = title
		configuration.subtitle = subtitle
		configuration.image = UIImage(systemName: imageString)
		configuration.baseBackgroundColor = .clear
		configuration.cornerStyle = .large
		configuration.imagePadding = Sizes.Medium.padding
		configuration.titleAlignment = .leading
		configuration.baseForegroundColor = Theme.black

		return UIButton(configuration: configuration)
	}
}
