//
//  JFArray.swift
//  ProSwift
//
//  Created by Sun on 15/12/18.
//  Copyright © 2015年 Sun. All rights reserved.
//

import Foundation
class JFArray {
    func enumerateArray(){
        let arr: NSArray = [1,2,3,4,5]
        var result = 0
        arr.enumerateObjectsUsingBlock { (num, idx, stop) -> Void in
            result += num as! Int
            if idx == 2 {
                stop.memory = true
            }
        }
        print(result);
        
    }
    
    func enumerateB(){
        var result = 0;
        for (index,num ) in [1,3,5,6,7].enumerate(){
            result += num;
            if (index == 6){
                break;
            }
        }
    }
}