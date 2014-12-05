//
//  DetailViewController.swift
//  RSSReader
//
//  Created by Jon Flanders on 11/29/14.
//  Copyright (c) 2014 Flounderware. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

	@IBOutlet weak var detailDescriptionLabel: UILabel!


	var detailItem: Feed? {
		didSet {
		    // Update the view.
		    self.configureView()
		}
	}

	func configureView() {
		// Update the user interface for the detail item.
		if let detail = self.detailItem {
		    if let label = self.detailDescriptionLabel {
		        label.text = detail.feedChannel.channelTitle
		    }
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.configureView()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

