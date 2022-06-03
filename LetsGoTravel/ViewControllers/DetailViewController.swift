//
//  DetailViewController.swift
//  LetsGoTravel
//
//  Created by Natali Malich
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Properties
    var flight: Flight?
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
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.activateAnchors()
        return view
    }()
    
    private lazy var departureCityLabel: UILabel = {
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
        label.font = UIFont.systemFont(ofSize: 25)
        label.textColor = .black
        label.activateAnchors()
        return label
    }()
    
    private lazy var returnDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        label.activateAnchors()
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.appColor(.blueDark)
        label.activateAnchors()
        return label
    }()
    
    private lazy var horizontalLineImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.appSymbol(.horizontalline)
        image.activateAnchors()
        return image
    }()
    
    private lazy var airplaneTakeOffRightImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.appSymbol(.airplaneTakeOffRight)?.withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.appColor(.blueDark)
        image.activateAnchors()
        return image
    }()
    
    private lazy var airplaneTakeOffLeftImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.appSymbol(.airplaneTakeOffLeft)?.withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.appColor(.blueDark)
        image.activateAnchors()
        return image
    }()
    
    private lazy var favoriteView: FavoriteView = {
        let view = FavoriteView()
        view.activateAnchors()
        return view
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        setUpGestureRecognizer()
      
        guard let flight = flight else { return }
        showFlight(flight: flight)
    }
    
    // MARK: - Data
    func showFlight(flight: Flight) {
        self.priceLabel.text = "Цена за 1 пассажира \n\(flight.price) ₽"
        
        self.departureCityLabel.text = "\(flight.startCity) - \(flight.endCity)"
        let departureDate = DateManager.shared.getDateFromString(dateString: flight.startDate)
        let departureString = DateManager.shared.getStringFromDate(date: departureDate ?? Date(), dateFormat: "Дата отправления: dd.MM.yyyy \n\nВремя вылета: HH:mm")
        self.departureDateLabel.text = departureString
        
        self.arrivalCityLabel.text = "\(flight.endCity) - \(flight.startCity)"
        let arrivalDate = DateManager.shared.getDateFromString(dateString: flight.endDate)
        let arrivalString = DateManager.shared.getStringFromDate(date: arrivalDate ?? Date(), dateFormat: "Дата отправления: dd.MM.yyyy \n\nВремя вылета: HH:mm")
        self.returnDateLabel.text = arrivalString
        
        self.searchTokenFlights = flight.searchToken
    }
}

    // MARK: - Setup Views
extension DetailViewController {
    private func setupViews() {
        view.backgroundColor = UIColor.appColor(.blueLight)
        view.addSubview(wrapperView)
        wrapperView.addSubviews(departureCityLabel, arrivalCityLabel, departureDateLabel, returnDateLabel, priceLabel, airplaneTakeOffRightImage, airplaneTakeOffLeftImage, horizontalLineImage, favoriteView)
    }
}

    // MARK: - Setup Constraints
extension DetailViewController {
    private func setupConstraints() {
        [
            wrapperView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            wrapperView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            wrapperView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            wrapperView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wrapperView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            favoriteView.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: -22),
            favoriteView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            
            priceLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 10),
            priceLabel.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor),
            
            horizontalLineImage.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor),
            horizontalLineImage.centerYAnchor.constraint(equalTo: wrapperView.centerYAnchor),
            horizontalLineImage.widthAnchor.constraint(equalTo: wrapperView.widthAnchor, multiplier: 0.4),
            
            departureDateLabel.bottomAnchor.constraint(equalTo: horizontalLineImage.topAnchor, constant: -30),
            departureDateLabel.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 100),
            
            departureCityLabel.bottomAnchor.constraint(equalTo: departureDateLabel.topAnchor, constant: -20),
            departureCityLabel.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor),
            
            arrivalCityLabel.topAnchor.constraint(equalTo: horizontalLineImage.bottomAnchor, constant: 30),
            arrivalCityLabel.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor),
            
            returnDateLabel.topAnchor.constraint(equalTo: arrivalCityLabel.bottomAnchor, constant: 20),
            returnDateLabel.leadingAnchor.constraint(equalTo: departureDateLabel.leadingAnchor),
            
            airplaneTakeOffRightImage.trailingAnchor.constraint(equalTo: departureDateLabel.leadingAnchor, constant: -20),
            airplaneTakeOffRightImage.centerYAnchor.constraint(equalTo: departureDateLabel.centerYAnchor),

            airplaneTakeOffLeftImage.trailingAnchor.constraint(equalTo: returnDateLabel.leadingAnchor, constant: -20),
            airplaneTakeOffLeftImage.centerYAnchor.constraint(equalTo: returnDateLabel.centerYAnchor)
        ]
        .forEach {$0.isActive = true}
    }
}

    // MARK: - Actions
extension DetailViewController {
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
