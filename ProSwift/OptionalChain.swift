//
//  OptionalChain.swift
//  ProSwift
//
//  Created by Sun on 15/12/3.
//  Copyright © 2015年 Sun. All rights reserved.
//

import Foundation

class Person {
    var residence: Residence?// 对于optional 变量来说 使用的时候必须使用强解析！但是当变量没有被赋值时使用强解析又会报运行时的错误， 如果是使用隐式解析var name :String!; print("\name ===== \(name)") 未赋值就不会报错，其实还是nil；又如果任何！？都不修饰，则所属的类必须提供对应变量的初始化函数init(name:String)
    // 所以说 swift 是类型安全的语言
}
class Room {
    let name: String
    init(name: String) { self.name = name }
}
class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        } else if buildingNumber != nil && street != nil {
            return "\(buildingNumber) \(street)"
        } else {
            return nil
        }
    }
}
class Residence {
   // var numberOfRooms = 1
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
    
}

class OptionalChainTest{
    
    func test(){
        let john = Person();
        print(" init Person \(john)");
        print("proerty residence = \(john.residence)");
   
      //  let roomCount = john.residence!.numberOfRooms;// 不写！会报错 // 这会引发运行时错误 fatal error: unexpectedly found nil while unwrapping an Optional value
       /*
        john.residence为非nil值的时候，上面的调用会成功，并且把roomCount设置为Int类型的房间数量。正如上面提到的，当residence为nil的时候上面这段代码会触发运行时错误。
        
        可选链式调用提供了另一种访问numberOfRooms的方式，使用问号（?）来替代原来的叹号（!）
*/
        print("proerty residence.numberOfRoooms = \(john.residence?.numberOfRooms)");
     
        //step 2
        if let roomCount = john.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s).")
        } else {
            print("Unable to retrieve the number of rooms.")
        }
        // 打印 “Unable to retrieve the number of rooms.”
        john.residence = Residence();
        
        if let roomCount = john.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s).")
            //访问成功时，可选的Int值会通过可选绑定展开，并赋值给非可选类型的roomCount常量。
            //要注意的是，即使numberOfRooms是非可选的Int时，这一点也成立。只要使用可选链式调用就意味着numberOfRooms会返回一个Int?而不是Int
        } else {
            print("Unable to retrieve the number of rooms.")
        }
        // step 3
        john.residence?.address = createAddress()//如果residence is nil ，createAddress（）方法不执行
    
        
        //step 4
        //如果在可选值上通过可选链式调用来调用这个方法，该方法的返回类型会是Void?，而不是Void，因为通过可选链式调用得到的返回值都是可选的。这样我们就可以使用if语句来判断能否成功调用printNumberOfRooms()方法，即使方法本身没有定义返回值。通过判断返回值是否为nil可以判断调用是否成功：
        
        if john.residence?.printNumberOfRooms() != nil {
            print("It was possible to print the number of rooms.")
        } else {
            print("It was not possible to print the number of rooms.")
        }
        // 打印 “It was not possible to print the number of rooms.”
        
        // step 5
        /* 通过可选链式调用访问下标
        通过可选链式调用，我们可以在一个可选值上访问下标，并且判断下标调用是否成功。
        
        注意
        通过可选链式调用访问可选值的下标时，应该将问号放在下标方括号的前面而不是后面。可选链式调用的问号一般直接跟在可选表达式的后面。
        */
        
//        if let firstRoomName = john.residence?[0].name {
//            print("The first room name is \(firstRoomName).")
//        } else {
//            print("Unable to retrieve the first room name.")
//        }
        // 打印 “Unable to retrieve the first room name.” if  residence is nil
     
        
        
        // step6
    /*
        访问可选类型的下标
        
        如果下标返回可选类型值，比如 Swift 中Dictionary类型的键的下标，可以在下标的结尾括号后面放一个问号来在其可选返回值上进行可选链式调用：
        
        var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
        testScores["Dave"]?[0] = 91
        testScores["Bev"]?[0]++
        testScores["Brian"]?[0] = 72
        // "Dave" 数组现在是 [91, 82, 84]，"Bev" 数组现在是 [80, 94, 81]
        上面的例子中定义了一个testScores数组，包含了两个键值对，把String类型的键映射到一个Int值的数组。这个例子用可选链式调用把"Dave"数组中第一个元素设为91，把"Bev"数组的第一个元素+1，然后尝试把"Brian"数组中的第一个元素设为72。前两个调用成功，因为testScores字典中包含"Dave"和"Bev"这两个键。但是testScores字典中没有"Brian"这个键，所以第三个调用失败。
        */
    }
    
    func createAddress() -> Address {
        print("Function was called.")
        
        let someAddress = Address()
        someAddress.buildingNumber = "29"
        someAddress.street = "Acacia Road"
        
        return someAddress
    }
   
    
    
    func testComplexResidenc (){
        
    }
}