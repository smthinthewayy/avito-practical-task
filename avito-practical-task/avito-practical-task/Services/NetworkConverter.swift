//
//  NetworkConverter.swift
//  avito-practical-task
//
//  Created by Danila Belyi on 24.08.2023.
//

import UIKit

final class NetworkConverter {
    // MARK: Public

    public func fromNetworkAdvertisementToAdvertisement(_ networkAdvertisement: NetworkAdvertisement) -> Advertisement {
        let advertisement = Advertisement(
            id: networkAdvertisement.id,
            title: networkAdvertisement.title,
            price: networkAdvertisement.price,
            location: networkAdvertisement.location,
            imageURL: URL(string: networkAdvertisement.imageUrl)!,
            createdDate: createDateFromString(networkAdvertisement.createdDate)
        )
        return advertisement
    }

    public func fromNetworkAdvertisementDetailsToAdvertisementDetails(_ networkAdvertisementDetails: NetworkAdvertisementDetails) -> AdvertisementDetails {
        let advertisementDetails = AdvertisementDetails(
            id: networkAdvertisementDetails.id,
            title: networkAdvertisementDetails.title,
            price: networkAdvertisementDetails.price,
            location: networkAdvertisementDetails.location,
            imageURL: URL(string: networkAdvertisementDetails.imageUrl)!,
            createdDate: createDateFromString(networkAdvertisementDetails.createdDate),
            description: networkAdvertisementDetails.description,
            email: networkAdvertisementDetails.email,
            phoneNumber: networkAdvertisementDetails.phoneNumber,
            address: networkAdvertisementDetails.address
        )
        return advertisementDetails
    }

    public func fromNetworkAdvertisementsToAdvertisements(_ networkAdvertisements: NetworkAdvertisements) -> Advertisements {
        return Advertisements(advertisements: networkAdvertisements.advertisements.map { fromNetworkAdvertisementToAdvertisement($0) })
    }

    // MARK: Internal

    static let shared = NetworkConverter()

    // MARK: Private

    private func createDateFromString(_ string: String) -> Date {
        let dateString = string
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let date = dateFormatter.date(from: dateString) {
            return date
        } else {
            return Date(timeIntervalSince1970: TimeInterval(0))
        }
    }
}
