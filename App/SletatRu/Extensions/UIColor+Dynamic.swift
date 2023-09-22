//
//  UIColor+Dynamic.swift
//  SletatRu
//
//  Created by Constantin on 06.09.2023.
//

import UIKit

extension UIColor {
	static func color(light: UIColor, dark: UIColor, highContrastLight: UIColor, highContrastDark: UIColor) -> UIColor {
		if #available(iOS 13, *) {
			return .init { traitCollection in
				let isDarkMode = traitCollection.userInterfaceStyle == .dark
				let isHighContrast = traitCollection.accessibilityContrast == .high

				switch (isDarkMode, isHighContrast) {
				case (true, false):
					return dark
				case (true, true):
					return highContrastDark
				case (false, true):
					return light
				case (false, false):
					return highContrastLight
				}
			}
		} else {
			return light
		}
	}

	static func color(light: UIColor, dark: UIColor) -> UIColor {
		if #available(iOS 13, *) {
			return .init { traitCollection in
				traitCollection.userInterfaceStyle == .dark ? dark : light
			}
		} else {
			return light
		}
	}
}
