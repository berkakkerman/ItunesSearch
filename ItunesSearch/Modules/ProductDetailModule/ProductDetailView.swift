//
//  ProductDetailView.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 20.03.2022.
//

import SwiftUI
import AVKit

struct ProductDetailView: View {
    
    @ObservedObject var presenter: ProductDetailPresenter
    
    var body: some View {
        VStack {
            ScrollView {
                ZStack(alignment: .bottomLeading) {
                    if let artworkUrl = presenter.product.artworkUrl100 {
                        HStack {
                            Spacer()
                            CachedAsyncImage(url: URL(string: artworkUrl) ) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(2)
                            } placeholder: {
                                Color.gray
                            }
                            .frame(height: 350)
                            Spacer()
                        }
                    }
                    VStack(alignment: .leading, spacing: 12) {
                        Text(presenter.product.collectionName ?? "")
                            .font(.largeTitle.weight(.bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(3)
                        HStack {
                            VStack(alignment: .leading) {
                                Text(presenter.product.trackName ?? "")
                                    .font(.footnote.weight(.semibold))
                                if let price = presenter.product.price {
                                    PriceTagView(price: price)
                                }
                            }
                            Spacer()
                            if let previewUrl = presenter.product.previewUrl {
                                PlayerView(url: previewUrl)
                            }
                        }
                    }
                    .padding(20)
                    .background(
                        Rectangle()
                            .fill(.gray)
                            .mask(RoundedRectangle(cornerRadius: 0, style: .continuous))
                            .opacity(0.3)
                        )
                    .onAppear {
                        try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, options: [])
                    }
                }
                
                // MARK: Genres
                if let genres = presenter.product.productGenres, !genres.isEmpty {
                    Spacer()
                    ProductGenreListView(genres: genres)
                        .padding(.horizontal, 12)
                }
                
                // MARK: Information
                ProductInformationView(product: presenter.product)
                    .padding(.horizontal, 12)
                
                // MARK: Description
                VStack {
                    if let description = presenter.product.getCardDescription(isLong: true).htmlToString(), !description.isEmpty {
                        Divider()
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Summary")
                                .font(.headline.weight(.semibold))
                                .padding(.horizontal, 12)
                            Text(description)
                                .font(.footnote.weight(.regular))
                                .padding(.horizontal, 12)
                        }
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
        .background(Color.detailBackground)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let entity = ProductDetailEntity(product: ItunesProduct.previewValue)
        let interactor = ProductDetailInteractor(model: entity)
        let presenter = ProductDetailPresenter(interactor: interactor)
        return ProductDetailView(presenter: presenter)
    }
}
