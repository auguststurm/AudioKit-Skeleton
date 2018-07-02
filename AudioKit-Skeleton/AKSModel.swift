//
//  AKSModel.swift
//  AudioKit-Skeleton
//
//  Created by August Sturm on 7/1/18.
//  Copyright © 2018 Audio Kit Skeleton. All rights reserved.
//

import Foundation
import SwiftyJSON
import AVFoundation

class AKSModel {
	
	class public func getSampleData() -> JSON {
		var samplesJSON = JSON()
		if let sampleDataFilePath = Bundle.main.path(forResource: "samplesData", ofType: "json") {
			do {
				let samplesData = try Data(contentsOf: URL(fileURLWithPath: sampleDataFilePath), options: .alwaysMapped)
				samplesJSON = try JSON(data: samplesData)
			} catch let error {
				print(error.localizedDescription)
			}
		}
		return samplesJSON
	}
	
	class public func getSampleDuration(sampleFilename: String) -> Double {
		let sampleFileAsset = AVURLAsset(url: fileURLFor(sampleFilename: sampleFilename))
		let sampleFileDuration = Double(CMTimeGetSeconds(sampleFileAsset.duration))
		return sampleFileDuration
	}
	
	class public func fileURLFor(sampleFilename: String) -> URL {
		let sampleFileAndExtension = sampleFilename.components(separatedBy: ".")
		let sampleFilePath = Bundle.main.path(forResource: sampleFileAndExtension[0], ofType: sampleFileAndExtension[1], inDirectory: "Samples")
		let sampleFileURL = URL(fileURLWithPath: sampleFilePath!)
		return sampleFileURL
	}
	
}
