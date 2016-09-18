//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, 复合模式"
// 鸭子 呱呱叫
protocol Quackable {
    func quack() -> Void
}

class LvTouYa: Quackable {
    func quack() {
        print("绿头鸭呱呱叫")
    }
}

class ChangZuiYa: Quackable {
    func quack() {
        print("长嘴鸭 呱呱叫")
    }
}


class DuckSimlulator {
    func simulator(duck:Quackable){
        duck.quack()
    }
    
    func simulator(){
        let lv = LvTouYa()
        let chang = ChangZuiYa()
        lv.quack();
        chang.quack();
    }
}

let simulator = DuckSimlulator()
simulator.simulator();

//现在鹅 也想呱呱叫，但是鹅是嘎嘎叫啊

class Goose  {
    func hood() {
        print("我家大鹅 也要嘎嘎叫")
    }
}
// 采用适配器模式
class GooseAdapter: Quackable {
    var goose:Goose;
    init(goose:Goose){
        self.goose = goose;
    }
    func quack() {
        self.goose.hood();
        
    }
}



// 再次修改simulator 
extension DuckSimlulator{
    func simulatorGoose(){
        let lv = LvTouYa()
        let chang = ChangZuiYa()
        let gooseAdapter = GooseAdapter(goose:Goose())
        lv.quack();
        chang.quack();
        gooseAdapter.quack()
        
    }
}
let sim = DuckSimlulator()
sim.simulatorGoose()




// 问题  如果不新增适配类，使用extension 实现 可以吗

extension Goose :Quackable{
    func quack() {
        self.hood()
        print(" 鹅 也能呱呱交了")
    }
}

let goose = Goose();
goose.quack();



//  现在我们要 统计呱呱叫的次数, 不修改鸭子的行为
// 装饰者模式 实现一个包装器，但是 你必须通过装饰对象才能获得被装饰的行为

class QuackCounter: Quackable{
    var duck:Quackable
    static var  numerOfQuack:Int = 0
    init(duck:Quackable){
        self.duck = duck;
    }
    func quack() {
        QuackCounter.numerOfQuack += 1
        print("呱呱叫")
    }
   class  func getCount()-> Int{
        return QuackCounter.numerOfQuack;
    }
}

let q1 = QuackCounter(duck: LvTouYa())
q1.quack();
let q2 = QuackCounter(duck: Goose())
q2.quack();

let count = QuackCounter.getCount()


// 抽象工厂模式 创建一系列产品
protocol AbstractDuckFactory{
    func createMallardDuck()-> Quackable;
    func createRedHeadDuck()-> Quackable;
    //func createDuckCall()->Quackable;
    //func createRubberDuck()->Quackable;
}


class DuckFactory :AbstractDuckFactory{
    func createMallardDuck() -> Quackable {
        return LvTouYa();
    }
    func createRedHeadDuck() -> Quackable {
        return Goose();
    }
}


// countingDuckFactory

class  CountingDuckFactory: AbstractDuckFactory {
    func createRedHeadDuck() -> Quackable {
        return QuackCounter(duck: LvTouYa())
    }
    func createMallardDuck() -> Quackable {
        return QuackCounter(duck: ChangZuiYa())
    }
}


//  内鹅外鸭 的例子 咋实现？？？


// 如果我们要管理一组鸭子，统一他们的行为，用啥模式？？》

// 组合模式 迭代模式
class Flock :Quackable
{
    var quackers :Array<Quackable> = [Quackable]();
    func quack() {
        for item in quackers {
            item.quack();
        }
    }
    func add(quack:Quackable){
        quackers.append(quack)
    }
}


// 现在行为学家想看看呱呱叫鸭子的行为 --------- 观察者模式
// 分析一下 谁作为观察者，谁作为被观察者(主题)
//由主题实现此接口
protocol QuackObservable {
    func notifyObservers()->Void;
    func registerObserver(observer:Observer)->Void;
    
}

// 观察者接口
protocol Observer {
    func update(duck :QuackObservable);
}

class JFObservable :QuackObservable{
    var observers:Array<Observer> = Array<Observer>()
    var duck:QuackObservable;
    init(duck:QuackObservable){
        self.duck = duck;
    }
    
    func notifyObservers() {
        for item in self.observers {
            item.update(self.duck)
        }
    }
    func registerObserver(observer: Observer) {
        self.observers.append(observer)
    }
}
//
//extension LvTouYa :QuackObservable{
//    
//    
//    func notifyObservers() {
//       self.observable.notifyObservers()
//    }
//    func registerObserver(observer: Observer) {
//        self.observable.regis
//    }
//}


class Quackologist :Observer{
    func update(duck: QuackObservable) {
        print("quackologist duck just quacked.....")
    }
}









