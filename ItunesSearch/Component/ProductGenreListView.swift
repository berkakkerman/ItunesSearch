//
//  ProductGenreListView.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 24.03.2022.
//

import SwiftUI

struct ProductGenreListView: View {
    
    var genres: [String]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach(genres, id: \.self) { genre in
                    Text(genre)
                        .lineLimit(1)
                        .foregroundColor(.black)
                        .font(.footnote.weight(.semibold))
                        .padding(8)
                        .background(.white)
                        .clipped()
                        .clipShape(Capsule())
                        .shadow(color: .gray, radius: 1, x: 0, y: 0)
                        .overlay(
                            Capsule()
                                .stroke(Color.black, lineWidth: 2)
                        )
                }
            }
            .padding(8)
        }
    }
}

struct ProductGenreListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductGenreListView(genres: ItunesProduct.previewValue.productGenres ?? [])
    }
}
