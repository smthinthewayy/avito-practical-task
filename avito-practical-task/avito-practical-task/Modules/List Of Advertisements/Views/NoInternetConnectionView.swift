//
//  NoInternetConnectionView.swift
//  avito-practical-task
//
//  Created by Danila Belyi on 31.08.2023.
//

import UIKit

class NoInternetConnectionView: UIView {
    // MARK: Lifecycle

    override init(frame _: CGRect) {
        super.init(frame: .zero)
        setup()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Private

    private let wiFiImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "wifi", withConfiguration: UIImage.SymbolConfiguration(pointSize: 48, weight: .regular))?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let warningImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "exclamationmark.triangle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 48, weight: .light))?.withTintColor(.systemOrange, renderingMode: .alwaysOriginal)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.text = "No Internet Connection"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private func setup() {
        backgroundColor = .clear
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(wiFiImage)
        addSubview(warningImage)
        addSubview(label)

        NSLayoutConstraint.activate([
            wiFiImage.topAnchor.constraint(equalTo: topAnchor),
            wiFiImage.centerXAnchor.constraint(equalTo: centerXAnchor),

            warningImage.topAnchor.constraint(equalTo: wiFiImage.centerYAnchor),
            warningImage.leadingAnchor.constraint(equalTo: wiFiImage.centerXAnchor),

            label.topAnchor.constraint(equalTo: warningImage.bottomAnchor, constant: 16),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}
