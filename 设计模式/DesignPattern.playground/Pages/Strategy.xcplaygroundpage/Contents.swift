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



//: [Next](@next)
