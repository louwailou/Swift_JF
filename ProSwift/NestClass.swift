//
//  NestClass.swift
//  ProSwift
//
//  Created by Sun on 15/12/3.
//  Copyright © 2015年 Sun. All rights reserved.
//

import Foundation
struct BlackjackCard {
    // 嵌套的 Suit 枚举
    enum Suit: Character {
        case Spades = "♠", Hearts = "♡", Diamonds = "♢", Clubs = "♣"
    }
    
    // 嵌套的 Rank 枚举
    enum Rank: Int {
        case Two = 2, Three, Four, Five, Six, Seven, Eight, Nine, Ten
        case Jack, Queen, King, Ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            print("self == \(self)")//Ace
            switch self {
            case .Ace:
                return Values(first: 1, second: 11)
            case .Jack, .Queen, .King:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
    
    // BlackjackCard 的属性和方法
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
       
        
        return output
    }
}


    class NestClassTest {
        func test (){//，如果结构体没有提供自定义的构造器，它们将自动获得一个逐一成员构造器，即使结构体的存储型属性没有默认值。
            let theAceOfSpades = BlackjackCard(rank: .Ace, suit: .Spades)
            print("theAceOfSpades: \(theAceOfSpades.description)")
            // 打印 “theAceOfSpades: suit is ♠, value is 1 or 11”
            self.pInt(tInt);
        }
        var tInt = 100;
        
        func pInt(var bInt:Int){// var indicates bInt changable  default is let
            bInt = 120;
            print("\(bInt) tint =\(tInt)");
        }
        
}
