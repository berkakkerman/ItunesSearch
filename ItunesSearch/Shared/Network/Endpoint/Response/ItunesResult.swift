//
//  ItunesResult.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 18.03.2022.
//

import Foundation

// MARK: - ItunesResult
struct ItunesResult: Codable {
    let resultCount: Int?
    var results: [ItunesProduct] = []
}

// MARK: - ItunesProduct
struct ItunesProduct: Codable, Hashable {
    
    let kind: ItunesMediaKind?
    let artistId: Int64?
    let trackId: Int64?
    let collectionId: Int64?
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    let artistViewUrl: String?
    let collectionViewUrl: String?
    let trackViewUrl: String?
    let previewUrl: String?
    let artworkUrl100: String?
    let collectionPrice: Decimal?
    let currency: String?
    let description: String?
    let shortDescription: String?
    let longDescription: String?
    let releaseDate: String?
    let formattedPrice: String?
    let primaryGenreName: String?
    let genres: [String]?
    
    var price: String? {
        guard let kind = self.kind else { return nil }
        switch kind {
        case .ebook, .podcast:
            return formattedPrice
        default:
            return collectionPrice?.formatCurrency(currencyCode: currency ?? "USD")
        }
    }
    
    var productGenres: [String]? {
        switch kind {
        case .ebook, .podcast:
            return genres
        default:
            guard let genre = primaryGenreName else { return nil }
            return [genre]
        }
    }
    
    func getCardDescription(isLong: Bool = true) -> String {
        switch kind {
        case .movie:
            return isLong ? longDescription ?? "" : shortDescription ?? ""
        default:
            return description ?? ""
        }
    }
}

// MARK: - Preview
extension ItunesProduct: Previewable {
    static var previewValue: Self {
        ItunesProduct(kind: .ebook,
                      artistId: 0,
                      trackId: 0,
                      collectionId: 0,
                      artistName: "artist",
                      collectionName: "collection",
                      trackName: "track",
                      artistViewUrl: nil,
                      collectionViewUrl: nil,
                      trackViewUrl: nil,
                      previewUrl: nil,
                      artworkUrl100: "https://is2-ssl.mzstatic.com/image/thumb/Publication124/v4/1d/d5/6d/1dd56d9a-baa9-eb8e-f829-b044729feeb1/9781094373973.jpg/100x100bb.jpg",
                      collectionPrice: 10,
                      currency: "USD",
                      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                      shortDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                      longDescription: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                      releaseDate: "22.08.2022",
                      formattedPrice: "$9.99",
                      primaryGenreName: "Sci-fi",
                      genres: ["Sci-fi", "Thriller", "Lorem ipsum dolor sit amet, consectetur adipiscing elit"])
    }
}
