//
//  JFCopy.swift
//  ProSwift
//
//  Created by Sun on 15/12/20.
//  Copyright © 2015年 Sun. All rights reserved.
//

import Foundation

protocol Copyable {
    func copy() -> Self
}


class ClassA { }
class ClassB: ClassA { }

class Pet {}
class Cat: Pet {}
class Dog: Pet {}

func printPet(pet: Pet) {
    print("Pet")
}

func printPet(cat: Cat) {
    print("cat")
}

func printPet(dog: Dog) {
    print("dog")
}

func printThem(pet: Pet, cat: Cat) {
    printPet(pet)
    printPet(cat)
}

class MyCopyClass: Copyable {
    
    var num = 1
    
    func copy() -> Self {
        // TODO: 返回什么？
        let result = self.dynamicType.init()
        result.num = num
        return result
    }
    required init(){
    }
    
    func test(){
        var objClass:MyCopyClass!;
        print("\(NSNull())")// 一个NSnukk的对象
        print("\([NSNull.self])")
        
        let object = MyCopyClass()
        object.num = 100
        print("\(object.num.hashValue)")
        let newObject = object.copy()
        object.num = 1
        
        print(object.num)     // 1
        print(newObject.num)  // 100
        
        let obj: AnyObject = ClassB()
        
        if (obj is ClassA) {
            print("属于 ClassA")
        }
        
        if (obj is ClassB) {
            print("属于 ClassB")
        }
        let string = "String"
        if string is String {
            print("not is ")
        }
        
        printPet(Cat()) // cat
        printPet(Dog()) // dog
        printPet(Pet()) // Pet
        printThem(Dog(), cat: Cat())//Pet cat
        
        /*
        打印时的 Dog() 的类型信息并没有被用来在运行时选择合适的 printPet(dog: Dog) 版本的方法，而是被忽略掉，并采用了编译期间决定的 Pet 版本的方法。因为 Swift 默认情况下是不采用动态派发的，因此方法的调用只能在编译时决定。
        
        要想绕过这个限制，我们可能需要进行通过对输入类型做判断和转换：
        
        func printThem(pet: Pet, cat: Cat) {
        if let aCat = pet as? Cat {
        printPet(aCat)
        } else if let aDog = pet as? Dog {
        printPet(aDog)
        }
        printPet(cat)
        }
        
        */
    }
}




