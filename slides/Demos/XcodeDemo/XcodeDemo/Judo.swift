//
//  Judo.swift
//  XcodeDemo
//
//  Created by Jon Flanders on 12/6/14.
//  Copyright (c) 2014 Flounderware. All rights reserved.
//

import Foundation


class JudoStudent{
	init(){
		
	}
	var studentLevel:JudoRanks? = .whiteBelt
	var studentID:Int?
	var studentFirstName:String?
	var studentLastName:String?
	//	var studentFirstName:String = "New"
	//	var studentLastName:String = "Student"
	func kick()
	{
		println("\(studentFirstName) kicked")
	}
	
}
enum JudoRanks :String
	
{
	func print() {
		
	}
	case whiteBelt = "White Belt"
	case blueBelt =  "Blue Belt"
	case yellowBelt = "Yellow Belt"
	case blackBelt = "Black Belt"
	//	func toString()->String{
	//		var ret = "White Belt"
	//		switch self{
	//		case .blackBelt:
	//			ret = "Black Belt"
	//		case .blueBelt:
	//			ret = "Blue Belt"
	//		case .yellowBelt:
	//			ret = "Yellow Belt"
	//		case .whiteBelt:
	//			break
	//		}
	//		return ret
	//	}
}