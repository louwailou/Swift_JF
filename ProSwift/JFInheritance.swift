//
//  JFInheritance.swift
//  ProSwift
//
//  Created by Sun on 15/11/27.
//  Copyright © 2015年 Sun. All rights reserved.
//

import Foundation
class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    func makeNoise() {
        // 什么也不做-因为车辆不一定会有噪音
    }
}

class Bicycle: Vehicle {
    var hasBasket = false
}

/*
重写（Overriding）
子类可以为继承来的实例方法（instance method），类方法（class method），实例属性（instance property），或下标脚本（subscript）提供自己定制的实现（implementation）。

*/

class Train: Vehicle {
    override func makeNoise() {
        super.makeNoise();
        print("Choo Choo")
    }
}


/*重写属性   你可以将一个继承来的只读属性重写为一个读写属性，只需要在重写版本的属性里提供 getter 和 setter 即可。但是，你不可以将一个继承来的读写属性重写为一个只读属性  
// 范围只可以扩大 不可以缩小


*/


class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}

/*  重写属性观察器（Property Observer）

你不可以为继承来的常量存储型属性或继承来的只读计算型属性添加属性观察器。这些属性的值是不可以被设置的，所以，为它们提供willSet或didSet实现是不恰当。
此外还要注意，你不可以同时提供重写的 setter 和重写的属性观察器。如果你想观察属性值的变化，并且你已经为那个属性提供了定制的 setter，那么你在 setter 中就可以观察到任何值变化了。

*/
class AutomaticCar: Car {
    override var currentSpeed: Double {

    
        didSet {
            gear = Int(currentSpeed / 10.0) + 1
        }
    }
}

/*  
防止重写
你可以通过把方法，属性或下标脚本标记为final来防止它们被重写，只需要在声明关键字前加上final修饰符即可（例如：final var，final func，final class func，以及final subscript）。

如果你重写了final方法，属性或下标脚本，在编译时会报错。在类扩展中的方法，属性或下标脚本也可以在扩展的定义里标记为 final 的。

你可以通过在关键字class前添加final修饰符（final class）来将整个类标记为 final 的。这样的类是不可被继承的，试图继承这样的类会导致编译报错。
*/
