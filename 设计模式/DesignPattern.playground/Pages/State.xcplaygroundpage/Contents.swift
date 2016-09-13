//: [Previous](@previous)

import Foundation

/*:
  状态模式
 允许对象在内部状态改变时改变他的行为，对象看起来好像修改了她的类
 
 */

protocol JFState {
    
    func insertQuarter() -> Void ; // 收到25元
    func ejectQuarter()-> Void;// 退回25
    func trunCrank()->Void;// 开闸发放糖果
    func dispense()->Void;//发糖果

}

class GumballmMchine:NSObject {
    var soldOutState:JFState? ;
    var soldState:JFState?;
    var noQuarterState:JFState?;
    var hasQuarterState:JFState?;
    var state:JFState?;// {

    var count:NSInteger = 0;
    
    init(numberGumballs:NSInteger){
        
        super.init();
        self.soldState = SoldState(machine:self);
        self.soldOutState = SoldOutState(machine:self);
        self.noQuarterState = NoQuarterState(machine:self);
        self.hasQuarterState = HasQuarterState(machine: self);
    }
    func inserQuarter(){
        self.state!.insertQuarter();
    }
    
    func ejectQuarter(){
        self.state!.ejectQuarter();
    }
    
    func releaseBall(){
        print("realeseBall");
        if self.count > 0 {
            self.count = self.count - 1;
        }
    }
    func setAState(st:JFState?){
        if let nSt = st {
            self.state = nSt;
        }
        
    }
    
    
    func getNoQuarterState() -> JFState? {
        return self.noQuarterState;
    }
    func getHasQuarterState()->JFState?{
        return self.hasQuarterState;
    }
    func getSoldState()->JFState?{
        return self.soldState;
    }
    func getSoldOutState()->JFState?{
        return self.soldOutState;
    }
    
}
class NoQuarterState: JFState {
    var machine :GumballmMchine;
    init(machine:GumballmMchine){
        self.machine = machine;
    }
    
      func insertQuarter() {
        
    }
    
      func ejectQuarter() {
        
    }
      func trunCrank() {
        
    }
      func dispense() {
        
    }
    
}

class HasQuarterState: JFState {
    var machine :GumballmMchine;
    init(machine:GumballmMchine){
        self.machine = machine;
    }
    
     func insertQuarter() {
        print("在已经取得25的状态下不允许再获取25")
    }
    
     func ejectQuarter() {
        print("退回顾客的25")
       self.machine.setAState(self.machine.getNoQuarterState());
    }
     func trunCrank() {
        
    }
     func dispense() {
        
    }
    
}
class SoldState: JFState {
    var machine :GumballmMchine;
    init(machine:GumballmMchine){
        self.machine = machine;
    }
     func insertQuarter() {
        
    }
    
      func ejectQuarter() {
        
    }
     func trunCrank() {
        
    }
      func dispense() {
        self.machine.releaseBall();
        if self.machine.count > 0 {
            self.machine.setAState(self.machine.getNoQuarterState());
        }else{
             self.machine.setAState(self.machine.getSoldOutState());
        }
    }
    
}
class SoldOutState: JFState {
    var machine :GumballmMchine;
    init(machine:GumballmMchine){
        self.machine = machine;
    }
    
      func insertQuarter() {
     
    }
    
      func ejectQuarter() {
        
    }
      func trunCrank() {
        
    }
      func dispense() {
        
    }
    
}


/*
 状态模式，将一群行为封装在状态对象中，Context（Machine）的行为随时可以委托给那些状态对象中的一个，随着时间的流逝，当前状态在状态对象中游走改变，以反映出context内部的状态，因此context的行为也会跟着改变，但是context的客户对于状态对象了解不多。
 
 */




//: [Next](@next)
