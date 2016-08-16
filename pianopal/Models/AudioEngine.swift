//
//  AudioEngine.swift
//  pianopal
//
//  Created by Joshua Escribano on 8/12/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation
import AVFoundation

class AudioEngine {
    weak var delegate:PianoNavigationViewController?
    let format = AVAudioFormat(standardFormatWithSampleRate: 44100.0, channels: 2)
    var audioEngine: AVAudioEngine?
    var scalePlayer: AVAudioPlayerNode?
    var chordPlayers = [AVAudioPlayerNode]()
    
    init() {
        audioEngine = AVAudioEngine()
        scalePlayer = AVAudioPlayerNode()
        
        audioEngine?.attachNode(scalePlayer!)
        audioEngine?.connect(scalePlayer!, to: audioEngine!.mainMixerNode, format: format)
        
        _ = try? audioEngine?.start()
    }
    
    func play(notes: [NoteOctave], isScale: Bool = false) {
        for (index, note) in notes.enumerate() {
            if (isScale) {
                let file = try? AVAudioFile(forReading: note.url())
                var completionHandler: AVAudioNodeCompletionHandler?
                completionHandler = {
                    self.delegate?.didFinishPlayingNote(note)
                }
                if index == notes.count - 1 {
                    completionHandler = {
                        self.delegate?.didFinishPlaying()
                    }
                }
                let buffer = AVAudioPCMBuffer(PCMFormat: file!.processingFormat, frameCapacity: AVAudioFrameCount(file!.length))
                try? file?.readIntoBuffer(buffer)
                scalePlayer?.scheduleBuffer(buffer, completionHandler: completionHandler)
                scalePlayer?.play()
            }
            else {
                let file = try? AVAudioFile(forReading: note.url())
                let chordPlayer = AVAudioPlayerNode()
                audioEngine?.attachNode(chordPlayer)
                audioEngine?.connect(chordPlayer, to: audioEngine!.mainMixerNode, format: format)
                chordPlayers.append(chordPlayer)
                let now = chordPlayer.lastRenderTime!.sampleTime
                let startTime = AVAudioTime(sampleTime: now + AVAudioFramePosition(format.sampleRate), atRate: format.sampleRate)
                chordPlayer.scheduleFile(file!, atTime: nil, completionHandler: nil)
                chordPlayer.play()
            }
        }
    }
    
    func stop() {
        if (scalePlayer!.playing) {
            scalePlayer?.stop()
        }
        if (!chordPlayers.isEmpty) {
            for chordPlayer in chordPlayers {
                if (chordPlayer.playing) {
                    chordPlayer.stop()
                }
                audioEngine?.disconnectNodeInput(chordPlayer)
            }
            chordPlayers.removeAll()
        }
    }
}