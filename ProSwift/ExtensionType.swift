//
//  ExtensionType.swift
//  ProSwift
//
//  Created by Sun on 15/12/4.
//  Copyright © 2015年 Sun. All rights reserved.
//

import Foundation
extension Int{
    enum Kind{
        case Negative,Zero,Positive
    }
    var kind :Kind{// 声明计算属性 kind
        switch self{// 如果该int 值 符合以下case 则返回相应的枚举值
        case 0 : return .Zero
        case let x where x > 0 :
          return .Positive
        default:
            return .Negative
        }
    }
    func printIntegerKinds(numbers: [Int]) {
        for number in numbers {
            switch number.kind {
            case .Negative:
                print("- ", terminator: "")
            case .Zero:
                print("0 ", terminator: "")
            case .Positive:
                print("+ ", terminator: "")
            }
        }
        print("")
    }
    //printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
    // 打印 “+ + - 0 - 0 +”
   // 由于已知 number.kind 是 Int.Kind 类型，因此在 switch 语句中，Int.Kind 中的所有成员值都可以使用简写形式，例如使用 . Negative 而不是 Int.Kind.Negative。
}