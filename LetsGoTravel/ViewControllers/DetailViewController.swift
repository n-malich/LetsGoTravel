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
        view.backgroundColor = UIColor.appColor(.blueLight)
        view.layer.cornerRadius = 10
        view.activateAnchors()
        return view
    }()
    
    private lazy var departureCityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.numberOfLines = 0
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
        label.font = UIFont.systemFont(ofSize: 25)
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
    
    private lazy var verticalLineImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.appSymbol(.verticalLine)
        image.activateAnchors()
        return image
    }()
    
    private lazy var airplaneTakeOffImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.appSymbol(.airplaneTakeOff)?.withRenderingMode(.alwaysTemplate)
        image.tintColor = UIColor.appColor(.blueDark)
        image.activateAnchors()
        return image
    }()
    
    private lazy var airplaneLandingImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage.appSymbol(.airplaneLanding)?.withRenderingMode(.alwaysTemplate)
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
        self.priceLabel.text = "Цена за 1 пассажира \n \(flight.price) ₽"
        
        self.departureCityLabel.text = "\(flight.startCity),"
        self.departureCityCodeLabel.text = (flight.startCityCode).uppercased()
        let departureDate = DateManager.shared.getDateFromString(dateString: flight.startDate)
        let departureString = DateManager.shared.getStringFromDate(date: departureDate ?? Date(), dateFormat: "Дата вылета: dd.MM.yyyy \n \nВремя отправления: HH:mm")
        self.departureDateLabel.text = departureString
        
        self.arrivalCityLabel.text = "\(flight.endCity),"
        self.arrivalCityCodeLabel.text = (flight.endCityCode).uppercased()
        let arrivalDate = DateManager.shared.getDateFromString(dateString: flight.endDate)
        let arrivalString = DateManager.shared.getStringFromDate(date: arrivalDate ?? Date(), dateFormat: "Дата вылета: dd.MM.yyyy \n \nВремя отправления: HH:mm")
        self.returnDateLabel.text = arrivalString
        
        self.searchTokenFlights = flight.searchToken
    }
}

    // MARK: - Setup Views
extension DetailViewController {
    private func setupViews() {
        view.addSubview(wrapperView)
        wrapperView.addSubviews(departureCityLabel, departureCityCodeLabel, arrivalCityLabel, arrivalCityCodeLabel, departureDateLabel, returnDateLabel, priceLabel, airplaneTakeOffImage, airplaneLandingImage, verticalLineImage, favoriteView)
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
            
            verticalLineImage.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 25),
            verticalLineImage.heightAnchor.constraint(equalTo: wrapperView.heightAnchor, multiplier: 0.4),
            verticalLineImage.widthAnchor.constraint(equalToConstant: 60),
            verticalLineImage.centerYAnchor.constraint(equalTo: wrapperView.centerYAnchor),
            
            airplaneTakeOffImage.bottomAnchor.constraint(equalTo: verticalLineImage.topAnchor),
            airplaneTakeOffImage.centerXAnchor.constraint(equalTo: verticalLineImage.centerXAnchor),
            
            airplaneLandingImage.topAnchor.constraint(equalTo: verticalLineImage.bottomAnchor),
            airplaneLandingImage.centerXAnchor.constraint(equalTo: verticalLineImage.centerXAnchor),
            
            departureCityLabel.bottomAnchor.constraint(equalTo: airplaneTakeOffImage.topAnchor),
            departureCityLabel.leadingAnchor.constraint(equalTo: airplaneTakeOffImage.trailingAnchor, constant: 20),
            
            departureCityCodeLabel.leadingAnchor.constraint(equalTo: departureCityLabel.trailingAnchor, constant: 3),
            departureCityCodeLabel.bottomAnchor.constraint(equalTo: departureCityLabel.bottomAnchor),
            
            departureDateLabel.topAnchor.constraint(equalTo: departureCityLabel.bottomAnchor, constant: 20),
            departureDateLabel.leadingAnchor.constraint(equalTo: departureCityLabel.leadingAnchor),

            returnDateLabel.topAnchor.constraint(equalTo: airplaneLandingImage.bottomAnchor),
            returnDateLabel.leadingAnchor.constraint(equalTo: airplaneLandingImage.trailingAnchor, constant: 20),
            
            arrivalCityLabel.bottomAnchor.constraint(equalTo: returnDateLabel.topAnchor, constant: -20),
            arrivalCityLabel.leadingAnchor.constraint(equalTo: returnDateLabel.leadingAnchor),
            
            arrivalCityCodeLabel.leadingAnchor.constraint(equalTo: arrivalCityLabel.trailingAnchor, constant: 3),
            arrivalCityCodeLabel.bottomAnchor.constraint(equalTo: arrivalCityLabel.bottomAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: wrapperView.topAnchor, constant: 10),
            priceLabel.centerXAnchor.constraint(equalTo: wrapperView.centerXAnchor)
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
