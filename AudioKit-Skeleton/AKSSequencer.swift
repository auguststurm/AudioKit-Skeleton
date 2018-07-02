//
//  AKSSequencer.swift
//  AudioKit-Skeleton
//
//  Created by August Sturm on 7/1/18.
//  Copyright © 2018 Audio Kit Skeleton. All rights reserved.
//

import Foundation
import AudioKit
import SwiftyJSON
import Timepiece

class AKSSequencer: NSObject {
	
	private var midi: AKMIDI!
	private var sequencer: AKSequencer!
	private var mixer: AKMixer!
	private var samplers: [AKMIDISampler]!
	private var tracks: [AKMusicTrack]!
	
	private var callbackInstrument: AKCallbackInstrument!
	private var callbackTrack: AKMusicTrack!
	
	override init() {
		midi = AKMIDI()
		samplers = [AKMIDISampler]()
		tracks = [AKMusicTrack]()
		mixer = AKMixer()
		sequencer = AKSequencer()
		AudioKit.output = mixer
	}
	
	// MARK: - Public
	
	public func generateSequenceFor(allSamples: JSON) {
		
		let startTime = Date()
		let finishTime = Date() + allSamples[allSamples.count - 1]["startSecond"].doubleValue
		let finalFileLength = AKSModel.getSampleDuration(sampleFilename: allSamples[allSamples.count - 1]["filename"].stringValue)
		let totalSeconds = finishTime.timeIntervalSince(startTime) + finalFileLength
		
		let totalMinutes = totalSeconds / 60.0
		let tempoBPM = 120.0
		let totalBeats = (totalMinutes * tempoBPM).rounded(.up)
		
		// prep sequencer
		
		sequencer.setLength(AKDuration(beats: totalBeats, tempo: tempoBPM))
		
		
		for sample in allSamples {
			
			
			
		}
		
	}
	
	public func generateSingleSampleSequenceFor(sample: JSON) {
		
	}
	
	// MARK: - Private

	private func buildSampleTrack(sampleData: JSON) {
		
		let sampler = AKMIDISampler()
		let track: AKMusicTrack!
		let filename = sampleData["filename"].stringValue
		let fileURL = AKSModel.fileURLFor(sampleFilename: filename)
		let fileIdentifier = filename.components(separatedBy: ".")[0].lowercased()
		do {
			try sampler.loadAudioFile(AKAudioFile(forReading: fileURL))
		} catch let error {
			print(error.localizedDescription)
			return
		}
		sampler.enableMIDI(midi.client, name: fileIdentifier)
		track = sequencer.newTrack("\(fileIdentifier)_track")
		track.setMIDIOutput(sampler.midiIn)
		mixer.connect(input: sampler)
		samplers.append(sampler)
		
		let noteNumber = MIDINoteNumber(sampleData["note"].stringValue)!
		let velocity = MIDIVelocity(sampleData["volume"].doubleValue)
		let position = AKDuration(seconds: sampleData["startSecond"].doubleValue)
		let duration = AKDuration(seconds: AKSModel.getSampleDuration(sampleFilename: sampleData["filename"].stringValue))
		
		track.add(noteNumber: noteNumber, velocity: velocity, position: position, duration: duration)
		
		
	}
	
}
