//: [Previous](@previous)

import Foundation


/*:
 ##枚举
 
  1.枚举可以设置关联值，方法，构造函数，协议等
  2.Currency 不会隐式转换为0，1.枚举成员本身就是完备的值
  3.在使用原始值为整数或者字符串类型的枚举时，不需要显式地为每一个枚举成员设置原始值，Swift 将会自动为你赋值
  4.当使用字符串作为枚举类型的原始值时，每个枚举成员的隐式原始值为该枚举成员的名称
 
 
 */


enum Currency {
    case Eur
    case Usd
}

func symbole(currency:Currency) -> String {
    switch currency {
    case .Eur:
        return "€";
    case .Usd:
        return "$"
        
    }
}
//: ####枚举中定义函数
enum Rank:Int{
    case Ace = 1
    case Two
    case Three, Four
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
//返回值则是枚举成员或nil
let rk1 = Rank(rawValue: 0);
let rk2 = Rank(rawValue: 1);
let rk3 = Rank(rawValue: 2);
let rk4 = Rank.Four;
let rawR4 = rk4.rawValue;



if let rk = Rank(rawValue: 1){
    print(" \(rk.simpleDesc())");
}
/**

 */
enum Planet:String {
    case North,South,East,West
}

let pl0 = Planet.North;
let pl1 = Planet.East.rawValue;


//: ####枚举关联值
enum ServerResponse {
    case Result(String,String)
    case JFError(String)
    func simpleDesc() -> String {
        switch self {
        case let .Result(sunrise, sunset):
            return "sunrise -> \(sunrise) sunset-> \(sunset)"
        case let JFError (error):
            return "error->\(error)"
            
        }
    }
}
let success = ServerResponse.Result("6:40", "18:30");
print(success.simpleDesc());

/*:
 
 ##协议
 
 */


protocol CurrencySymbol {
    func symbol() -> String
    
}
// enum 不可以子类化，但是可以使用协议扩展
extension Currency : CurrencySymbol{
    func symbol() -> String {
        switch self {
        case .Eur:
            return "€";
        case .Usd:
            return "$";
            
            
        }
    }
}

// 添加其他的扩展
struct Bitcoin :CurrencySymbol{
    func symbol() -> String {
        return "฿";
    }
}
