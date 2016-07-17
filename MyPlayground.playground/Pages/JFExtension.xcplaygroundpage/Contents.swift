//: [Previous](@previous)

import Foundation

/*:
  ## extension
 
 1. 添加计算型属性和计算型类型属性 ！！！不能使存储属性
 2. 定义实例方法和类型方法
 3. 提供新的便利构造函数，但不能添加指定构造函数或者析构函数
 4. 定义下标
 5. 定义和使用新的嵌套类型
 6. 使一个已有类型符合某个协议
 
 注意
   扩展可以添加计算属性，但是不可以添加存储属性，也不可以为已有属性添加属性观察器
 
 */
extension Double {
    
    var km: Double {return self * 1000 }
    var m : Double { return self }
    var cm :Double  { return self / 100 }
    var mm :Double  { return self / 1000}
}

struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}

// 因为结构体 Rect 未提供定制的构造器，因此它会获得一个逐一成员构造器。又因为它为所有存储型属性提供了默认值，它又会获得一个默认构造器。


extension Int{
    func repeation(task:()-> Void){
        for _ in 0..<self {
            task()
        }
    }
}

3.repeation({
    print("hello")
})
3.repeation{
    print("hello")
}

//: #### 可变实例方法
/*:
  通过扩展添加的实例方法可以修改该实例本身，结构体和枚举类型中修改self 或者其属性的方法必须 标注为mutating
 
 */

extension Int{
    mutating func squre () {
        self = self * self
    }
}

/*:
   #### 嵌套类型
 
 扩展可以为已有类，结构体和枚举添加新的嵌套类型
 
 
 */

extension Int {
    enum Kind {
        case Negative , Zero,Positive
    }
    var kind:Kind {
        switch self {
        case 0:
            return .Zero
        case let x where x > 0 :
            return .Positive
            
        default:
           return Kind.Negative
        }
    }
}

/*:
  协议不指定属性是存储属性还是计算属性，只是指定属性的名称和类型，以及属性是可读的还是可写的
 如果协议要求是可读写的，则该属性不能使常量或者只读的计算属性
 如果协议只要求是可读的，该属性不仅可读，还可写 get set
 
 */


protocol SomeProtocol {
    var mustBeSettable : Int {get set}
    var doseNotNeedToBeSettable :Int { get }
    static var someTypeProperty: Int {get set}
    //class var someTypePropertys: Int {get set } 不能用class 了
    
}

struct Person :SomeProtocol {
    var  mustBeSettable: Int
    var doseNotNeedToBeSettable: Int = 0
    static var someTypeProperty: Int = 0
    
}
class startShip: SomeProtocol {
    var  mustBeSettable: Int
    var doseNotNeedToBeSettable: Int = 0
    static var someTypeProperty: Int = 0
    var name :String?
    
    init (name:String = "",mSt:Int){
        self.name = name;
        self.mustBeSettable = mSt;
    }
    func simpleDesc() -> String {
        return "name \(self.name!)"
    }
    
}

/*:
 协议定义 构造函数
1. 你可以在采纳协议的类中实现构造器，无论是作为指定构造器，还是作为便利构造器。无论哪种情况，你都必须为构造器实现标上 required 修饰符：
 2.required 确保所有子类都提供次构造函数
 
 3.如果一个子类重写了父类的指定构造器，并且该构造器满足了某个协议的要求，那么该构造器的实现需要同时标注 required 和 override 修饰符
 
 */

protocol InitProtocol {
    init(somePropety:Int);
}

class InitClass: InitProtocol {
    required init(somePropety: Int) {
        
    }
}

/*:
 类类型专属协议
 通过添加class 关键字来限制协议只能被类类型采纳
 */

protocol SomeClassOnlyProtocol :class ,SomeProtocol {
    
}

/*:
 协议组合
 有时候需要同时采纳多个协议，你可以将多个协议采用 protocol<SomeProtocol, AnotherProtocol> 这样的格式进行组合，称为 协议合成（protocol composition）。你可以在 <> 中罗列任意多个你想要采纳的协议，以逗号分隔。
 */


protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person2: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(celebrator: protocol<Named, Aged>) {
    print("Happy birthday \(celebrator.name) - you're \(celebrator.age)!")
}
let birthdayPerson = Person2(name: "Malcolm", age: 21)
wishHappyBirthday(birthdayPerson)

/*:
  #### 检查协议一致性
 
 你可以使用类型转换中描述的 is 和 as 操作符来检查协议一致性，即是否符合某协议，并且可以转换到指定的协议类型。检查和转换到某个协议类型在语法上和类型的检查和转换完全相同：
 
 is 用来检查实例是否符合某个协议，若符合则返回 true，否则返回 false。
 as? 返回一个可选值，当实例符合某个协议时，返回类型为协议类型的可选值，否则返回 nil。
 as! 将实例强制向下转换到某个协议类型，如果强转失败，会引发运行时错误。
 
 */



/*:
 #### 可选的协议要求
 协议可以定义可选要求，采纳协议的类型可以选择是否实现这些要求。在协议中使用 optional 关键字作为前缀来定义可选要求。使用可选要求时（例如，可选的方法或者属性），它们的类型会自动变成可选的。比如，一个类型为 (Int) -> String 的方法会变成 ((Int) -> String)?。需要注意的是整个函数类型是可选的，而不是函数的返回值。
 
 协议中的可选要求可通过可选链式调用来使用，因为采纳协议的类型可能没有实现这些可选要求。类似 someOptionalMethod?(someArgument) 这样，你可以在可选方法名称后加上 ? 来调用可选方法
 
 */




@objc protocol CounterDataSource {
    optional func incrementForCount(count: Int) -> Int
    optional var fixedIncrement: Int { get }
}


class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.incrementForCount?(count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}


/*:
 #### 协议扩展
 协议可以通过扩展来为采纳协议的类型提供属性、方法以及下标的实现。通过这种方式，你可以基于协议本身来实现这些功能，而无需在每个采纳协议的类型中都重复同样的实现，也无需使用全局函数。
 

 */

//可以扩展 InitProtocol 协议来提供 randomBool() 方法。该方法使用协议中定义的 random() 方法来返回一个随机的 Bool 值：

extension InitProtocol {
    func randomBool() -> Bool {
        return Double(random()) > 0.5
    }
}

/*:
  #### 提供默认实现
 
  通过协议扩展为协议要求的属性，方法以及下标等提供默认实现
 如果采纳协议的类型为这些要求提供了自己的实现，那么这些自定义实现将会替代扩展中的默认实现被使用。
 
 
 #### 为协议扩展添加限制条件
 
 在扩展协议的时候，可以指定一些限制条件，只有采纳协议的类型满足这些限制条件时，才能获得协议扩展提供的默认实现。这些限制条件写在协议名之后，使用 where 子句来描述，正如Where子句中所描述的
 
 extension CollectionType where Generator.Element: TextRepresentable {
   var textualDescription: String {
   let itemsAsText = self.map { $0.textualDescription }
     
     return "[" + itemsAsText.joinWithSeparator(", ") + "]"
    }
 }
 */

// 所有T类型必须遵守Equatable 协议
func findIndex<T: Equatable>(array: [T], _ valueToFind: T) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}


/*:
 #### 协议的关联类型
 
 定义一个协议时，有的时候声明一个或多个关联类型作为协议定义的一部分将会非常有用。关联类型为协议中的某个类型提供了一个占位名（或者说别名），其代表的实际类型在协议被采纳时才会被指定。你可以通过 associatedtype 关键字来指定关联类型。
 
 
 
 */

protocol Container {
    associatedtype ItemType// 定义一个关联类型，让遵从该协议的类来提供具体的类型
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}

struct IntStack: Container {
    // IntStack 的原始实现部分
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    // Container 协议的实现部分
    typealias ItemType = Int
    mutating func append(item: Int) { // 这里是具体的类型了，不再是 ItemType
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}


// 使用类型推断 推断类型 不使用Typealias 指明具体啥类型

struct Stack<Element>: Container {
    // Stack<Element> 的原始实现部分
    var items = [Element]()
    mutating func push(item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // Container 协议的实现部分
    mutating func append(item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}




/*:
 #### 关联类型定义约束
 通过 where 子句要求一个关联类型遵从某个特定的协议，以及某个特定的类型参数和关联类型必须类型相同。你可以通过将 where 关键字紧跟在类型参数列表后面来定义 where 子句，where 子句后跟一个或者多个针对关联类型的约束，以及一个或多个类型参数和关联类型间的相等关系。
 
 
 
 
 
 
 
 */

func allItemsMatch<
    C1: Container, C2: Container
    where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>
    (someContainer: C1, _ anotherContainer: C2) -> Bool {
    
    // 检查两个容器含有相同数量的元素
    if someContainer.count != anotherContainer.count {
        return false
    }
    
    // 检查每一对元素是否相等
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    
    // 所有元素都匹配，返回 true
    return true
}




// 这是remote


//: [Next](@next)
