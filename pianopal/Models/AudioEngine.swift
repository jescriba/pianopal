//
//  AudioEngine.swift
//  pianopal
//
//  Created by Joshua Escribano on 8/12/16.
//  Copyright © 2016 Joshua Escribano. All rights reserved.
//

import Foundation
import AVFoundation
import AudioKit

class AudioEngine {
    weak var delegate:PianoNavigationViewController?
    let format = AVAudioFormat(standardFormatWithSampleRate: 44100.0, channels: 2)
    var audioEngine: AVAudioEngine?
    var scalePlayer: AVAudioPlayerNode?
    var chordPlayers = [AVAudioPlayerNode]()
    var rhodesPiano = AKRhodesPiano(frequency: 440, amplitude: 0.5)
    
    init() {
        AudioKit.output = rhodesPiano
        AudioKit.start()
        rhodesPiano.start()
//        audioEngine = AVAudioEngine()
//        scalePlayer = AVAudioPlayerNode()
//        
//        audioEngine?.attach(scalePlayer!)
//        audioEngine?.connect(scalePlayer!, to: audioEngine!.mainMixerNode, format: format)
//        
//        _ = try? audioEngine?.start()
//        
//        let audioSession = AVAudioSession.sharedInstance()
//        _ = try? audioSession.setActive(true)
//        _ = try? audioSession.setCategory("AVAudioSessionCategoryPlayback")
    }
    
    func play(_ notes: [NoteOctave], isScale: Bool = false) {
        for (index, noteOctave) in notes.enumerated() {
            if (isScale) {
//                let file = try? AVAudioFile(forReading: note.url() as URL)
//                let buffer = AVAudioPCMBuffer(pcmFormat: file!.processingFormat, frameCapacity: AVAudioFrameCount(file!.length))
//                _ = try? file?.read(into: buffer)
//                var completionHandler: AVAudioNodeCompletionHandler?
                if #available(iOS 10.0, *) {
                    Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
                        self.rhodesPiano.trigger(frequency: noteOctave.note!.frequency() * (Double)(noteOctave.octave!), amplitude: 1)
                        if index == notes.count - 1 {
                            self.delegate?.didFinishPlayingNotes(notes)
                            self.delegate?.didFinishPlaying()
                        } else {
                            self.delegate?.didFinishPlayingNotes([noteOctave])
                            self.delegate?.didStartPlayingNotes([notes[index + 1]])
                        }
                    }).fire()
                } else {
                    // Fallback on earlier versions
                }
//                if index == 0 {
//                    delegate?.didStartPlayingNotes([note])
//                }
            }
            else {
//                let file = try? AVAudioFile(forReading: note.url() as URL)
//                let chordPlayer = AVAudioPlayerNode()
//                audioEngine?.attach(chordPlayer)
//                audioEngine?.connect(chordPlayer, to: audioEngine!.mainMixerNode, format: format)
//                chordPlayers.append(chordPlayer)
//                let now = chordPlayer.lastRenderTime!.sampleTime
//                let startTime = AVAudioTime(sampleTime: now + AVAudioFramePosition(format.sampleRate), atRate: format.sampleRate)
//                let buffer = AVAudioPCMBuffer(pcmFormat: file!.processingFormat, frameCapacity: AVAudioFrameCount(file!.length))
//                try? file?.read(into: buffer)
//                chordPlayer.scheduleBuffer(buffer, completionHandler: {
//                    self.delegate?.didFinishPlayingNotes(notes)
//                    self.delegate?.didFinishPlaying()
//                })
//                chordPlayer.play()
//                delegate?.didStartPlayingNotes(notes)
            }
        }
    }
    
    func stop() {
//        if (scalePlayer!.isPlaying) {
//            scalePlayer?.stop()
//        }
//        if (!chordPlayers.isEmpty) {
//            for chordPlayer in chordPlayers {
//                if (chordPlayer.isPlaying) {
//                    chordPlayer.stop()
//                }
//                audioEngine?.disconnectNodeInput(chordPlayer)
//            }
//            chordPlayers.removeAll()
//        }
    }
}
