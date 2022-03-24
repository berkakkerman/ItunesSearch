//
//  AudioPlayer.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 20.03.2022.
//

import AVKit
import Combine

final class AudioPlayer: AVPlayer, ObservableObject {
    
    var audioDidEnd = PassthroughSubject<Void, Never>()
    
    fileprivate let currentItemKeyPath = "currentItem"
    
    override init() {
        super.init()
        registerObserves()
    }
    
    override init(playerItem: AVPlayerItem?) {
        super.init(playerItem: playerItem)
        registerObserves()
    }
    
    private func registerObserves() {
        self.addObserver(self, forKeyPath: currentItemKeyPath, options: [.new], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == currentItemKeyPath, let item = currentItem {
            var cancellable: AnyCancellable?
            cancellable = NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime, object: item).sink { [weak self] _ in
                self?.audioDidEnd.send()
                cancellable?.cancel()
            }
        }
    }
}
