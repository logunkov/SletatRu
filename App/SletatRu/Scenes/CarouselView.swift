//
//  CarouselView.swift
//  SletatRu
//
//  Created by Constantin on 07.09.2023.
//

import UIKit

// MARK: - CarouselView

final class CarouselView: UIView {
	// MARK: - Private properties

	private lazy var scrollView = createScrollView()
	private lazy var pageControl = createPageControl()
	private lazy var activityIndicatorView = createActivityIndicatorView()
	private var imageViews = [UIImageView]()

	// MARK: - Life Cycle

	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	required init?(coder _: NSCoder) {
		fatalError(L10n.FatalError.required)
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		let imageWidth: CGFloat = bounds.width
		let imageHeight: CGFloat = bounds.height

		for (index, imageView) in imageViews.enumerated() {
			let xPosition = imageWidth * CGFloat(index)
			imageView.frame = CGRect(x: xPosition, y: .zero, width: imageWidth, height: imageHeight)
		}

		scrollView.frame = bounds
		scrollView.contentSize = CGSize(width: imageWidth * CGFloat(imageViews.count), height: imageHeight)
	}

	// MARK: - Internal methods

	// Устанавливаем картинки в imageViews.
	func setImages(_ images: [UIImage]) {
		activityIndicatorView.stopAnimating()

		for imageView in imageViews {
			imageView.removeFromSuperview()
		}
		imageViews.removeAll()

		for image in images {
			let imageView = UIImageView(image: image)
			imageView.contentMode = .scaleAspectFill
			imageView.clipsToBounds = true
			imageView.frame = bounds
			imageViews.append(imageView)
			scrollView.addSubview(imageView)
		}

		pageControl.numberOfPages = images.count

		layoutSubviews()
	}

	// MARK: - Private methods

	private func createScrollView() -> UIScrollView {
		let scrollView = UIScrollView(frame: .zero)
		scrollView.isPagingEnabled = true
		scrollView.bounces = false
		scrollView.showsVerticalScrollIndicator = false
		scrollView.showsHorizontalScrollIndicator = false
		scrollView.translatesAutoresizingMaskIntoConstraints = false

		return scrollView
	}

	private func createPageControl() -> UIPageControl {
		let pageControl = UIPageControl()
		pageControl.currentPageIndicatorTintColor = Theme.black
		pageControl.pageIndicatorTintColor = Theme.accentColor
		pageControl.backgroundColor = Theme.white
		pageControl.layer.cornerRadius = Sizes.Medium.halfCornerRadius
		pageControl.translatesAutoresizingMaskIntoConstraints = false

		return pageControl
	}

	private func createActivityIndicatorView() -> UIActivityIndicatorView {
		let activityIndicator = UIActivityIndicatorView(style: .large)
		activityIndicator.color = Theme.blue
		activityIndicator.startAnimating()
		activityIndicator.translatesAutoresizingMaskIntoConstraints = false

		return activityIndicator
	}

	private func setupView() {
		backgroundColor = Theme.accentColor
		scrollView.delegate = self

		addSubviews([
			activityIndicatorView,
			scrollView,
			pageControl,
		])

		NSLayoutConstraint.activate([
			pageControl.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Sizes.Medium.halfPadding),
			pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
			activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
			activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor),
		])
	}
}

// MARK: UIScrollViewDelegate

extension CarouselView: UIScrollViewDelegate {
	// MARK: - Internal methods

	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		let pageIndex = round(scrollView.contentOffset.x / bounds.width)
		pageControl.currentPage = Int(pageIndex)
	}
}
