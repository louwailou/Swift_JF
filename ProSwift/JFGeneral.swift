
//
//  JFGeneral.swift
//  ProSwift
//
//  Created by Sun on 15/12/7.
//  Copyright © 2015年 Sun. All rights reserved.
//

import Foundation

func swapTwoStrings(inout a: String, inout _ b: String) {
    let temporaryA = a
    a = b
    b = temporaryA
}

func swapTwoDoubles(inout a: Double, inout _ b: Double) {
    let temporaryA = a
    a = b
    b = temporaryA
}
/**
 泛型函数
 
 - parameter a: <#a description#>
 - parameter b: <#b description#>
 */
func swapTwoValues<T>(inout a: T, inout _ b: T) {
    let temporaryA = a
    a = b
    b = temporaryA
}


// func swapTwoValues<T>(inout a: T, inout _ b: T)
//占位类型名没有指明 T 必须是什么类型，但是它指明了 a 和 b 必须是同一类型 T，而无论 T 代表什么类型。只有 swapTwoValues(_:_:) 函数在调用时，才能根据所传入的实际类型决定 T 所代表的类型。



struct Stack<Element> {
    var items = [Element]()
    mutating func push(item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}
//  扩展一个泛型
extension Stack {
    var topItem: Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

/*
类型约束

类型约束语法

你可以在一个类型参数名后面放置一个类名或者协议名，通过冒号分隔，从而定义类型约束，它们将作为类型参数列表的一部分。这种基本的类型约束作用于泛型函数时的语法如下所示（作用于泛型类型时的语法与之相同）：

func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
// 这里是泛型函数的函数体部分
}
上面这个函数有两个类型参数。第一个类型参数 T，有一个要求 T 必须是 SomeClass 子类的类型约束；第二个类型参数 U，有一个要求 U 必须符合 SomeProtocol 协议的类型约束。

*/


// 关联类型

/*
关联类型
定义一个协议时，有的时候声明一个或多个关联类型作为协议定义的一部分将会非常有用。关联类型作为协议的一部分，为某个类型提供了一个占位名（或者说别名），其代表的实际类型在协议被采纳时才会被指定。你可以通过 typealias 关键字来指定关联类型。


关联类型实践

下面例子定义了一个 Container 协议，该协议定义了一个关联类型 ItemType：


*/
protocol Container {
    typealias ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}


struct IntStack: Container {
    // IntStack 的原始实现部分
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // Container 协议的实现部分
    typealias ItemType = Int
    mutating func append(item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}


struct Stacks<Element>: Container {
    // Stack<Element> 的原始实现部分
    var items = [Element]()
    mutating func push(item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // Container 协议的实现部分
    mutating func append(item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}
