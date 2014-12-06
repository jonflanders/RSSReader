//
//  ChannelImageView.swift
//  RSSReader
//
//  Created by Jon Flanders on 12/5/14.
//  Copyright (c) 2014 Flounderware. All rights reserved.
//

import UIKit

class ChannelImageView: UIView {

	var imageURL:String?
	var image:UIImage?
	override  func willMoveToSuperview(newSuperview: UIView?) {
		self.backgroundColor = UIColor.clearColor()
		self.layer.masksToBounds = true
		self.layer.cornerRadius = 10.0
		if let img = self.image{
			self.addSubview(UIImageView(image:image))
		}
	}
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
