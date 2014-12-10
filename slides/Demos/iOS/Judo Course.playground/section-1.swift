// Playground - noun: a place where people can play

import UIKit








/*
var date:NSDate? = NSDate()


class JudoStudent{
init(first:String, last:String)
{
self.studentFirstName = first
self.studentLastName = last

}

var studentFirstName:String
var studentLastName:String
//	var studentFirstName:String = "New"
//	var studentLastName:String = "Student"
func kick()
{
println("\(studentFirstName) kicked")
}

}

var j = JudoStudent(first: "Jon",last: "Flanders")

j.kick()*/






struct JudoStudent{
		var studentLevel:JudoRanks = .whiteBelt
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
enum JudoRanks :String, PrintMe
	
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


interface PrintMe{
	func print()
}
struct Foo : PrintMe{
	var property:String
	var property2:Int
	var property3:JudoRanks
	func print() {
		
	}
}


func useString(str:String){
	println("string value is \(str)")
}
//class JudoStudent{
//	var studentLevel:JudoRanks = .whiteBelt
//	var studentID:Int?
//	var studentFirstName:String?
//	var studentLastName:String?
////	var studentFirstName:String = "New"
////	var studentLastName:String = "Student"
//	func kick()
//	{
//		println("\(studentFirstName) kicked")
//	}
//	
//}
var optionalJudoStudent:JudoStudent? = JudoStudent()
if let student = optionalJudoStudent?{
	student.kick()
}

var j = JudoStudent()
j.studentID = 42
j.studentFirstName = "Jon"
//useString(j.studentFirstName)
if let realString = j.studentFirstName?{
	if let realString2 = j.studentLastName? {
		useString(realString + realString2)
	}
}


println(j.studentFirstName)
j.kick()






















