//
//  UIStackView+Extension.swift
//  SletatRu
//
//  Created by Constantin on 07.09.2023.
//

import UIKit

extension UIStackView {
	func addArrangedSubviews(_ views: [UIView]) {
		views.forEach { addArrangedSubview($0) }
	}
}
