//
//  BookingView.swift
//  SletatRu
//
//  Created by Constantin on 18.09.2023.
//

import UIKit

// MARK: - BookingView

class BookingView: UIView {
	// MARK: - Internal properties

	weak var delegate: IBookingViewControllerDelegate?

	// MARK: - Private properties

	private var booking: Booking?
	private var indexTourist = Int.zero
	private lazy var numberToWord = createNumberToWord()
	private lazy var numberFormatter = createNumberFormatter()
	private lazy var scrollView = createScrollView()
	private lazy var mainStackView = createMainStackView()

	// MARK: - Life Cycle

	init(booking: Booking?) {
		super.init(frame: .zero)
		self.booking = booking

		setupView()
		createHotelView()
		createBookingView()
		createShoppingView()
		createTouristsView()
		createPriceView()
		createButtonView()
	}

	required init?(coder _: NSCoder) {
		fatalError(L10n.FatalError.required)
	}

	// MARK: - Private methods

	private func setupView() {
		backgroundColor = Theme.backgroundColor
		addSubview(scrollView)
		scrollView.addSubview(mainStackView)

		NSLayoutConstraint.activate([
			scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
			scrollView.topAnchor.constraint(equalTo: topAnchor),
			scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

			mainStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
			mainStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
			mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
			mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
		])

		scrollView.contentSize = mainStackView.bounds.size
	}

	private func createHotelView() {
		guard let booking else { return }

		let hotelStackView = createStackView(left: Sizes.Medium.padding)
		hotelStackView.alignment = .leading

		let ratinHotelgtext = L10n.Hotel.star + " \(booking.horating) " + booking.ratingName
		let ratingHotelLabel = createPaddingLabel(text: ratinHotelgtext)
		ratingHotelLabel.textColor = Theme.ratingText
		ratingHotelLabel.backgroundColor = Theme.rating

		let nameHotelLabel = createLabel()
		nameHotelLabel.text = booking.hotelName
		nameHotelLabel.font = UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .title3).pointSize)

		let mapHotelButton = UIButton(type: .system)
		mapHotelButton.setTitle(booking.hotelAdress, for: .normal)
		mapHotelButton.setTitleColor(Theme.blue, for: .normal)

		mainStackView.addArrangedSubview(hotelStackView)
		hotelStackView.addArrangedSubviews([
			ratingHotelLabel,
			nameHotelLabel,
			mapHotelButton
		])
	}

	private func createBookingView() {
		guard let booking else { return }

		let bookingStackView = createStackView(left: Sizes.Medium.padding)

		mainStackView.addArrangedSubview(bookingStackView)
		bookingStackView.addArrangedSubviews([
			createLabelStackView(
				infoText: L10n.Booking.Hotel.departureFrom,
				apiText: booking.departure,
				textAlignment: .left
			),
			createLabelStackView(
				infoText: L10n.Booking.Hotel.countryCity,
				apiText: booking.arrivalCountry,
				textAlignment: .left
			),
			createLabelStackView(
				infoText: L10n.Booking.Hotel.dates,
				apiText: "\(booking.tourDateStart) - \(booking.tourDateStop)",
				textAlignment: .left
			),
			createLabelStackView(
				infoText: L10n.Booking.Hotel.numberNights,
				apiText: "\(booking.numberOfNights)" + L10n.Booking.Hotel.nights,
				textAlignment: .left
			),
			createLabelStackView(
				infoText: L10n.Booking.Hotel.hotel,
				apiText: booking.hotelName,
				textAlignment: .left
			),
			createLabelStackView(
				infoText: L10n.Booking.Hotel.number,
				apiText: booking.room,
				textAlignment: .left
			),
			createLabelStackView(
				infoText: L10n.Booking.Hotel.nutrition,
				apiText: booking.nutrition,
				textAlignment: .left
			)
		])
	}

	private func createShoppingView() {
		let stackView = createStackView(left: Sizes.Medium.padding)

		let informatioAboutBuyerLabel = createLabel()
		informatioAboutBuyerLabel.text = L10n.Booking.Tourist.informatioAboutBuyer
		informatioAboutBuyerLabel.font = UIFont.preferredFont(forTextStyle: .headline)

		let nonDisclosureLabel = createLabel()
		nonDisclosureLabel.text = L10n.Booking.Tourist.nonDisclosure
		nonDisclosureLabel.textColor = Theme.gray
		nonDisclosureLabel.textAlignment = .justified
		nonDisclosureLabel.font = UIFont.preferredFont(forTextStyle: .footnote)

		mainStackView.addArrangedSubview(stackView)
		stackView.addArrangedSubviews([
			informatioAboutBuyerLabel,
			createTextStackView(text: L10n.Booking.Tourist.phoneNumber),
			createTextStackView(text: L10n.Booking.Tourist.mail),
			nonDisclosureLabel
		])
	}

	private func createTouristsView() {
		mainStackView.addArrangedSubviews([
			createButtonStackView(text: numberToWord[indexTourist], imageString: L10n.SystemImage.chevronUp),
			createButtonStackView(text: L10n.Booking.Guest.addTourist, imageString: L10n.SystemImage.plus)
		])
	}

	private func createPriceView() {
		guard let booking else { return }

		let price = booking.tourPrice + booking.fuelCharge + booking.serviceCharge

		guard let formattedTourPrice = numberFormatter.string(for: NSNumber(value: booking.tourPrice)) else { return }
		guard let formattedFuelCharge = numberFormatter.string(for: NSNumber(value: booking.fuelCharge)) else { return }
		guard let formattedServiceCharge = numberFormatter.string(for: NSNumber(value: booking.serviceCharge)) else { return }
		guard let formattedPrice = numberFormatter.string(for: NSNumber(value: price)) else { return }

		let stackView = createStackView(left: Sizes.Medium.padding)

		mainStackView.addArrangedSubview(stackView)
		stackView.addArrangedSubviews([
			createLabelStackView(infoText: L10n.Booking.Tour.tour, apiText: formattedTourPrice, textAlignment: .right),
			createLabelStackView(infoText: L10n.Booking.Tour.fuel, apiText: formattedFuelCharge, textAlignment: .right),
			createLabelStackView(infoText: L10n.Booking.Tour.service, apiText: formattedServiceCharge, textAlignment: .right),
			createLabelStackView(infoText: L10n.Booking.Tour.paid, apiText: formattedPrice, textAlignment: .right)
		])
	}

	private func createButtonView() {
		guard let booking else { return }

		let stackView = createStackView()
		let price = booking.tourPrice + booking.fuelCharge + booking.serviceCharge

		guard let formattedPrice = numberFormatter.string(for: NSNumber(value: price)) else { return }

		var configuration = UIButton.Configuration.filled()
		configuration.title = L10n.Booking.Guest.button + formattedPrice
		configuration.baseBackgroundColor = Theme.blue
		configuration.cornerStyle = .large

		let button = UIButton(configuration: configuration)
		button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

		mainStackView.addArrangedSubview(stackView)
		stackView.addArrangedSubview(button)
	}
}

// MARK: UITextFieldDelegate

extension BookingView: UITextFieldDelegate {
	func textFieldDidEndEditing(_ textField: UITextField) {
		guard let stackView = textField.superview as? UIStackView else { return }
		guard let label = stackView.arrangedSubviews.first else { return }
		if textField.hasText {
			label.isHidden = false
		} else {
			label.isHidden = true
		}
	}

	func textField(
		_ textField: UITextField,
		shouldChangeCharactersIn range: NSRange,
		replacementString string: String
	) -> Bool {
		let fullString = (textField.text ?? "") + string

		switch textField.placeholder {
		case L10n.Booking.Tourist.phoneNumber:
			textField.text = format(phoneNumber: fullString, shouldRemoveLastDigit: range.length == 1)
		default:
			textField.text = fullString
		}
		return false
	}

	private func format(phoneNumber: String, shouldRemoveLastDigit: Bool) -> String {
		let maxNumberCount = 11
		guard let regex = try? NSRegularExpression(pattern: "[\\+\\s-\\(\\)]", options: .caseInsensitive) else { return "" }

		guard !(shouldRemoveLastDigit && phoneNumber.count <= 2) else { return "+" }

		let range = NSString(string: phoneNumber).range(of: phoneNumber)
		var number = regex.stringByReplacingMatches(in: phoneNumber, options: [], range: range, withTemplate: "")

		if number.count > maxNumberCount {
			let maxIndex = number.index(number.startIndex, offsetBy: maxNumberCount)
			number = String(number[number.startIndex ..< maxIndex])
		}

		if shouldRemoveLastDigit {
			let maxIndex = number.index(number.startIndex, offsetBy: number.count - 1)
			number = String(number[number.startIndex ..< maxIndex])
		}

		let maxIndex = number.index(number.startIndex, offsetBy: number.count)
		let regRange = number.startIndex ..< maxIndex

		if number.count < 7 {
			let pattern = "(\\d)(\\d{3})(\\d+)"
			number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3", options: .regularExpression, range: regRange)
		} else {
			let pattern = "(\\d)(\\d{3})(\\d{3})(\\d{2})(\\d+)"
			number = number.replacingOccurrences(
				of: pattern,
				with: "$1 ($2) $3-$4-$5",
				options: .regularExpression,
				range: regRange
			)
		}

		return "+" + number
	}
}

// MARK: - Actions

private extension BookingView {
	@objc func addTourist(_ sender: UIButton) {
		if indexTourist > 3 { return }
		guard let stackView = sender.superview as? UIStackView else { return }
		guard let stackView = stackView.superview as? UIStackView else { return }
		guard let stackView = stackView.superview as? UIStackView else { return }
		indexTourist += 1

		stackView.insertArrangedSubview(
			createButtonStackView(text: numberToWord[indexTourist], imageString: L10n.SystemImage.chevronUp),
			at: stackView.arrangedSubviews.count - 3
		)
	}

	@objc func tappedTourist(_ sender: UIButton) {
		guard let stackView = sender.superview as? UIStackView else { return }
		guard let stackView = stackView.superview as? UIStackView else { return }
		guard let stackView = stackView.arrangedSubviews.last as? UIStackView else { return }

		if sender.imageView?.image == UIImage(systemName: L10n.SystemImage.chevronDown) {
			sender.setImage(UIImage(systemName: L10n.SystemImage.chevronUp), for: .normal)
			stackView.arrangedSubviews.forEach { element in
				element.isHidden = false
			}
		} else {
			sender.setImage(UIImage(systemName: L10n.SystemImage.chevronDown), for: .normal)
			stackView.arrangedSubviews.forEach { element in
				element.isHidden = true
			}
		}
	}

	@objc func buttonTapped(_: UIButton) {
		delegate?.pressButtom()
	}
}

// MARK: - Main Element

private extension BookingView {
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
		stackView.layer.cornerRadius = .zero
		stackView.backgroundColor = Theme.accentColor
		stackView.translatesAutoresizingMaskIntoConstraints = false

		return stackView
	}
}

// MARK: - Element

private extension BookingView {
	func createNumberToWord() -> [String] {
		let array = [
			L10n.Booking.IndexTourist.one,
			L10n.Booking.IndexTourist.two,
			L10n.Booking.IndexTourist.three,
			L10n.Booking.IndexTourist.four,
			L10n.Booking.IndexTourist.five
		]

		return array
	}

	func createNumberFormatter() -> Formatter {
		let numberFormatter = NumberFormatter()
		numberFormatter.numberStyle = .currency
		numberFormatter.maximumFractionDigits = .zero
		numberFormatter.locale = Locale(identifier: L10n.Hotel.localization)

		return numberFormatter
	}

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

	private func createPaddingLabel(text: String) -> PaddingLabel {
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

	private func createLabel() -> UILabel {
		let label = UILabel()
		label.textColor = Theme.black
		label.numberOfLines = .zero
		label.font = UIFont.preferredFont(forTextStyle: .subheadline)

		return label
	}

	func createLabelStackView(infoText: String, apiText: String, textAlignment: NSTextAlignment) -> UIStackView {
		let stackView = createStackView(top: .zero, left: .zero)
		stackView.axis = .horizontal

		let infoLabel = createLabel()
		infoLabel.text = infoText
		infoLabel.textColor = Theme.gray

		let apiLabel = createLabel()
		apiLabel.text = apiText
		apiLabel.textAlignment = textAlignment

		guard let booking else { return UIStackView() }
		let price = booking.tourPrice + booking.fuelCharge + booking.serviceCharge

		guard let formattedTourPrice = numberFormatter.string(for: NSNumber(value: price)) else { return UIStackView() }

		if formattedTourPrice == apiText {
			apiLabel.textColor = Theme.blue
			apiLabel.font = UIFont.boldSystemFont(ofSize: apiLabel.font.pointSize)
		}

		stackView.addArrangedSubviews([
			infoLabel,
			apiLabel
		])

		infoLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.4).isActive = true

		return stackView
	}

	func createTextStackView(text: String) -> UIStackView {
		let stackView = createStackView()
		stackView.layer.cornerRadius = Sizes.Medium.halfCornerRadius
		stackView.spacing = .zero
		stackView.backgroundColor = Theme.accentColor

		let label = createLabel()
		label.isHidden = true
		label.text = text
		label.textColor = Theme.gray
		label.font = UIFont.preferredFont(forTextStyle: .caption2)

		let textField = UITextField()
		textField.placeholder = text
		textField.delegate = self

		switch text {
		case
			L10n.Booking.Tourist.phoneNumber,
			L10n.Booking.Guest.dateBirth,
			L10n.Booking.Guest.passportNumber,
			L10n.Booking.Guest.validityPeriodPassport:
			textField.keyboardType = .numberPad
		case L10n.Booking.Tourist.mail:
			textField.keyboardType = .emailAddress
		default:
			break
		}

		stackView.addArrangedSubviews([
			label,
			textField
		])

		return stackView
	}

	private func createTouristStackView() -> UIStackView {
		let stackView = createStackView()

		stackView.addArrangedSubviews([
			createTextStackView(text: L10n.Booking.Guest.firstName),
			createTextStackView(text: L10n.Booking.Guest.lastName),
			createTextStackView(text: L10n.Booking.Guest.dateBirth),
			createTextStackView(text: L10n.Booking.Guest.citizenship),
			createTextStackView(text: L10n.Booking.Guest.passportNumber),
			createTextStackView(text: L10n.Booking.Guest.validityPeriodPassport)
		])

		return stackView
	}

	private func createButtonStackView(text: String, imageString: String) -> UIStackView {
		let stackView = createStackView(top: .zero)
		stackView.spacing = .zero

		let buttonStackView = createStackView()
		buttonStackView.axis = .horizontal
		buttonStackView.distribution = .equalSpacing

		let label = createLabel()
		label.text = text
		label.font = UIFont.preferredFont(forTextStyle: .headline)

		var configuration = UIButton.Configuration.borderedProminent()
		configuration.image = UIImage(systemName: imageString)
		configuration.cornerStyle = .large

		if imageString == L10n.SystemImage.plus {
			configuration.baseBackgroundColor = Theme.blue
			configuration.baseForegroundColor = Theme.white
		} else {
			configuration.baseBackgroundColor = Theme.blue.withAlphaComponent(Sizes.Alfa.button)
			configuration.baseForegroundColor = Theme.blue
		}

		let button = UIButton(configuration: configuration)

		stackView.addArrangedSubview(buttonStackView)

		buttonStackView.addArrangedSubviews([
			label,
			button
		])

		if imageString == L10n.SystemImage.plus {
			button.addTarget(self, action: #selector(addTourist(_:)), for: .touchUpInside)
		} else {
			button.addTarget(self, action: #selector(tappedTourist(_:)), for: .touchUpInside)
			stackView.addArrangedSubview(createTouristStackView())
		}

		return stackView
	}
}
