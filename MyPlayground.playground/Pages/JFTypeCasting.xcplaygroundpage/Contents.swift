//: [Previous](@previous)

import Foundation

/*:
  ## 类型检查
 1. is 用类型检查操作符（is）来检查一个实例是否属于特定子类型
 2. as
 3. 向下转型（Downcasting）as?  as!
    某类型的一个常量或变量可能在幕后实际上属于一个子类。当确定是这种情况时，你可以尝试向下转到它的子类型，用类型转换操作符（as? 或 as!）
 4. Any 和 AnyObject 类型转换
    * AnyObject 可以表示类类型的实例
    * Any 可以表示任何类型,包括函数
 
 */
/*
for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}
*/
var things = [Any]();
things.append(0);
things.append("sunjinafeng")
things.append(2.45)
things.append((3,5))



for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (Double, Double):
        print("an (x, y) point at \(x), \(y)")
    
    default:
        print("something else")
    }
}





//: [Next](@next)
