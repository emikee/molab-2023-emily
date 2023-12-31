//
//  AudioRow.swift
//  Study App
//
//  Created by Emily Shen on 11/8/23.
//

import Foundation
import SwiftUI
import AVFoundation
import MediaPlayer
import UIKit

//var player: AVAudioPlayer!

func loadSound(_ fileName:String) -> AVAudioPlayer? {
    let path = Bundle.main.path(forResource: fileName, ofType:nil)!
    let url = URL(fileURLWithPath: path)
    do {
        return try AVAudioPlayer(contentsOf: url)
    } catch {
        print("loadSound error", error)
    }
    return nil
}

struct AudioRow: View {
    var audio: AudioFile
    @State private var player: AVAudioPlayer? = nil
    @State private var volume: Float = 0
    private var normalFillColor: Color { ColorStyles.text.opacity(0.5) }
    private var emptyColor: Color { ColorStyles.text.opacity(0.2) }
    private var paragraph: Color {ColorStyles.text.opacity(0.7)}
    
    var body: some View {
        VStack {
            volumeSlider(
                value: $volume,
                inRange: 0...audio.audioMax,
                activeFillColor: ColorStyles.text,
                fillColor: normalFillColor,
                emptyColor: emptyColor,
                width: 96,
                onEditingChanged: {change in
                    //player = loadSound(audio.url)
                    player?.volume = volume
                    if (volume > 0) {
                        player?.play()
                        print("played \(audio.url) + \(player?.volume ?? 0)")
                    } else {
                        player?.pause()
                        print("paused \(audio.url)")
                    }
                })
            .frame(height: 130)
            .onAppear() {
                player = loadSound(audio.url)
                player?.numberOfLoops = -1
                player?.volume = 0
            }
            Text(audio.name)
                .fontWeight(.medium)
                .foregroundColor(paragraph)
                .multilineTextAlignment(.center)
                .padding(.top, 8.0)
        }
    }
        
    
    
    struct Audio_Preview: PreviewProvider {
        static var previews: some View {
            Group {
                AudioRow(audio: audiofiles[0])
            }
        }
    }
}

