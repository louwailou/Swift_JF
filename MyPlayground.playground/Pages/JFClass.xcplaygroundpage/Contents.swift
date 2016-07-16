//: [Previous](@previous)

import Foundation

//: ##类

/*: 1. 存储属性 类和结构体
    2. 计算属性 类，枚举，结构体都可运用
    3. 属性观察
    4. var response: String? 可选属性类型自动赋值 nil
    5. 如果结构体或类的所有属性都有默认值，同时没有自定义的构造器，那么 Swift 会给这些结构体或类提供一个默认构造器（default initializers）。这个默认构造器将简单地创建一个所有属性值都设置为默认值的实例
 
 */


//: #### 延迟属性
//: lazy 只有在第一次使用的术后才会计算初始值
class DataManager {
    lazy var filePath:String = "./sun.txt" ;
    var data = [String]()
    
}
// : #### 计算属性
/*: `这里注意Tuple 的使用，以及计算属性的使用`，如果是结构体，初始化方法系统自动生成，但类不会
    只有 getter 没有 setter 的计算属性就是只读计算属性。只读计算属性总是返回一个值，可以通过点运算符访问，但不能设置新的值
    必须使用 var 关键字定义计算属性，包括只读计算属性，因为它们的值不是固定的。let 关键字只用来声明常量属性，表示初始化后再也无法修改的值
 
 */
class JFRect {
    var origin:(x:Float,y:Float) ;
    var size:(width:Float,height:Float)
    // 计算属性
    var center :(x1:Float,y1:Float){
        get {
            return (origin.x+size.width/2,origin.y+size.height/2);
        }
        
        set(newCenter){
            origin.x = newCenter.x1 - size.width/2;
            origin.y = newCenter.y1 - size.height/2;
        }
 
    }
    var centerPoint :(x:Float,y:Float){
        willSet{
            print("willset \(newValue)");
            print("current \(centerPoint)")
        }
        didSet{
            // 在这里还可以修改该属性值哦哦哦
            print("didSet\(oldValue)");
            print("current \(centerPoint)")
            if centerPoint.x > 100 {
                centerPoint.x = 500;
            }
            
        }
    }
    //类属性
    
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
    
    init(ori:(x:Float,y:Float),size:(width:Float,height:Float),cPoint:(x:Float,y:Float) = (0,0)){
        self.origin = ori;
        self.size = size;
        self.centerPoint = cPoint;
        
    }
}

let jfrect = JFRect(ori: (0,0),size:(100,100));
//let jfrect2 = JFRect();
let (x,y) = jfrect.origin;

print(x);

let tp = jfrect.center;
let tpx = tp.x1;
//extension 不能包含存储属性

extension JFRect{
    //var otherSize:(x:Float,y:Float);// 不能包含存储属性
}

// willSet & didSet
jfrect.centerPoint = (120,120);
let ppoint = jfrect.centerPoint;


//: #### 类方法
/*:  在方法的func关键字之前加上关键字static，来指定类型方法。类还可以用关键字class来允许子类重写父类的方法实现。
*/
extension JFRect{
    //竟然可以扩展静态属性
    static var name:String = "sun";
    
    static func whoAreY()->String{
        return self.name;
    }
}

JFRect.whoAreY();

//:  ####重写属性
 /*:
 
 你可以重写继承来的实例属性或类型属性，提供自己定制的 getter 和 setter，或添加属性观察器使重写的属性可以观察属性值什么时候发生改变
 你可以将一个继承来的只读属性重写为一个读写属性，只需要在重写版本的属性里提供 getter 和 setter 即可。但是，你不可以将一个继承来的读写属性重写为一个只读属性
 
 
 */

class JFPersion {
    var name:String = "someBody";
//    init(){
//        self.name = "somebody";
//    }
}
// 如果声明就给默认值，则初始化构造函数不是必须的




//:  ####构造过程
/*:
 指定构造器必须总是向上代理
 便利构造器必须总是横向代理
 
 
 
 
 两段式构造过程
 
 Swift 中类的构造过程包含两个阶段。第一个阶段，每个存储型属性被引入它们的类指定一个初始值。当每个存储型属性的初始值被确定后，第二阶段开始，它给每个类一次机会，在新实例准备使用之前进一步定制它们的存储型属性。
 
 两段式构造过程的使用让构造过程更安全，同时在整个类层级结构中给予了每个类完全的灵活性。两段式构造过程可以防止属性值在初始化之前被访问，也可以防止属性被另外一个构造器意外地赋予不同的值。
 
 注意
 Swift 的两段式构造过程跟 Objective-C 中的构造过程类似。最主要的区别在于阶段 1，Objective-C 给每一个属性赋值0或空值（比如说0或nil）。Swift 的构造流程则更加灵活，它允许你设置定制的初始值，并自如应对某些属性不能以0或nil作为合法默认值的情况。
 Swift 编译器将执行 4 种有效的安全检查，以确保两段式构造过程能不出错地完成：
 
 安全检查 1
 
 指定构造器必须保证它所在类引入的所有属性都必须先初始化完成，之后才能将其它构造任务向上代理给父类中的构造器。
 
 如上所述，一个对象的内存只有在其所有存储型属性确定之后才能完全初始化。为了满足这一规则，指定构造器必须保证它所在类引入的属性在它往上代理之前先完成初始化。
 
 安全检查 2
 
 指定构造器必须先向上代理调用父类构造器，然后再为继承的属性设置新值。如果没这么做，指定构造器赋予的新值将被父类中的构造器所覆盖。
 
 安全检查 3
 
 便利构造器必须先代理调用同一类中的其它构造器，然后再为任意属性赋新值。如果没这么做，便利构造器赋予的新值将被同一类中其它指定构造器所覆盖。
 
 安全检查 4
 
 构造器在第一阶段构造完成之前，不能调用任何实例方法，不能读取任何实例属性的值，不能引用self作为一个值。
 
 类实例在第一阶段结束以前并不是完全有效的。只有第一阶段完成后，该实例才会成为有效实例，才能访问属性和调用方法。
 
 以下是两段式构造过程中基于上述安全检查的构造流程展示：
 
 阶段 1
 
 某个指定构造器或便利构造器被调用。
 完成新实例内存的分配，但此时内存还没有被初始化。
 指定构造器确保其所在类引入的所有存储型属性都已赋初值。存储型属性所属的内存完成初始化。
 指定构造器将调用父类的构造器，完成父类属性的初始化。
 这个调用父类构造器的过程沿着构造器链一直往上执行，直到到达构造器链的最顶部。
 当到达了构造器链最顶部，且已确保所有实例包含的存储型属性都已经赋值，这个实例的内存被认为已经完全初始化。此时阶段 1 完成。
 阶段 2
 
 从顶部构造器链一直往下，每个构造器链中类的指定构造器都有机会进一步定制实例。构造器此时可以访问self、修改它的属性并调用实例方法等等。
 最终，任意构造器链中的便利构造器可以有机会定制实例和使用self。
 
 
  1，先给本类属性赋值
  2. 调用父类指定构造函数
  3. 重新给继承属性设置新值
  4. 只有在父类构造函数调用后，已经初始化完成，才能调用self 方法
 
 
 
  子类默认不会继承父类的构造函数
  如果想和父类的一致则需要override 父类的构造函数
  如果想和父类的便利构造函数一致，则不用override,因为便利构造函数只能在本类中使用
 
  #### 构造函数的自动继承
      
   但是在子类所有新的属性都提供了默认值得前提下，子类是可以自动继承父类的构造函数的(包括指定构造函数和便利构造函数)。
 
   1. 如果子类没有定义任何指定的构造函数
   2. 如果子类提供了所有父类指定构造函数的实现-无论是通过上述1继承过来的还是通过提供自定义实现，都会自动继承父类的便利构造函数
 
 
 
 
 #### 通过闭包或函数设置属性的默认值
   
  如果某个存储型属性的默认值需要一些定制或设置，你可以使用闭包或全局函数为其提供定制的默认值。每当某个属性所在类型的新实例被创建时，对应的闭包或函数会被调用，而它们的返回值会当做默认值赋值给这个属性。
 
 
 注意
   如果你使用闭包来初始化属性，请记住在闭包执行时，实例的其它部分都还没有初始化。这意味着你不能在闭包里访问其它属性，即使这些属性有默认值。同样，你也不能使用隐式的self属性，或者调用任何实例方法
 */
class SomeClass {
    let someProperty: String = {
        // 在这个闭包中给 someProperty 创建一个默认值
        // someValue 必须和 SomeType 类型相同
        var someValue = "sunjianfeng";
        return someValue
    }()
    
}


/*:
 #### 析构
 
  deinit {
 // 执行析构过程
 }
 
 
 ####自动引用计数
 
  弱引用必须被声明为变量，表明其值能在运行时被修改。弱引用不能被声明为常量。
  weak var tenant: Person?
 
  ####无主引用
 
   和弱引用类似，无主引用不会牢牢保持住引用的实例。和弱引用不同的是，无主引用是永远有值的。因此，无主引用总是被定义为非可选类型（non-optional type）。你可以在声明属性或者变量时，在前面加上关键字unowned表示这是一个无主引用。
 
   由于无主引用是非可选类型，你不需要在使用它的时候将它展开。无主引用总是可以被直接访问。不过 ARC 无法在实例被销毁后将无主引用设为nil，因为非可选类型的变量不允许被赋值为nil。
 使用`闭包捕获列表`打破闭包的循环引用
 
 */
class HTMLElement {
    let name:String
    var  text:String?
    lazy var asHtml:(Void ->String) = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        }else{
            return "<\(self.name)/>"
        }
    }
    init(name:String,text:String? = nil){
        self.name = name;
        self.text = text;
    }
}
/*:
 注意
 asHTML声明为lazy属性，因为只有当元素确实需要被处理为 HTML 输出的字符串时，才需要使用asHTML。也就是说，在默认的闭包中可以使用self，因为只有当初始化完成以及self确实存在后，才能访问lazy属性。
 
 */
let heading = HTMLElement(name: "h1");
heading.text = "sunjainfeng";

heading.asHtml()
let defaultText = "some default text";
heading.asHtml = {
    return "<\(heading.name)>\(heading.text ?? defaultText)<\(heading.name)>";
}

heading.asHtml();

/*:
 
 定义捕获列表
 
 捕获列表中的每一项都由一对元素组成，一个元素是weak或unowned关键字，另一个元素是类实例的引用（例如self）或初始化过的变量（如delegate = self.delegate!）。这些项在方括号中用逗号分开。
 
 如果闭包有参数列表和返回类型，把捕获列表放在它们前面：
 `
 lazy var someClosure: (Int, String) -> String = {
     [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
 // 这里是闭包的函数体
 }
 `
 如果闭包没有指明参数列表或者返回类型，即它们会通过上下文推断，那么可以把捕获列表和关键字in放在闭包最开始的地方：
 `
 lazy var someClosure: Void -> String = {
      [unowned self, weak delegate = self.delegate!] in
 // 这里是闭包的函数体
 }
 `
 
 ###### 弱引用和无主引用
 
 `在闭包和捕获的实例总是互相引用并且总是同时销毁时，将闭包内的捕获定义为无主引用。`
 
 相反的，在被捕获的引用可能会变为nil时，将闭包内的捕获定义为弱引用。弱引用总是可选类型，并且当引用的实例被销毁后，弱引用的值会自动置为nil。这使我们可以在闭包体内检查它们是否存在。
 
 注意
 如果被捕获的引用绝对不会变为nil，应该用无主引用，而不是弱引用。
 前面的HTMLElement例子中，无主引用是正确的解决循环强引用的方法。这样编写HTMLElement类来避免循环强引用
 
 
 */


class HTMLElement2 {
    
    let name: String
    let text: String?
    
    lazy var asHTML: Void -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
    
}


/*:
  ## 可选链
  当一个类的属性是optional时，由于该property 有可能是nil，instance.property！进行强制解包会引发运行时错误，所以可以instance.property? ，当为nil时，返回nil
 1.使用可选链调用方法，判断方法是否调用成功
 
 if john.residence?.printNumberOfRooms() != nil {
 print("It was possible to print the number of rooms.")
 } else {
 print("It was not possible to print the number of rooms.")
 }
 2. 使用可选链访问下标
 john.residence?[0] = Room(name: "Bathroom")
 
 注意
 通过可选链式调用访问可选值的下标时，应该将问号放在下标方括号的前面而不是后面。可选链式调用的问号一般直接跟在可选表达式的后面。
 
 3. 访问可选类型的下标
 
 4. 可选链的多层可选链调用
   * 如果访问的值不是可选的，可选链将返回可选值 Int -> Int?
   * 如果访问的值是可选的，可选链调用不会让返回值变为“更可选” int? -> Int??
 5. 如果要在该方法的返回值上进行可选链式调用，在方法的圆括号后面加上问号即可
  
 
 
 */

var testScore = ["Dave":[23,45,54],"Bev":[34,32,11]];
testScore["Dave"]?[0] = 100;
testScore["Bev"]?[2] = 100;
testScore["Sun"]?[0] = 300;

/*  
 // 5
if let beginsWithThe =
    john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("John's building identifier begins with \"The\".")
    } else {
        print("John's building identifier does not begin with \"The\".")
    }
}
*/



//: [Next](@next)
