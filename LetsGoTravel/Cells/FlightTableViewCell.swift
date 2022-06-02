//
//  FlightTableViewCell.swift
//  LetsGoTravel
//
//  Created by Natali Malich
//

import UIKit

class FlightTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var searchTokenFlights = String() {
        didSet {
            if FavoriteManager.shared.checkFlightStatus(token: self.searchTokenFlights) {
                favoriteView.paintBookmarkImage()
            } else {
                favoriteView.unPaintBookmarkImage()
            }
        }
    }
    
    // MARK: - UI Elements
    private lazy var wrapperView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.appColor(.blueLight)
        view.layer.cornerRadius = 10
        view.activateAnchors()
        return view
    }()
    
    private lazy var departureCityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.activateAnchors()
        return label
    }()
    
    private lazy var departureCityCodeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .black
        label.activateAnchors()
        return label
    }()
    
    private lazy var departureDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.activateAnchors()
        return label
    }()
    
    private lazy var arrivalCityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.activateAnchors()
        return label
    }()
    
    private lazy var arrivalCityCodeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .black
        label.activateAnchors()
        return label
    }()
    
    private lazy var returnDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .right
        label.textColor = .black
        label.activateAnchors()
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.appColor(.blueDark)
        label.activateAnchors()
        return label
    }()
    
    private lazy var arrowRightArrowLeftImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.appSymbol(.arrowRightArrowLeft)
        image.activateAnchors()
        return image
    }()
    
    lazy var favoriteView: FavoriteView = {
        let view = FavoriteView()
        view.activateAnchors()
        return view
    }()
    
    // MARK: - Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
        setUpGestureRecognizer()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    
    // MARK: - Data
    func showFlight(flight: Flight) {
        self.priceLabel.text = "\(flight.price) ₽"
        
        self.departureCityLabel.text = flight.startCity
        self.departureCityCodeLabel.text = (flight.startCityCode).uppercased()
        let departureDate = DateManager.shared.getDateFromString(dateString: flight.startDate)
        let departureString = DateManager.shared.getStringFromDate(date: departureDate ?? Date(), dateFormat: "dd.MM.yyyy \nHH:mm")
        self.departureDateLabel.text = departureString
        
        self.arrivalCityLabel.text = flight.endCity
        self.arrivalCityCodeLabel.text = (flight.endCityCode).uppercased()
        let arrivalDate = DateManager.shared.getDateFromString(dateString: flight.endDate)
        let arrivalString = DateManager.shared.getStringFromDate(date: arrivalDate ?? Date(), dateFormat: "dd.MM.yyyy \nHH:mm")
        self.returnDateLabel.text = arrivalString
        
        self.searchTokenFlights = flight.searchToken
    }
}

    // MARK: - Setup Views
extension FlightTableViewCell {
    private func setupViews() {
        contentView.addSubview(wrapperView)
        wrapperView.addSubviews(departureCityLabel, departureCityCodeLabel, arrivalCityLabel, arrivalCityCodeLabel, departureDateLabel, returnDateLabel, priceLabel, arrowRightArrowLeftImage, favoriteView)
    }
}

    // MARK: - Setup Constraints
extension FlightTableViewCell {
    private func setupConstraints() {
        [
            wrapperView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            wrapperView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            wrapperView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            wrapperView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15),
            
            priceLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 15),
            priceLabel.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 15),
            
            departureCityLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            departureCityLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),
            
            departureCityCodeLabel.topAnchor.constraint(equalTo: departureCityLabel.bottomAnchor, constant: 3),
            departureCityCodeLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),
            
            departureDateLabel.topAnchor.constraint(equalTo: departureCityCodeLabel.bottomAnchor, constant: 10),
            departureDateLabel.leadingAnchor.constraint(equalTo: priceLabel.leadingAnchor),
            departureDateLabel.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -15),
            
            arrivalCityLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10),
            arrivalCityLabel.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -15),
            
            arrivalCityCodeLabel.topAnchor.constraint(equalTo: departureCityLabel.bottomAnchor, constant: 3),
            arrivalCityCodeLabel.trailingAnchor.constraint(equalTo: arrivalCityLabel.trailingAnchor),
            
            returnDateLabel.topAnchor.constraint(equalTo: departureCityCodeLabel.bottomAnchor, constant: 10),
            returnDateLabel.trailingAnchor.constraint(equalTo: arrivalCityLabel.trailingAnchor),
            returnDateLabel.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -15),
            
            arrowRightArrowLeftImage.centerYAnchor.constraint(equalTo: departureCityCodeLabel.centerYAnchor),
            arrowRightArrowLeftImage.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor),
            arrowRightArrowLeftImage.widthAnchor.constraint(equalToConstant: 40),
            arrowRightArrowLeftImage.heightAnchor.constraint(equalTo: arrowRightArrowLeftImage.widthAnchor, multiplier: 0.7),
            
            favoriteView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -9),
            favoriteView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
        ]
        .forEach {$0.isActive = true}
    }
}

// MARK: - Actions
extension FlightTableViewCell {
    func setUpGestureRecognizer() {
        let singleTapGestureOnBookmarkImage = UITapGestureRecognizer(target: self, action: #selector(singleTapGestureOnBookmarkImage))
        favoriteView.isUserInteractionEnabled = true
        favoriteView.addGestureRecognizer(singleTapGestureOnBookmarkImage)
    }
    
    @objc private func singleTapGestureOnBookmarkImage(_ tapGesture: UITapGestureRecognizer) {
        FavoriteManager.shared.addToFavorites(token: self.searchTokenFlights)
        if FavoriteManager.shared.checkFlightStatus(token: self.searchTokenFlights) {
            favoriteView.paintBookmarkImage()
        } else {
            favoriteView.unPaintBookmarkImage()
        }
    }
}
