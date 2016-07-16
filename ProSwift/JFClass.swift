//
//  JFClass.swift
//  ProSwift
//
//  Created by Sun on 15/11/24.
//  Copyright © 2015年 Sun. All rights reserved.
//

import Foundation
/**
 *  结构体和枚举都是值类型
 */
struct Resolutioin {
    var width = 0
    var height = 0
}

class JFClass :NSObject{
    var resolution = Resolutioin()
    var interlaced = false
    var frameRate = 0.0
    var name:String?
    var jfClass:JFBasicClass = JFBasicClass(){
        willSet{
              print("arrnewValue  = \(newValue) oldValue = \(self.jfClass)");
        }
        didSet{
              print("arrnewValue  = \(self.jfClass) oldValue = \(oldValue)");
        }
    }
//    override func init() {
//        
//    }
    
    //jfClass.changeBaseClass(<#T##numberd: Int##Int#>, amount: <#T##Int#>);//第二个外部参数是默认的
    // jfClass.changeBaseClass(<#T##numberd: Int##Int#>, amounts: <#T##Int#>)
    // 添加了_ jfClass.changeBaseClass(<#T##numberd: Int##Int#>, <#T##amount: Int##Int#>)
    
    func changeBaseClass(numberd :Int,_ amount :Int){// 有了_ 就不会再添加外部的参数名了
        self.jfClass.height = 100;
        
        var cl = self.jfClass;// 只要更改了指针的指向，甚至是仅仅切换而已都会触发willSet方法，但是如果仅仅修改jfClass中俄某一个属性，是不会触发willSet的
        
        self.jfClass = cl;
        cl = self.jfClass;
        
    }
    func useMe(){
        print("\(resolution.height)");
        let resolutionForlet = Resolutioin(width: 100, height: 100)//
        /**
        *  对于结构体有默认的初始化构造函数，Resolutioin(width: , height: ) 类没有
        */
        
        print("\(resolutionForlet.width)");
        
    }
    
    /**
    *  针对类的 == 运算符，自定义的类未提供默认的实现，所以比较的话使用 === 恒等运算符，比较两个对象是否指向同一个对象
      == 运算符其实比较的是类变量是否全部相等 
    
    请注意，“等价于”（用三个等号表示，===）与“等于”（用两个等号表示，==）的不同：
    
    “等价于”表示两个类类型（class type）的常量或者变量引用同一个类实例。
    “等于”表示两个实例的值“相等”或“相同”，判定时要遵照设计者定义的评判标准，因此相对于“相等”来说，这是一种更加合适的叫法。
    当你在定义你的自定义类和结构体的时候，你有义务来决定判定两个实例“相等”的标准。在章节等价操作符中将会详细介绍实现自定义“等于”和“不等于”运算符的流程。
    
    
    
    字符串(String)、数组(Array)、和字典(Dictionary)类型的赋值与复制行为
    Swift 中，许多基本类型，诸如String，Array和Dictionary类型均以结构体的形式实现。这意味着被赋值给新的常量或变量，或者被传入函数或方法中时，它们的值会被拷贝。
    
    Objective-C 中NSString，NSArray和NSDictionary类型均以类的形式实现，而并非结构体。它们在被赋值或者被传入函数或方法时，不会发生值拷贝，而是传递现有实例的引用。
    */
}

class DataImporter {
    /*
    DataImporter 是一个负责将外部文件中的数据导入的类。
    这个类的初始化会消耗不少时间。
    */
    var fileName = "data.txt"
    // 这里会提供数据导入功能
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    // 这里会提供数据管理功能
    func testlazy(){
        let manager = DataManager()
        manager.data.append("Some data")
        manager.data.append("Some more data")
        // DataImporter 实例的 importer 属性还没有被创建
    }
}


