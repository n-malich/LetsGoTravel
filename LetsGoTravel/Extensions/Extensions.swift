//
//  Extensions.swift
//  LetsGoTravel
//
//  Created by Natali Malich
//

import UIKit

    // MARK: - UIView
extension UIView {
    public func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }

    public func activateAnchors() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}

    // MARK: - UIColor
enum AssetsColor {
case blueDark
case blueLight
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor? {
        switch name {
        case .blueDark:
            return UIColor(named: "blueDarkApp", in: .main, compatibleWith: .current)
        case .blueLight:
            return UIColor(named: "blueLightApp", in: .main, compatibleWith: .current)
        }
    }
}

    // MARK: - UIImage
enum AssetsSymbol {
    case arrowRightArrowLeft
    case bookmark
    case bookmarkFill
    case airplaneTakeOffLeft
    case airplaneTakeOffRight
    case horizontalline
}

extension UIImage {
    static func appSymbol(_ name: AssetsSymbol) -> UIImage? {
        switch name {
        case .arrowRightArrowLeft:
            return UIImage(named: "arrow.right.arrow.left", in: .main, compatibleWith: .current)
        case .bookmark:
            return UIImage(systemName: "bookmark")
        case .bookmarkFill:
            return UIImage(systemName: "bookmark.fill")
        case .airplaneTakeOffLeft:
            return UIImage(named: "airplane.take.off.left", in: .main, compatibleWith: .current)
        case .airplaneTakeOffRight:
            return UIImage(named: "airplane.take.off.right", in: .main, compatibleWith: .current)
        case .horizontalline:
            return UIImage(named: "horizontal.line", in: .main, compatibleWith: .current)
        }
    }
}
