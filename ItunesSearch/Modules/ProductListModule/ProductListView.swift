//
//  ProductListView.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 18.03.2022.
//

import SwiftUI
import Combine

struct ProductListView: View {
    
    @ObservedObject var presenter: ProductListPresenter
    
    // 2 columns grid
    let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
            VStack {
                // MARK: Search Bar
                SearchBar(searchText: $presenter.searchTerm)
                    .padding(8)
                
                // MARK: Segment Control
                SegmentControl(selected: $presenter.selectedFilterType,
                               items: ItunesMediaKind.allCases)
                    .padding(.horizontal, 8)
                
                if !$presenter.listData.isEmpty {
                    // MARK: Product List
                    LoadingView(isShowing: $presenter.isLoadingPage) {
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(presenter.listData, id: \.self) { product in
                                    presenter.makeDetailView(for: product) {
                                        ProductCardView(product: product)
                                            .frame(height: 260)
                                            .onAppear {
                                                presenter.loadMoreProductsIfNeeded(product: product)
                                            }
                                    }
                                }
                            }
                            .padding(.horizontal, 8)
                            .padding(.top, 12)
                            .frame(maxWidth: .infinity)
                        }
                    }
                } else {
                    if !presenter.isLoadingPage {
                        // MARK: Empty View
                        VStack {
                            Spacer()
                            Text(L10n.tr(.home_title))
                            Text(L10n.tr(.product_search_empty))
                                .font(.caption.weight(.light))
                                .foregroundColor(.gray)
                            Spacer()
                        }
                    } else {
                        VStack {
                            Spacer()
                            ProgressView()
                                .foregroundColor(.orange)
                            Spacer()
                        }
                    }
                }
               Spacer()
            }
            .navigationTitle(L10n.tr(.home_title))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
        //ProductListView()
    }
}
