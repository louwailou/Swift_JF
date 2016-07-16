//
//  JFInitiallization.swift
//  ProSwift
//
//  Created by Sun on 15/11/27.
//  Copyright © 2015年 Sun. All rights reserved.
//

import Foundation
class JFInitialization {
    var temperature:String?;// 存储属性要么是optional，要么给出初始值，不然提示错误
//    init() {
//        temperature = 32;
//    }
}


struct Celsius {
    var temperatureInCelsius: Double = 0;
    
    var tStr:String?;// init 构造器必须init 所有的存储属性
   /*
    init( fahrenheit:Double){
        //如果你在定义构造器时没有提供参数的外部名字，Swift 会为每个构造器的参数自动生成一个跟内部名字相同的外部名。
        temperatureInCelsius = (fahrenheit - 32.0)/18.0;
    }
    init (fromKelvin kekVin:Double){
        temperatureInCelsius = kekVin - 273.15;
    }
    init(_ celsius:Double){
        //如果你不希望为构造器的某个参数提供外部名字，你可以使用下划线(_)来显式描述它的外部名
        temperatureInCelsius = celsius;
    }
*/
}

class TTemperature {
    var temInstance:Celsius;
    init(){
        //temInstance = Celsius(temperatureInCelsius: 30); // 如果是未提供init 则Celsius 会根据存储属性来自动构造一个init（temperatureInCelsius:）即 根据存储属性生成一个属性同名的init
        
       self.temInstance = Celsius();// 如果是调用无参构造函数，则所有的存储属性必须有默认值（要么是系统提供，要么是）
        //自己提供
       // temInstance = Celsius(fahrenheit: 200.0);
        //temInstance = Celsius(200.0);
    }
    
}


/* 可选属性类型
如果你定制的类型包含一个逻辑上允许取值为空的存储型属性——无论是因为它无法在初始化时赋值，还是因为它在之后某个时间点可以赋值为空——你都需要将它定义为可选类型optional type。可选类型的属性将自动初始化为nil，表示这个属性是有意在初始化时设置为空的
class SurveyQuestion {
var text: String
var response: String?
init(text: String) {
self.text = text
}
func ask() {
print(text)
}
}
let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
// 输出 "Do you like cheese?"
cheeseQuestion.response = "Yes, I do like cheese."


*/



/*
构造过程中常量属性的修改

你可以在构造过程中的任意时间点修改常量属性的值，只要在构造过程结束时是一个确定的值。一旦常量属性被赋值，它将永远不可更改。

注意
对于类的实例来说，它的常量属性只能在定义它的类的构造过程中修改；不能在子类中修改。

*/


/*
值类型的构造器代理
构造器可以通过调用其它构造器来完成实例的部分构造过程。这一过程称为构造器代理，它能减少多个构造器间的代码重复。

构造器代理的实现规则和形式在值类型和类类型中有所不同。值类型（结构体和枚举类型）不支持继承，所以构造器代理的过程相对简单，因为它们只能代理给提供给它的构造器。类则不同，它可以继承自其它类（请参考继承），这意味着类有责任保证其所有继承的存储型属性在构造时也能正确的初始化。这些责任将在后续章节类的继承和构造过程中介绍。

对于值类型，你可以使用self.init在自定义的构造器中引用类型中的其它构造器。并且你只能在构造器内部调用self.init。

如果你为某个值类型定义了一个自定义的构造器，你将无法访问到默认构造器（如果是结构体，还将无法访问逐一成员构造器）。这个限制可以防止你为值类型定义了一个进行额外必要设置的复杂构造器之后，别人还是错误地使用了一个自动生成的构造器。

注意
假如你希望默认构造器、逐一成员构造器以及你自己的自定义构造器都能用来创建实例，可以将自定义的构造器写到扩展（extension）中，而不是写在值类型的原始定义中。想查看更多内容，请查看扩展章节。

*/
struct SSize {
    var width = 0.0, height = 0.0
}
struct PPoint {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = PPoint()
    var size = SSize()
    init() {}
    init(origin: PPoint, size: SSize) {
        self.origin = origin
        self.size = size
    }
    init(center: PPoint, size: SSize) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: PPoint(x: originX, y: originY), size: size)//对于值类型，你可以使用self.init在自定义的构造器中引用类型中的其它构造器。并且你只能在构造器内部调用self.init
    }
}


/*
类的继承和构造过程
类里面的所有存储型属性——包括所有继承自父类的属性——都必须在构造过程中设置初始值。

Swift 为类类型提供了两种构造器来确保实例中所有存储型属性都能获得初始值，它们分别是指定构造器和便利构造器。


指定构造器和便利构造器

指定构造器是类中最主要的构造器。一个指定构造器将初始化类中提供的所有属性，并根据父类链往上调用父类的构造器来实现父类的初始化。

每一个类都必须拥有至少一个指定构造器。在某些情况下，许多类通过继承了父类中的指定构造器而满足了这个条件。具体内容请参考后续章节构造器的自动继承。

便利构造器是类中比较次要的、辅助型的构造器。你可以定义便利构造器来调用同一个类中的指定构造器，并为其参数提供默认值。你也可以定义便利构造器来创建一个特殊用途或特定输入值的实例。

你应当只在必要的时候为类提供便利构造器，比方说某种情况下通过使用便利构造器来快捷调用某个指定构造器，能够节省更多开发时间并让类的构造过程更清晰明了。


指定构造器和便利构造器的语法

类的指定构造器的写法跟值类型简单构造器一样：

init(parameters) {
statements
}
便利构造器也采用相同样式的写法，但需要在init关键字之前放置convenience关键字，并使用空格将它们俩分开：

convenience init(parameters) {
statements
}

类的构造器代理规则

为了简化指定构造器和便利构造器之间的调用关系，Swift 采用以下三条规则来限制构造器之间的代理调用：

规则 1

指定构造器必须调用其直接父类的的指定构造器。

规则 2

便利构造器必须调用同一类中定义的其它构造器。

规则 3

便利构造器必须最终导致一个指定构造器被调用。

一个更方便记忆的方法是：

指定构造器必须总是向上代理
便利构造器必须总是横向代理


*/


// 构造器中的属性的初始化顺序是先子类的属性，然后是父类的属性，等父类的属性初始化完毕之后，在沿着父类向下，进一步定制属性的值，这是初始化的第一阶段，完了之后，才可以修改父类的属性值，
/*
 subClassproperty init...
   super father init()
    change father properties...

*/



//构造器的继承和重写

/*
Swift 中的子类默认情况下不会继承父类的构造器。Swift 的这种机制可以防止一个父类的简单构造器被一个更专业的子类继承，并被错误地用来创建子类的实例。

*/