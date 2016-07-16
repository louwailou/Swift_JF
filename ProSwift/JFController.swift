//
//  JFController.swift
//  ProSwift
//
//  Created by Sun on 15/12/17.
//  Copyright © 2015年 Sun. All rights reserved.
//

import Foundation
import UIKit



class JFController: UIViewController {

    func randomInRange(range: Range<Int>) -> Int {
        let count = UInt32(range.endIndex - range.startIndex)
        return  Int(arc4random_uniform(count)) + range.startIndex
    }
    
  
   
    override func viewDidLoad() {
            super.viewDidLoad();
        
        
        let ingredientThree = ShoppingListItem(name: "apple")
        print(ingredientThree)
        return
        let data = NSData();
        let name:AnyObject! = object_getClass(data);
        let name2 = data.dynamicType;//获取类型
        print(name2);
        print(name);
        let selfClass:JFController.Type = JFController.self;
        print(selfClass);
        print(JFController.self);
       // Self self
    //    print(Self);
        print(self);
        for _ in 0...3 {
            print(randomInRange(1...6))
        }
        
        let  copyClass = MyCopyClass();
        copyClass.test();
        
           
//          let yesAction = UIAlertAction(title: "title", style:.Destructive) { (handelAction) -> Void in
//            let controller = UIAlertController(title: "some was done", message: "message", preferredStyle: .ActionSheet);
//            let cancelAction = UIAlertAction(title: "cancelTitle", style: .Cancel, handler: nil);
//            controller.addAction(cancelAction);
//            self.presentViewController(controller, animated: true, completion: { () -> Void in
//                
//            });
//            
//        }
        let myButton = UIButton(type: .Custom);
        myButton.frame = CGRectMake(100, 50, 100, 50);
        myButton.setTitle("click me at here", forState: .Normal);
        self.view.addSubview(myButton);
        //self.popoverPresentationController
            //self.showViewController(<#T##vc: UIViewController##UIViewController#>, sender: <#T##AnyObject?#>)
        
    }
    
    
}


class Food {
    var name: String
    init(name: String){
        self.name = name
    }
    convenience init() {
        self.init(name: "[unnamed]")
    }
    
}

class RecipeIngredient: Food{
    var quantity: Int
    init(name: String, quantity: Int){
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String){
        self.init(name: name, quantity: 1)
    }
}

class ShoppingListItem: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) X \(name)"
        output += purchased ? " ✔" : " ✘"
        print(output)
        return output
    }
}
