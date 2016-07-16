//
//  JFProtocol.swift
//  ProSwift
//
//  Created by Sun on 15/12/7.
//  Copyright © 2015年 Sun. All rights reserved.
//

import Foundation
/*
协议不指定属性是存储型属性还是计算型属性，它只指定属性的名称和类型。此外，协议还指定属性是只读的还是可读可写的。

如果协议要求属性是可读可写的，那么该属性不能是常量属性或只读的计算型属性。如果协议只要求属性是只读的，那么该属性不仅可以是只读的，如果代码需要的话，还可以是可写的。

*/
protocol JFProtocol {
    var mustBeSttable :Int{get set}
    var doesNotneedTobeSettable:Int {get}
}

protocol FullyNamed {
    var fullName: String { get }
}
/// <#Description#>
class Starship: FullyNamed {
    var prefix: String?
    var name: String// 对于非可可选属性，必须提供一个初始化函数
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}

/*方法要求

不需要大括号和方法体。可以在协议中定义具有可变参数的方法，和普通方法的定义方式相同。但是，不支持为协议中的方法的参数提供默认值。
*/
protocol RandomNumberGenerator {
    func random() -> Double
}

//将 mutating 关键字作为方法的前缀，写在 func 关键字之前，表示可以在该方法中修改它所属的实例以及实例的任意属性的值,关键是修改该实例
//实现协议中的 mutating 方法时，若是类类型，则不用写 mutating 关键字。而对于结构体和枚举，则必须写 mutating 关键字

protocol Togglable {
    mutating func toggle()
}
enum OnOffSwitch: Togglable {
    case Off, On
    mutating func toggle() {
        switch self {
        case Off:
            self = On
        case On:
            self = Off
        }
    }
}

/*
协议作为类型
尽管协议本身并未实现任何功能，但是协议可以被当做一个成熟的类型来使用。

协议可以像其他普通类型一样使用，使用场景如下：

作为函数、方法或构造器中的参数类型或返回值类型
作为常量、变量或属性的类型
作为数组、字典或其他容器中的元素类型

*/

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}
/*
var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
for _ in 1...5 {
print("Random dice roll is \(d6.roll())")
}
// Random dice roll is 3
// Random dice roll is 5
// Random dice roll is 4
// Random dice roll is 5
// Random dice roll is 4

*/


/*
通过扩展添加协议一致性
即便无法修改源代码，依然可以通过扩展令已有类型采纳并符合协议。扩展可以为已有类型添加属性、方法、下标脚本以及构造器，因此可以符合协议中的相应要求。详情请在扩展章节中查看。

protocol TextRepresentable {
var textualDescription: String { get }
}
可以通过扩展，令先前提到的 Dice 类采纳并符合 TextRepresentable 协议：

extension Dice: TextRepresentable {
var textualDescription: String {
return "A \(sides)-sided dice"
}
}
*/

/*
协议的继承
协议能够继承一个或多个其他协议，可以在继承的协议的基础上增加新的要求。协议的继承语法与类的继承相似，多个被继承的协议间用逗号分隔：

protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
// 这里是协议的定义部分
}

*/


protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Persons: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(celebrator: protocol<Named, Aged>) {
    print("Happy birthday \(celebrator.name) - you're \(celebrator.age)!")
}


class JFProtocolTest {
    func test(){
        let birthdayPerson = Persons(name: "Malcolm", age: 21)
        wishHappyBirthday(birthdayPerson)
        
    }
}

/* 检测协议的一致性
你可以使用类型转换中描述的 is 和 as 操作符来检查协议一致性，即是否符合某协议，并且可以转换到指定的协议类型。检查和转换到某个协议类型在语法上和类型的检查和转换完全相同：

is 用来检查实例是否符合某个协议，若符合则返回 true，否则返回 false。
as? 返回一个可选值，当实例符合某个协议时，返回类型为协议类型的可选值，否则返回 nil。
as! 将实例强制向下转换到某个协议类型，如果强转失败，会引发运行时错误。
let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(area: 243_610),
    Animal(legs: 4)
]


for object in objects {
    if let objectWithArea = object as? HasArea {
      print("Area is \(objectWithArea.area)")
     } else {
      print("Something that doesn't have an area")
     }
}
当迭代出的元素符合 HasArea 协议时，将 as? 操作符返回的可选值通过可选绑定，绑定到 objectWithArea 常量上。objectWithArea 是 HasArea 协议类型的实例，因此 area 属性可以被访问和打印

*/


//可选的协议要求

//协议可以定义可选要求，采纳协议的类型可以选择是否实现这些要求。在协议中使用 optional 关键字作为前缀来定义可选要求。使用可选要求时（例如，可选的方法或者属性），它们的类型会自动变成可选的。比如，一个类型为 (Int) -> String 的方法会变成 ((Int) -> String)?。需要注意的是整个函数类型是可选的，而不是函数的返回值。

//协议中的可选要求可通过可选链式调用来使用，因为采纳协议的类型可能没有实现这些可选要求。类似 someOptionalMethod?(someArgument) 这样，你可以在可选方法名称后加上 ? 来调用可选方法。详细内容可在可选链式调用章节中查看

@objc protocol CounterDataSource {
    optional func incrementForCount(count: Int) -> Int
    optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.incrementForCount?(count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}


