//
//  AdvertisementCollectionViewCell.swift
//  avito-practical-task
//
//  Created by Danila Belyi on 24.08.2023.
//

import UIKit

// MARK: - AdvertisementCollectionViewCell

class AdvertisementCollectionViewCell: UICollectionViewCell {
    // MARK: Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public

    public func setupSubviews(_ advertisement: Advertisement) {
        placeholder.isHidden = false
        imageRequest = imageService.image(for: advertisement.imageURL) { [weak self] image in
            self?.imageView.image = image
            self?.placeholder.isHidden = true
        }
        titleLabel.text = advertisement.title
        priceLabel.text = advertisement.price
        locationLabel.text = advertisement.location
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.timeStyle = .medium
        dateFormatter.dateFormat = "d MMMM, yyyy"
        let dateString = dateFormatter.string(from: advertisement.createdDate)
        createdDate.text = dateString
    }

    // MARK: Internal

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        placeholder.isHidden = false
        titleLabel.text = nil
        priceLabel.text = nil
        locationLabel.text = nil
        createdDate.text = nil
        imageRequest?.cancel()
    }

    // MARK: Private

    private lazy var imageService = ImageService()

    private var imageRequest: Cancellable?

    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        view.isSkeletonable = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        return view
    }()

    private let placeholder: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .label
        label.numberOfLines = 2
        label.isSkeletonable = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .label
        label.isSkeletonable = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .secondaryLabel
        label.isSkeletonable = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let createdDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .secondaryLabel
        label.isSkeletonable = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private func commonInit() {
        addSubviews()
        setupConstraints()
    }

    private func addSubviews() {
        addSubview(mainView)
        mainView.addSubview(imageView)
        mainView.addSubview(placeholder)
        mainView.addSubview(titleLabel)
        mainView.addSubview(priceLabel)
        mainView.addSubview(locationLabel)
        mainView.addSubview(createdDate)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor),

            imageView.topAnchor.constraint(equalTo: mainView.topAnchor),
            imageView.widthAnchor.constraint(equalTo: mainView.widthAnchor),

            placeholder.heightAnchor.constraint(equalTo: imageView.heightAnchor),
            placeholder.widthAnchor.constraint(equalTo: mainView.widthAnchor),
            placeholder.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            placeholder.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),

            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4),
            titleLabel.widthAnchor.constraint(equalTo: mainView.widthAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),

            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),

            locationLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4),
            locationLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),

            createdDate.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 4),
            createdDate.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
        ])
    }
}
