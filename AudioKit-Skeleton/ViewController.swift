//
//  ViewController.swift
//  AudioKit-Skeleton
//
//  Created by August Sturm on 7/1/18.
//  Copyright © 2018 Audio Kit Skeleton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		initialize()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	private func initialize() {
		
		let sampleData = AKSModel.getSampleData()
		
		for sampleIndex in 0..<sampleData.count {
			
//			let fileDuration = AKSModel.getSampleDuration(sampleFilename: sampleData[sampleIndex]["filename"].stringValue)
			
			
		}
		
	}


}

