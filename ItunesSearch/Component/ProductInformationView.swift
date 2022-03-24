//
//  ProductInformationView.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 23.03.2022.
//

import SwiftUI

struct ProductInformationView: View {
    
    var product: ItunesProduct
    
    var body: some View {
        
        VStack(spacing: 8) {
            
            if let kind = product.kind {
                HStack {
                    Text(L10n.tr(.product_label_kind))
                        .font(.caption.weight(.medium))
                        .foregroundColor(.black)
                    Spacer()
                    Text(kind.friendlyName)
                        .font(.caption.weight(.bold))
                        .foregroundColor(.black)
                }
            }
            
            if let releaseDate = product.releaseDate?.formatDate() {
                HStack {
                    Text(L10n.tr(.product_label_release_date))
                        .font(.caption.weight(.medium))
                        .foregroundColor(.black)
                    Spacer()
                    Text(releaseDate)
                        .font(.caption.weight(.bold))
                        .foregroundColor(.black)
                }
            }
            
            if let artistViewUrl = product.artistViewUrl,
                let url = URL(string: artistViewUrl) {
                    HStack {
                        Text(L10n.tr(.product_label_artist))
                            .font(.caption.weight(.medium))
                            .foregroundColor(.black)
                        Spacer()
                        Link(L10n.tr(.product_label_navigate), destination: url)
                            .font(.caption.weight(.medium))
                            .foregroundColor(.blue)
                    }
                }
            
            
           if let collectionViewUrl = product.collectionViewUrl,
               let url = URL(string: collectionViewUrl) {
                HStack {
                    Text(L10n.tr(.product_label_collection))
                        .font(.caption.weight(.medium))
                        .foregroundColor(.black)
                    Spacer()
                    Link(L10n.tr(.product_label_navigate), destination: url)
                        .font(.caption.weight(.medium))
                        .foregroundColor(.blue)
                }
           }
        }
        .padding()
        .cornerRadius(8)
    }
}

struct ProductInformationView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProductInformationView(product: ItunesProduct.previewValue)
    }
}
