//
//  AVPlayer+Ext.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 20.03.2022.
//

import AVKit

extension AVPlayer {
    
    var isPlaying: Bool {
        return self.rate != 0 && self.error == nil
    }
}
