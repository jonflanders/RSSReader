//
//  CustomPersonView.swift
//  XcodeDemo
//
//  Created by Jon Flanders on 12/6/14.
//  Copyright (c) 2014 Flounderware. All rights reserved.
//

import UIKit

@IBDesignable class CustomPersonView: UIView {

	override func prepareForInterfaceBuilder() {
		
	}
	@IBInspectable var imageName:String?{
		didSet{
			self.configureView()
		}
	}
	func configureView()
	{
		if let realName = self.imageName{
			var image = UIImage(named: realName)
			var imageView = UIImageView(image: image)
			self.layer.cornerRadius = self.frame.height/2
			self.layer.masksToBounds  = true
			self.addSubview(imageView)
		}
	}
}
