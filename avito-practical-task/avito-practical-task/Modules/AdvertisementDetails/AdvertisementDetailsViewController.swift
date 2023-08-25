//
//  AdvertisementDetailsViewController.swift
//  avito-practical-task
//
//  Created by Danila Belyi on 24.08.2023.
//

import CocoaLumberjackSwift
import UIKit

class AdvertisementDetailsViewController: UIViewController {
    // MARK: - Properties

    var advertisementID: String?

    private var advertisementDetails: AdvertisementDetails?
    
    private let advertisementImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let advertisementPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let advertisementTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let advertisementAddressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let advertisementDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .label
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Описание"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contactsLabel: UILabel = {
        let label = UILabel()
        label.text = "Контакты"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let advertisementEmailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let advertisementPhoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let advertisementCreatedDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        if let advertisementID = advertisementID {
            NetworkManager.shared.getAdvertisementDetails(for: advertisementID) { [weak self] result in
                switch result {
                case let .success(networkAdvertisementDetails):
                    self?.advertisementDetails = NetworkConverter.shared.fromNetworkAdvertisementDetailsToAdvertisementDetails(networkAdvertisementDetails)
                    if let advertisementDetails = self?.advertisementDetails {
                        self?.setupUI(advertisementDetails)
                    }
                case let .failure(error):
                    DDLogError("\(error)")
                }
            }
        }
    }

    private func setupUI(_ advertisementDetails: AdvertisementDetails) {
        setupSubviews()
        setAttributes(advertisementDetails)
        setupConstraints()
    }
    
    private func setupSubviews() {
        view.addSubview(advertisementImageView)
        view.addSubview(advertisementPriceLabel)
        view.addSubview(advertisementTitleLabel)
        view.addSubview(advertisementAddressLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(advertisementDescriptionLabel)
        view.addSubview(contactsLabel)
        view.addSubview(advertisementEmailLabel)
        view.addSubview(advertisementPhoneNumberLabel)
        view.addSubview(advertisementCreatedDateLabel)
    }
    
    private func setAttributes(_ advertisementDetails: AdvertisementDetails) {
        advertisementImageView.sd_setImage(with: advertisementDetails.imageURL)
        advertisementPriceLabel.text = advertisementDetails.price
        advertisementTitleLabel.text = advertisementDetails.title
        advertisementAddressLabel.text = advertisementDetails.location + ", " + advertisementDetails.address
        advertisementDescriptionLabel.text = advertisementDetails.description
        advertisementEmailLabel.text = advertisementDetails.email
        advertisementPhoneNumberLabel.text = advertisementDetails.phoneNumber
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.timeStyle = .medium
        dateFormatter.dateFormat = "d MMMM, yyyy"
        let dateString = dateFormatter.string(from: advertisementDetails.createdDate)
        advertisementCreatedDateLabel.text = dateString
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            advertisementImageView.widthAnchor.constraint(equalToConstant: view.frame.width),
            advertisementImageView.heightAnchor.constraint(equalToConstant: view.frame.width),
            advertisementImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            advertisementImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            
            advertisementPriceLabel.topAnchor.constraint(equalTo: advertisementImageView.bottomAnchor, constant: 12),
            advertisementPriceLabel.leadingAnchor.constraint(equalTo: advertisementImageView.leadingAnchor, constant: 12),
            
            advertisementTitleLabel.leadingAnchor.constraint(equalTo: advertisementPriceLabel.leadingAnchor),
            advertisementTitleLabel.topAnchor.constraint(equalTo: advertisementPriceLabel.bottomAnchor, constant: 6),
            
            advertisementAddressLabel.leadingAnchor.constraint(equalTo: advertisementTitleLabel.leadingAnchor),
            advertisementAddressLabel.topAnchor.constraint(equalTo: advertisementTitleLabel.bottomAnchor, constant: 6),
            
            descriptionLabel.topAnchor.constraint(equalTo: advertisementAddressLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: advertisementAddressLabel.leadingAnchor),
            
            advertisementDescriptionLabel.widthAnchor.constraint(equalToConstant: view.frame.width - 16),
            advertisementDescriptionLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            advertisementDescriptionLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            
            contactsLabel.topAnchor.constraint(equalTo: advertisementDescriptionLabel.bottomAnchor, constant: 16),
            contactsLabel.leadingAnchor.constraint(equalTo: advertisementDescriptionLabel.leadingAnchor),
            
            advertisementEmailLabel.topAnchor.constraint(equalTo: contactsLabel.bottomAnchor, constant: 12),
            advertisementEmailLabel.leadingAnchor.constraint(equalTo: contactsLabel.leadingAnchor),
            
            advertisementPhoneNumberLabel.topAnchor.constraint(equalTo: advertisementEmailLabel.bottomAnchor, constant: 12),
            advertisementPhoneNumberLabel.leadingAnchor.constraint(equalTo: advertisementEmailLabel.leadingAnchor),
            
            advertisementCreatedDateLabel.topAnchor.constraint(equalTo: advertisementPhoneNumberLabel.bottomAnchor, constant: 16),
            advertisementCreatedDateLabel.leadingAnchor.constraint(equalTo: advertisementPhoneNumberLabel.leadingAnchor)
        ])
    }
}
