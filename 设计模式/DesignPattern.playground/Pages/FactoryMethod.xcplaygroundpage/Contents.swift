//: Playground - noun: a place where people can play

import UIKit
/*:
 #### 工厂方法
 
 该模式定义了一个创建对象的接口，但由子类决定要实例化的类是哪一个,实例化的过程推迟到子类
 
 */

class Pizza: NSObject {
    var name:String?;
    var dougg:String?;
    var sauce:String?;
    func prepare () -> Void {
        print("preparing");
    }
    func bake() {
        print("bake...");
    }
    func cut(){
        print("cuting....");
    }
    func box(){
        print("boxing...");
    }
    
}

class NYStyleCheesePizza: Pizza {
    override init() {
        super.init();
        self.name = "NYStyle ";
        self.dougg = "Thin and Crust Dough";
        self.sauce = "marinara Sauce";
    }
    
}

class ChicagoStyleCheesePizza : Pizza {
    override init() {
        super.init();
        self.name = "Chicago Style ";
        self.dougg = "Extrac thickCrustDough ";
        self.sauce = "Tomato Sauce";
    }
}

protocol PizzaStore {
    // 这个放到父类或者接口中
//    func orderPizza(type:String)-> Pizza? {
//       var  pizza:Pizza?;
//        pizza = createPizza(type);
//        pizza?.prepare();
//        pizza?.bake();
//        pizza?.cut();
//        pizza?.box();
//        
//        return nil;
//    }
    
    // 实例化披萨的责任被移动到一个方法中，此方法如同一个工厂,由子类具体实现
    func createPizza(type:String)->Pizza?;
}

class NYPizzaStore: PizzaStore {
     func createPizza(type: String) -> Pizza? {
        // 根据不同的type 返会不同的pizza
        return nil;
    }
}


// 依赖倒置原则
/* 不能让高层组件依赖底层组件，而且不管高层或者低层组件，两者都因该依赖于抽象

 pizzaStore 依赖接口Pizza, 具体的Pizza类也依赖该接口
*/







/* 
  抽象工厂
  提供一个接口，用于创建相关或者依赖对象的家族，而不需要明确指定具体类
 抽象工厂的任务就是定义一个负责创建一组产品的接口，这个接口内的每一个方法都负责创建一个具体的产品
 
 
 抽象原料工厂
  一个抽象工厂定义了一组抽象方法
 每一个具体的工厂都会根据方法生产不同的具体的原料
 NYIngredientFacotory 生产NY——P
 CHIAGoIngredientFactory 生产CH-P
 
*/

/*工厂方法和抽象工厂的区别
 
 
工厂方法: 继承，只负责客户从具体类解耦,由子类扶着决定具体的类型

抽象工厂: 组合 提供一个创建产品家族的抽象类型
 
 */










