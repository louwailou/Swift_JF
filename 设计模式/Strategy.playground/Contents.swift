//: Playground - noun: a place where people can play

import UIKit
//: [Previous](@previous)

import Foundation

protocol JFStrategy {
    func compute(first:Int,second:Int)->Int;
}

class Add: JFStrategy {
    func compute(first: Int, second: Int) -> Int {
        return first + second;
    }
}

class Multiply: JFStrategy {
    func compute(first: Int, second: Int) -> Int {
        return first * second;
    }
}

class StrategyContext {
    let strategy:JFStrategy
    init(strategy:JFStrategy){
        self.strategy = strategy
        ;
    }
    func use(first:Int, second:Int){
        let intV =   self.strategy.compute(first, second: second);
        print("value = \(intV)")
    }
}

let context = StrategyContext(strategy: Add());
context.use(1,second: 3);






//  测试面向接口变成


class Ordered{
    func precedes(other:Ordered)-> Bool{
        print("error");
        return false
    }
}


class JFNumber:Ordered{
    var value:Double = 0;
    override func precedes(other: Ordered) -> Bool {
        //return self.value < other.value
        // 这样是需要强制转换为子类
        return self.value < (other as! JFNumber).value;
        
    }
}


// 如果是面向接口编程呢

protocol JFOrdered {
    //Self 代表任何遵循这个协议的类自身,这个才是重点
    //func preceds(other:Self)-> Bool;
}

struct JFPNumber:JFOrdered{
    var value:Double = 0;
    func preceds(other: JFPNumber) -> Bool {
        return self.value < other.value;
    }
    func giveMe(name: String) {
        print("JFPNUmber gaveMe");
    }
}


// 协议扩展可以添加默认的方法
extension JFOrdered{
    func giveMe(name:String){
        print("gaveme :\(name)")
    }
}

let number = JFPNumber();
number.giveMe("sunjianfeng")

let num:JFOrdered = JFPNumber();
num.giveMe("ddd")// 编译器只知道num为JFOrdered，所以调用 ordered的gaveMe方法



// 使用函数编程实现策略模式

let add = {
    (first:Int,second:Int)-> Int in
    return first + second
}

let multiply = {
    (first:Int,second:Int)-> Int in
    return first * second;
}
class ContextFP {
    let strategy:(Int,Int)-> Int
    
    init(strategy:(Int,Int)-> Int){
        self.strategy = strategy;
    }
    
    func use(first:Int,second:Int){
        self.strategy(first,second)
    }
}

let fpContext = ContextFP(strategy:multiply)

fpContext.use(1,second:3);





//: [Next](@next)
