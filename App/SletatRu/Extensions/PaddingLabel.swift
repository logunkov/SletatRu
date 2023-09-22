//
//  PaddingLabel.swift
//  SletatRu
//
//  Created by Constantin on 08.09.2023.
//

import Foundation
import UIKit

@IBDesignable
class PaddingLabel: UILabel {
	var textEdgeInsets = UIEdgeInsets.zero {
		didSet { invalidateIntrinsicContentSize() }
	}

	override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
		let insetRect = bounds.inset(by: textEdgeInsets)
		let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
		let invertedInsets = UIEdgeInsets(
			top: -textEdgeInsets.top,
			left: -textEdgeInsets.left,
			bottom: -textEdgeInsets.bottom,
			right: -textEdgeInsets.right
		)
		return textRect.inset(by: invertedInsets)
	}

	override func drawText(in rect: CGRect) {
		super.drawText(in: rect.inset(by: textEdgeInsets))
	}

	@IBInspectable
	var paddingLeft: CGFloat {
		get { textEdgeInsets.left }
		set { textEdgeInsets.left = newValue }
	}

	@IBInspectable
	var paddingRight: CGFloat {
		get { textEdgeInsets.right }
		set { textEdgeInsets.right = newValue }
	}

	@IBInspectable
	var paddingTop: CGFloat {
		get { textEdgeInsets.top }
		set { textEdgeInsets.top = newValue }
	}

	@IBInspectable
	var paddingBottom: CGFloat {
		get { textEdgeInsets.bottom }
		set { textEdgeInsets.bottom = newValue }
	}
}
