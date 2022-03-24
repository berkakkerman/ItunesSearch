//
//  LoadingView.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 21.03.2022.
//

import SwiftUI

struct LoadingView<Content>: View where Content: View {
    
    @Binding var isShowing: Bool
    var content: () -> Content
    
    var body: some View {
        ZStack(alignment: .center) {
            self.content()
                .disabled(self.isShowing)
            
            VStack {
                ProgressView()
            }
            .foregroundColor(.orange)
            .frame(width: 100, height: 100, alignment: .center)
            .cornerRadius(20)
            .opacity(self.isShowing ? 1 : 0)            
        }
        .blur(radius: self.isShowing ? 1 : 0)
    }
    
}
