//: Playground - noun: a place where people can play

import UIKit

var str = "Hello,Generic Type"

func swap<T:Equatable>(inout left:T,inout right:T){
    let temp = left
    left = right
    right = temp
}


var a = 100
var b = 200
swap(&a, right: &b)

// 关联类型
/*
 在定义协议的时候，有时候用一个或者多个关联类型作为定义协议的一部分，关联类型作为协议的一部分，为某个类型提供了一个占位符，其实际类型会在采纳的时候被指定。并用关键字associatedtype（ typealias 已废弃） 关键字来指定关联名
 */

protocol Container {
    associatedtype itemType
    mutating func append(item:itemType)
    var count:Int {get}
    subscript(i:Int)->itemType {get}
}

struct IntStack:Container {
    typealias itemType = Int
    mutating func append(item: Int) {
        self.push(item)
    }
    var count: Int{
        return items.count;
    }
    subscript (i:Int)->itemType{
        return items[i]
    }
    var items = [Int]()
    
    
    
    mutating func push(item:Int){
        items.append(item)
    }
    mutating func pop()->Int{
        return items.removeLast()
    }
}





struct genericStack<Element>:Container{
    // genericStack<Element> 的原始实现部分
    var items = [Element]()
    mutating func push(item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    
    // Container 协议的实现部分
    typealias ItemType = Element
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


// where 子句

func allItemsMatch<C1:Container,C2:Container where C1.itemType == C2.itemType,C1.itemType:Equatable>(someContainer:C1,_ anotherContainer:C2) -> Bool{
    if someContainer.count != anotherContainer.count{
        return false
    }
    
    for i in 0...someContainer.count-1{
        if someContainer[i] != anotherContainer[i]{
            return false
        }
    }
    return true
}




















