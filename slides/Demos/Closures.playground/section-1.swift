// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
typealias AcccumFunction = ((Int)->Int)

func takesAFunction(f:AcccumFunction){
	println(f(42))
}
func accumulate(i:Int)->AcccumFunction{
	
	var oldValue  = i
	func realAccumulate(newValue:Int)->Int{
		oldValue = oldValue + newValue
		return oldValue
	}
	return realAccumulate
}

var myaccumulat = accumulate(42)
myaccumulat(42)
myaccumulat(2)
takesAFunction(myaccumulat)

