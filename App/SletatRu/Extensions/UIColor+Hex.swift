//
//  UIColor+Hex.swift
//  SletatRu
//
//  Created by Constantin on 06.09.2023.
//

import UIKit

extension UIColor {
	convenience init(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8 = 255) {
		self.init(
			red: CGFloat(red) / 255.0,
			green: CGFloat(green) / 255.0,
			blue: CGFloat(blue) / 255.0,
			alpha: CGFloat(alpha) / 255.0
		)
	}

	convenience init(hex: Int) {
		if hex > 0xFFFFFF {
			self.init(
				red: UInt8((hex >> 24) & 0xFF),
				green: UInt8((hex >> 16) & 0xFF),
				blue: UInt8((hex >> 8) & 0xFF),
				alpha: UInt8(hex & 0xFF)
			)
		} else {
			self.init(
				red: UInt8((hex >> 16) & 0xFF),
				green: UInt8((hex >> 8) & 0xFF),
				blue: UInt8(hex & 0xFF)
			)
		}
	}

	convenience init(hex: String) {
		var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
		hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

		let hex = UInt(hexSanitized, radix: 16) ?? 0

		self.init(hex: Int(hex))
	}
}
