//
//  JFBasicClass.swift
//  ProSwift
//
//  Created by Sun on 15/11/24.
//  Copyright © 2015年 Sun. All rights reserved.
//

import Foundation
struct Point {
    var x = 0.0, y = 0.0
     mutating func moveByX(deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}
/*

结构体和枚举是值类型。一般情况下，值类型的属性不能在它的实例方法中被修改。

但是，如果你确实需要在某个特定的方法中修改结构体或者枚举的属性，你可以选择变异(mutating)这个方法，然后方法就可以从方法内部改变它的属性；并且它做的任何改变在方法结束时还会保留在原始结构中。方法还可以给它隐含的self属性赋值一个全新的实例，这个新实例在方法结束后将替换原来的实例。

要使用变异方法，将关键字mutating 放到方法的func关键字之前就可以了


注意，不能在结构体类型的常量上调用可变方法，因为其属性不能被改变，即使属性是变量属性，详情参见常量结构体的存储属性：

let fixedPoint = Point(x: 3.0, y: 3.0)
fixedPoint.moveByX(2.0, y: 3.0)
// 这里将会报告一个错误



*/


/*
var ovenLight = TriStateSwitch.Low
ovenLight.next()
// ovenLight 现在等于 .High
ovenLight.next()
// ovenLight 现在等于 .Off
*/

class JFBasicClass {
    var someInts = [Int]();
    var threeDoubles = [Double](count: 3, repeatedValue:0.0)
    var anotherThreeDoubles = Array(count: 3, repeatedValue: 2.5){
        willSet(newValue){
             print("arrnewValue  = \(newValue) oldValue = \(self.anotherThreeDoubles)");
        }
        didSet{
              print("arrnewValue  = \(oldValue) newVlaue = \(self.anotherThreeDoubles)");
        }
    }
    var shoppingList = ["Eggs", "Milk"];
    
    var height:Int = 0 {
        willSet (newValue){
            print("newValue  = \(newValue) oldValue = \(height)");
        }
        didSet (oldValue){
             print("newValue  = \(oldValue) oldValue = \(height)");
        }
    }
    
    var arrForClass:[SomeClass] = [SomeClass(p: 1),SomeClass(p:2),SomeClass(p: 3)]; //[SomeClass]();
    
    
    //字典
    var namesOfIntegers = [Int: String]()
    var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
    func useMe(){
        if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
            print("The old value for DUB was \(oldValue).")
        }
        for (airportCode, airportName) in airports {
            print("\(airportCode): \(airportName)")
        }
    }
    func testDic(){
        // 说明dictionary array 都是值类型
        var dic = [String:String]() ;
        dic["one"] = "sunjianfeng";
        dic["two"] = "tttttt";
        var otherDic = dic;
        otherDic["one"] = "孙建锋";
        print("\(dic["one"]!)");
        print("\(dic["two"]!)");
    }
    func changeHeight(){
        self.height = 10;
    }
    func arrTest(){
        self.changeArray(self.anotherThreeDoubles);
         print("didChange change\(self.anotherThreeDoubles)")
        /*
        before change[2.5, 2.5, 2.5]
        after change[2.5, 2.5, 2.5, 1000.0]
        didChange change[2.5, 2.5, 2.5]
        再次验证了array是值类型
        */
       // self.arrForClass[0].pint = 2000;
        
        self.changeClassArr(&self.arrForClass);
        print("\n didChangeClassarrr ");
        
         self.printArrClass(self.arrForClass);
        /*
        
        before change[2.5, 2.5, 2.5]
        
        after change[2.5, 2.5, 2.5, 1000.0]
        
        didChange change[2.5, 2.5, 2.5]
        
        before change
        
        someClassInt1
        
        
        someClassInt2
        
        
        someClassInt3
        
        
        after change
        
        someClassInt10000
        
        
        someClassInt2
        
        
        someClassInt3
        
        
        someClassInt5
        
        
        didChangeClassarrr 
        
        someClassInt10000
        
        
        someClassInt2
        
        
        someClassInt3
        */
    }
    func changeArray(var anotherArr :[Double]){
       // self.anotherThreeDoubles .append(100);
        print("before change\(anotherArr)\n")
        anotherArr.append(1000);
        print("after change\(anotherArr)\n")
    }
    func changeClassArr(inout anotherArr :[SomeClass]){
        print("\n before change")
         self.printArrClass(anotherArr);
        anotherArr[0].pint = 10000;
        //说明数组是值类型，所以对数组的修改不会影响全局变量，但是修改数组中的类型是类类型- 引用类型，所以对数组元素的修改hi影响所引用的元素 , 另外如果是inout修饰就随便修改了
        anotherArr.append(SomeClass(p: 5));
        print("\n after change")
        self.printArrClass(anotherArr);
    }
    func printArrClass(arr:[SomeClass]){
        for item in arr{
            print("\n someClassInt\(item.pint)\n");
        }
       
    }
}



struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 6
    }
}
class SomeClass {
    var pint:Int = 0;
    var myCumputeProperty:Point {
        return Point(x: (Double( pint) + 20.0), y: Double(pint) + 34.9);
    }
    
    var totalSteps:Int {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
    init (p:Int,at :Int){
        self.pint = p;
        self.totalSteps = at;
    }
    init (p:Int){
        self.pint = p;
        self.totalSteps = 0;
    }
    
}

class otherClass :SomeClass {
    var overrideableComputedTypeProperty :Int {
        return 100;
    }
}