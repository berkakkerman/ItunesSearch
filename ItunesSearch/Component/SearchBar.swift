//
//  SearchBar.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 18.03.2022.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var searchText: String
    @FocusState var isInputActive: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.inputBackground)
            HStack {
                Image(systemName: "magnifyingglass")
                TextField(L10n.tr(.product_search_placeholder), text: $searchText)
                    .font(.callout.weight(.medium))
                    .foregroundColor(.black)
                    .disableAutocorrection(true)
                    .focused($isInputActive)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                isInputActive = false
                            }
                            .foregroundColor(.blue)
                        }
                    }
                
            }
            .foregroundColor(.inputContent)
            .padding(.horizontal, 12)
        }
        .frame(height: 40)
        .cornerRadius(12)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant("Some text"))
    }
}
