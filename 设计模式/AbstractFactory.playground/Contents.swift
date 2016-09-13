//: Playground - noun: a place where people can play

import UIKit

protocol Product {
    var brand : String {get}
    var name : String {get}
}

protocol Phone:Product {
    
}

protocol Pad:Product {
    
}

class ApplePhone: Phone {
  		var brand: String {
            return "Apple"
  		}
    
  		var name: String
  		init(name: String) {
            self.name = name
  		}
}
class SamsungPhone: Phone {
  		var brand: String {
            return "Samsung"
  		}
  		var name: String
  		init(name: String) {
            self.name = name
  		}
}
class ApplePad: Pad {
  		var brand: String {
            return "Apple"
  		}
	  	var name: String
  		init(name: String) {
            self.name = name
  		}
}
class SamsungPad: Pad {
  		var brand: String {
            return "Samsung"
  		}
  		var name: String
  		init(name: String) {
            self.name = name
  		}
}



protocol AbstractFactory {
  		func createPhone() -> Phone
  		func createPad() -> Pad
}
// Concrete Factory
class AppleFactory: AbstractFactory {
  		func createPhone() -> Phone {
            return ApplePhone(name: "iPhone 6S")
  		}
  		func createPad() -> Pad {
            return ApplePad(name: "iPad Air 2")
  		}
}
class SamsungFactory: AbstractFactory {
  		func createPhone() -> Phone {
            return SamsungPhone(name: "Note 5")
  		}
  		func createPad() -> Pad {
            return SamsungPad(name: "Note")
  		}
}



let appleFactory: AbstractFactory = AppleFactory()
appleFactory.createPad()


let samsungFactory: AbstractFactory = SamsungFactory()
samsungFactory.createPhone()



// 柯里化函数
//柯里化函数（Curried Function），是指接受多个参数的函数变换成接受一个单一参数（最初函数的第一个参数）的函数，该函数返回一个接受余下参数的新函数
func createProductWithType(type:String)(brand:String)(name:String)-> Product?{
    switch (type,brand) {
    case ("Phone","Apple"):
        return ApplePhone(name: name);
    case ("Pad","Apple"):
        return ApplePad(name: name)
        
    case ("Phone","Samsung"):
        return SamsungPhone(name: name)
    case ("Pad","Samsung"):
        return SamsungPad(name: name);
    default:
        return nil
    }
}


let createApplePhone = createProductWithType("Phone")(brand: "Apple")
let createSamsungPhone = createProductWithType("Phone")(brand: "Samsung")
let createApplePad = createProductWithType("Pad")(brand: "Apple")
let createSamsungPad = createProductWithType("Pad")(brand: "Samsung")
// Use
let applePhone = createApplePhone(name: "iPhone 6S")
print(applePhone)














