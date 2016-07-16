//: [Previous](@previous)

import Foundation


/*******************实例方法是(currying)柯里化函数***************************/

class MyHelloWorldClass: NSObject {
    func helloworldName(name:String) -> String{
        return "hello \(name)";
    }
    
    func externalFuncName(name:String) -> Void {
        print("使用外部引用名");
    }
}

let myHelloInstance = MyHelloWorldClass();
let helloFunc = MyHelloWorldClass.helloworldName;
helloFunc(myHelloInstance)("sunjianfeng");

/****************optional ********************/

func myFuncWithOptionalType(optionalParameter: String?) {
    if let unwrappedOptional = optionalParameter {
        print("The optional has a value! It's \(unwrappedOptional)")
    } else {
        print("The optional is nil!")
    }
}

myFuncWithOptionalType("someString")
// optional has a value! It's someString

/**
 可变参数
 */
func helloWithNames(names: String...) {
    for name in names {
        print("Hello, \(name)");
    }
}

// 2 names
helloWithNames("Mr. Robot", "Mr. Potato")

// Hello, Mr. Robot
// Hello, Mr. Potato

// 4 names
helloWithNames("Batman", "Superman", "Wonder Woman", "Catwoman")
// Hello, Batman
// Hello, Superman
// Hello, Wonder Woman
// Hello, Catwoman


/***************输入输出参数inout****************/

var name1 = "Mr. Potato"
var name2 = "Mr. Roboto"

func nameSwap(inout name1: String, inout name2: String) {
    let oldName1 = name1
    name1 = name2
    name2 = oldName1
}

nameSwap(&name1, name2: &name2)

name1
// Mr. Roboto

name2
// Mr. Potato


/***************使用泛型********************/

func valueSwap<T>(inout value1:T, inout value2:T) -> Void {
    let old = value1;
    value1 = value2;
    value2 = old;
}
var nameSwap1 = "MR.robot";
var nameSwap2 = "MR.Sun";
valueSwap(&nameSwap1, value2: &nameSwap2);

print("1     \(nameSwap1)    2: \(nameSwap2)");



/*****************在函数范围内修改变量*************************/

var Cname = "MR.robot";
func appendNumber(var name:String,maxNumber:Int) ->String {
    for i in 0...maxNumber {
        name += String(i+1);
    }
    return name;
}

appendNumber(Cname, maxNumber: 5);
//并没有改变Cname 的值 不会修改外部变量的值，只会在函数作用于内修改
print("cname = \(Cname)");

/*******************权限控制************************/


/**************多个可选值******************/
func findRangeFromNumbers(numbers: Int...) -> (min: Int, max: Int)? {
    
    if numbers.count > 0 {
        
        var min = numbers[0]
        var max = numbers[0]
        
        for number in numbers {
            if number > max {
                max = number
            }
            
            if number < min {
                min = number
            }
        }
        
        return (min, max)
    } else {
        return nil
    }
}

if let range = findRangeFromNumbers() {
    print("Max: \(range.max). Min: \(range.min)")
} else {
    print("No numbers!")
}
//



//如果你决定你元组值中一些值是可选，拆包时候会变得有些复杂，你需要考虑每中单独的可选返回值的组合

func componentsFromUrlString(urlString: String) -> (host: String?, path: String?) {
    let url = NSURL(string: urlString)!
    return (url.host, url.path)
}

let urlComponents = componentsFromUrlString("http://name.com/12345;param?foo=1&baa=2#fragment")

switch (urlComponents.host, urlComponents.path) {
    case let (.Some(host), .Some(path)):
       print("This url consists of host \(host) and path \(path)")
    case let (.Some(host), .None):
       print("This url only has a host \(host)")
    case let (.None, .Some(path)):
       print("This url only has path \(path). Make sure to add a host!")
    case (.None, .None):
        print("This is not a url!")
}
// This url consists of host name.com and path /12345



/***********************返回一个函数 Swift 中函数可以返回一个函数：
 
 
 func myFuncThatReturnsAFunc() -> (Int) -> String {
 return { number in
 return "The lucky number is \(number)"
 }
 }
 
 let returnedFunction = myFuncThatReturnsAFunc()
 
 returnedFunction(5)
 
 */
// The lucky number is 5
//为了更具有可读性，你当然可以为你的返回函数定义一个别名：

typealias returnedFunctionType = (Int) -> String

func myFuncThatReturnsAFunc() -> returnedFunctionType {
    return { number in
        return "The lucky number is \(number)"
    }
}

let returnedFunction = myFuncThatReturnsAFunc()

returnedFunction(5)

// The lucky number is 5
