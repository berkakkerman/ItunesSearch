//
//  SegmentControl.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 18.03.2022.
//

import SwiftUI

struct SegmentControl<Model: Segmentable>: View {
    
    @Binding var selected: Model
    var items: [Model]
    
    var body: some View {
        
        Picker("", selection: $selected) {
            ForEach(items, id: \.self) {
                Text($0.friendlyName)
            }
        }
        .pickerStyle(.segmented)
    }
}

struct SegmentControl_Previews: PreviewProvider {
    static var previews: some View {
        SegmentControl<ItunesMediaKind>(selected: .constant(.movie),
                                          items: ItunesMediaKind.allCases)
    }
}
