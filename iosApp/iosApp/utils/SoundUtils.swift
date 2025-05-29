//
//  SoundUtils.swift
//  iosApp
//
//  Created by Monokouma on 29/05/2025.
//  Copyright © 2025 orgName. All rights reserved.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("ERROR")
        }
    }
}

class AudioManager: NSObject, ObservableObject {
    @Published var isPlaying = false
    @Published var isLoading = false
    @Published var error: String?
    
    private var player: AVAudioPlayer?
    private let session = URLSession.shared
    
    override init() {
        super.init()
        setupAudioSession()
    }
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            self.error = "Audio session setup failed"
        }
    }
    
    func playChampionAudio(championKey: String) {
        let url = "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/v1/champion-choose-vo/\(championKey).ogg"
        playAudio(from: url)
    }
    
    func playAudio(from urlString: String) {
        guard let url = URL(string: urlString) else {
            error = "Invalid URL"
            return
        }
        
        stop()
        isLoading = true
        error = nil
        
        session.dataTask(with: url) { [weak self] data, _, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                if let error = error {
                    self?.error = error.localizedDescription
                    return
                }
                
                guard let data = data else {
                    self?.error = "No audio data"
                    return
                }
                
                self?.setupPlayer(with: data)
            }
        }.resume()
    }
    
    private func setupPlayer(with data: Data) {
        do {
            player = try AVAudioPlayer(data: data)
            player?.delegate = self
            player?.prepareToPlay()
            
            if player?.play() == true {
                isPlaying = true
            } else {
                error = "Playback failed"
            }
        } catch {
            self.error = "Audio setup failed: \(error.localizedDescription)"
        }
    }
    
    func stop() {
        player?.stop()
        player = nil
        isPlaying = false
    }
    
    func toggle() {
        guard let player = player else { return }
        
        if player.isPlaying {
            player.pause()
            isPlaying = false
        } else {
            player.play()
            isPlaying = true
        }
    }
}


extension AudioManager: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        DispatchQueue.main.async {
            self.isPlaying = false
        }
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        DispatchQueue.main.async {
            self.isPlaying = false
            self.error = "Decode error"
        }
    }
}
