//
//  UIView+Extensions.swift
//  SletatRu
//
//  Created by Constantin on 07.09.2023.
//

import UIKit

extension UIView {
	func addSubviews(_ views: [UIView]) {
		views.forEach { addSubview($0) }
	}
}
