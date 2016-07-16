//: [Previous](@previous)

import Foundation

/****************闭包***************/

var reverdNames = ["1","3","0","23"];
reverdNames.sort { (a1, a2) -> Bool in
    return a1 > a2;
}

reverdNames.sort{ a1,a2 in a1 > a2 };

//Swift 自动为内联闭包提供了参数名称缩写功能，您可以直接通过$0，$1，$2来顺序调用闭包的参数

reverdNames.sort{$0 > $1 };

//尾随闭包（Trailing Closures）
//尾随闭包是一个书写在函数括号之后的闭包表达式，函数支持将其作为最后一个参数调用：
reverdNames.sort(){ $0 > $1}
//: **闭包是引用类型**

//: ####非逃逸闭包&逃逸闭包
//: 当一个闭包作为参数传到一个函数中,但是这个闭包在函数返回之后才被执行,我们称该闭包从函数中逃逸

let customerProvider = {reverdNames.removeAtIndex(0)};
//: coustomerProvider 的类型是 ()->String

//:自动闭包
/*:

 */

func serveCustomer(@autoclosure customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serveCustomer(reverdNames.removeAtIndex(0))
//@autoclosure特性暗含了@noescape特性，这个特性在非逃逸闭包一节中有描述。如果你想让这个闭包可以“逃逸”，则应该使用@autoclosure(escaping)特性.



 