//
//  PlayerView.swift
//  ItunesSearch
//
//  Created by Berk Akkerman on 20.03.2022.
//

import SwiftUI
import AVKit

struct PlayerView: View {
    
    var url: String
    
    @State var audioPlayer: AudioPlayer = AudioPlayer()
    @State var isPlaying: Bool = false
    
    var body: some View {
        HStack {
            if !isPlaying {
                Button(action: {
                    withAnimation {
                        audioPlayer.play()
                        isPlaying = audioPlayer.isPlaying
                    }
                }) {
                    Image(systemName: "play.circle.fill")
                        .resizable()
                        .foregroundColor(.green)
                        .frame(width: 45, height: 45)
                        .aspectRatio(contentMode: .fit)
                }
            } else {
                Button(action: {
                    withAnimation {
                        audioPlayer.pause()
                        isPlaying = audioPlayer.isPlaying
                    }
                }) {
                    Image(systemName: "pause.circle.fill").resizable()
                        .foregroundColor(.black)
                        .frame(width: 45, height: 45)
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
        .padding(8)
        .onReceive(self.audioPlayer.audioDidEnd) {
            resetPlayer()
        }
        .onAppear {
            resetPlayer()
        }
        .onDisappear {
            self.removeObservers()
            self.audioPlayer.rate = 0
        }
    }
    
    func resetPlayer() {
        isPlaying = false
        guard let previewUrl = URL(string: url) else { return }
        let item = AVPlayerItem(url: previewUrl)
        let player = AudioPlayer(playerItem: item)
        self.audioPlayer = player
    }
    
    func removeObservers() {
        NotificationCenter.default.removeObserver(self)
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(url: "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/f0/95/a5/f095a5b0-9413-2463-eb08-64c4e43130a2/mzaf_15171290860624917386.plus.aac.p.m4a")
    }
}
