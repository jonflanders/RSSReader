//
//  UIImage.swift
//  RSSReader
//
//  Created by Jon Flanders on 12/5/14.
//  Copyright (c) 2014 Flounderware. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
	func updateImage(url:String){
		let conn = ServerConnectionManager()
		conn.get(url, callback: { (data, e) -> Void in
			if let realData = data{
				
				dispatch_async(dispatch_get_main_queue(), { () -> Void in
					self.image = UIImage(data:realData)

				})
			}
		})		
	}
}