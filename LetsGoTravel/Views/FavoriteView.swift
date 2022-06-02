//
//  FavoriteView.swift
//  LetsGoTravel
//
//  Created by Natali Malich
//

import UIKit

class FavoriteView: UIView {
    
    // MARK: - UI Elements
    private lazy var bookmarkImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.appSymbol(.bookmark)?.withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.appColor(.blueDark)
        image.activateAnchors()
        return image
    }()
    
    // MARK: - Initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: - Funcs
    func paintBookmarkImage() {
        self.bookmarkImage.image = UIImage.appSymbol(.bookmarkFill)?.withRenderingMode(.alwaysTemplate)
    }
    
    func unPaintBookmarkImage() {
        self.bookmarkImage.image = UIImage.appSymbol(.bookmark)?.withRenderingMode(.alwaysTemplate)
    }
}

    // MARK: - Setup Views
extension FavoriteView {
    private func setupViews() {
        self.addSubview(bookmarkImage)
    }
}

    // MARK: - Setup Constraints
extension FavoriteView {
    private func setupConstraints() {
        [
            bookmarkImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            bookmarkImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            bookmarkImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            bookmarkImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            bookmarkImage.widthAnchor.constraint(equalToConstant: 30),
            bookmarkImage.heightAnchor.constraint(equalTo: bookmarkImage.widthAnchor)
        ]
        .forEach { $0.isActive = true }
    }
}
