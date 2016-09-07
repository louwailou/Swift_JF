//
//  ViewController.swift
//  ProSwift
//
//  Created by Sun on 15/11/9.
//  Copyright © 2015年 Sun. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       /*  ?? 的使用
        var level : Int？ //使用之前必须初始化 
        var startLevel = 1
        
        let currentLevel = level ?? startLevel
        print(currentLevel);
        */
        
        let string = "Hello, world!"
        
        var firstChar:Character = string[1]; // Throws error
      
        
        
        let btn = UIButton(type: .Custom);
        btn.setTitle(" push ", forState: .Normal);
        btn.frame = CGRectMake(100, 100, 100, 44);
        btn.backgroundColor = UIColor(red: 0.4, green: 0.5, blue: 0.6, alpha: 1);
        
        btn.addTarget(self, action: Selector("pushNewController"), forControlEvents:.TouchUpInside);
        self.view.addSubview(btn);
        
      
        
        //self .implictUnwarpOptional();
        //self.defineCollectionF();
       
        let baseClass = JFBasicClass();
       
        baseClass.arrTest();
        
        let f = JFBasicClass.arrTest;
        f(baseClass)();
        
        // baseClass
        //var jfClass:JFClass = JFClass();
        let table = TimesTable(multiplier: 10);
        print("\(table[0])");
        
        let car =   AutomaticCar();
        car.currentSpeed = 13455;
        
        // self.swapInt(&av,&bv);
    
        
       // var sun = (status:"100",intValue : 3000) ;// tuple 指定optional ？
      /*  
        
        if let sunV = sun.intValue { //可选绑定,即 intValue 应该是optional的
        
        }

        */
        
        
        
        // optional chain
        
        let test = OptionalChainTest();
        test.test();
        
        
        // typeCasting
        let m = Movie(name: "sun", director: "feng");
        let tpTeset = typeCastingTest(m: m);
        //tpTeset.movie.director
        tpTeset.any();
        // Do any additional setup after loading the view, typically from a nib.
        
        let nest = NestClassTest();
        nest.test();
        
        
        
        
        // debug
        var testArray: [Int] = [1,2]
        var testDic: [String: Int] = ["seedante": 18, "iOS": 9]
        
    }

    // nestClass
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func implictUnwarpOptional(){
        let possibleString: String? = "An optional string."
        print(possibleString) // 需要惊叹号来获取值
       // Optional("An optional string.") 无！ 输出
      //  An implicitly unwrapped optional string.
        
        let assumedString: String! = "An implicitly unwrapped optional string."
        print(assumedString)  // 不需要感叹号
        // 输出 "An implicitly unwrapped optional string."
        
        var possibleStr:String? = nil;//如果你声明一个可选常量或者变量但是没有赋值，它们会自动被设置为nil
        print("\(possibleStr)");
        //Swift 的nil和 Objective-C 中的nil并不一样。在 Objective-C 中，nil是一个指向不存在对象的指针。在 Swift 中，nil不是指针——它是一个确定的值，用来表示值缺失。任何类型的可选都可以被设置为nil，不只是对象类型
    }
    func defineCollectionF(){
        var ShoppingString :[String] = ["sun","jian","feng"];
        ShoppingString[0...2] = ["111","222"];
        print(ShoppingString);
        
        var airports:Dictionary<String,String> = ["HLK":"london"];
        for (cityCode ,City) in airports{
            print(cityCode);
            print(City);
//            City = "ddd"; 说明city 和cityCode 均只读，且不可变
        }
    }

    
    func swapInt(inout a:Int ,inout bvau b:Int){
        let  temp = a;
        a = b;
        b = temp;
    }
    
    
    func pushNewController(){
        
      //  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"UserLogin" bundle:[NSBundle mainBundle]];
       // MFLoginViewController * loginController = [storyboard instantiateViewControllerWithIdentifier:@"MFLoginViewController"];
        
        let storyBoard = UIStoryboard(name: "JFController", bundle: NSBundle.mainBundle());
        let controller = storyBoard.instantiateViewControllerWithIdentifier("JFController");
        
        self.navigationController?.pushViewController(controller, animated: true);
    }
}

