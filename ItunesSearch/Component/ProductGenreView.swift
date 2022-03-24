//
//  ProductGenreView.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 24.03.2022.
//

import SwiftUI

struct ProductGenreView: View {
    
    var genre: String
    
    var body: some View {
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

struct ProductGenreView_Previews: PreviewProvider {
    static var previews: some View {
        ProductGenreView(genre: "Sci-fi")
    }
}
