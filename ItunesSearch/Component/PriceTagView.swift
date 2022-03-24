//
//  PriceTagView.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 20.03.2022.
//

import SwiftUI

struct PriceTagView: View {
    
    var price: String
    
    var body: some View {
        Text(price)
            .foregroundColor(.white)
            .font(.footnote.weight(.semibold))
            .padding(8)
            .background(.orange)
            .cornerRadius(8)
    }
}

struct PriceTagView_Previews: PreviewProvider {
    static var previews: some View {
        PriceTagView(price: "$9.99")
    }
}
