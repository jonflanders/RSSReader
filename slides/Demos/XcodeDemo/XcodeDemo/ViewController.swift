//
//  ViewController.swift
//  XcodeDemo
//
//  Created by Jon Flanders on 12/6/14.
//  Copyright (c) 2014 Flounderware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet weak var personView2: CustomPersonView!
	@IBOutlet var personView:CustomPersonView?
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		var student = JudoStudent()
		self.personView?.imageName = "defaultStudent"
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

