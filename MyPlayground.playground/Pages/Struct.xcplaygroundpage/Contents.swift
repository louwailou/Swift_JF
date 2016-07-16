//: [Previous](@previous)

import Foundation
/*:
   结构体
 
   1.结构体有逐一构造器，类没有
   2.结构体是值类型
   3. 
 
 */

enum Rank:Int{
    case Ace = 1
    case Two, Three, Four
    case Jack,Queen,King
    func simpleDesc() -> String {
        switch self {
        case .Ace:
            return "ace";
        case .Jack:
            return "jack";
        case .King:
            return "king"
        case .Queen:
            return "queen";
        default:
            return String(self.rawValue);
        }
    }
}

/*:
 
 #结构体
 
 */

struct Card {
    var rank:Rank
    func simpleDesc() -> String {
        return "the rank-> \(rank.simpleDesc())"
    }
    
}
let jfCard = Card(rank: Rank.Three);
print(jfCard.simpleDesc())

//: #### 常量结构体的存储属性
// 果创建了一个结构体的实例并将其赋值给一个常量，则无法修改该实例的任何属性，即使有属性被声明为变量也不行：

struct FixedLengthRange {
    var firstValue :Int
    let length:Int
    
}
let fix = FixedLengthRange(firstValue: 1, length: 10);
 //fix.firstValue = 100; //报错





