//
//  ChannelImageView.swift
//  RSSReader
//
//  Created by Jon Flanders on 12/5/14.
//  Copyright (c) 2014 Flounderware. All rights reserved.
//

import UIKit

class ChannelImageView: UIView {

	var imageURL:String?{
		didSet{
			self.image!.updateImage(self.imageURL!)
		}
	}
	var image:UIImageView?
	override  func willMoveToSuperview(newSuperview: UIView?) {
		self.contentMode = UIViewContentMode.ScaleAspectFill
			self.image = UIImageView(image: UIImage(named: "rss"))
		self.backgroundColor = UIColor.clearColor()
		self.layer.masksToBounds = true
		self.layer.cornerRadius = self.frame.size.height / 2
		if let img = self.image{
			img.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
			self.addSubview(img)
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
