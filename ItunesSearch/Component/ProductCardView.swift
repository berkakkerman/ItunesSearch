//
//  ProductCardView.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 18.03.2022.
//

import SwiftUI

struct ProductCardView: View {
    
    var product: ItunesProduct
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            
            VStack(spacing: 12) {
                
                VStack(alignment: .center) {
                    
                    if let artworkUrl = product.artworkUrl100 {
                        CachedAsyncImage(url: URL(string: artworkUrl) ) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(2)
                           } placeholder: {
                               Color.gray
                         }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(product.collectionName ?? "-")
                            .font(.title3.weight(.bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(3)
                        Text(product.trackName ?? "-")
                            .font(.footnote.weight(.semibold))
                        Divider()
                        VStack(alignment: .center, spacing: 2) {
                            HStack {
                                Spacer()
                                Text(L10n.tr(.product_release_date))
                                    .font(.footnote.weight(.light))
                                Spacer()
                            }
                            HStack {
                                Spacer()
                                Text(product.releaseDate?.formatDate() ?? "")
                                    .font(.footnote.weight(.ultraLight))
                                Spacer()
                            }
                        }
                    }
                }
            }
            .padding(8)
            .background(
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .mask(RoundedRectangle(cornerRadius: 12, style: .continuous))
            )
            .clipped()
            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 0)
            
            if let price = product.price {
                PriceTagView(price: price)
            }
        }
    }
}

struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCardView(product: .previewValue)
    }
}
