//
//  JFClosure.swift
//  ProSwift
//
//  Created by Sun on 15/12/19.
//  Copyright © 2015年 Sun. All rights reserved.
//

import Foundation
class JFClosure {
    let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"];
    func backwards(s1: String, s2: String) -> Bool {
        return s1 > s2
    }
    func test(){
        let reversed = names.sort(backwards);
        var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        print(customersInLine.count)
        // prints "5"
        
        let customerProvider = { customersInLine.removeAtIndex(0) }
        print(customersInLine.count)
        // prints "5"
        
        print("Now serving \(customerProvider())!")
        // prints "Now serving Chris!"
        print(customersInLine.count)
        // prints "4"
    }
}