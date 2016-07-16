//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
var str2 = "sun"


str.startIndex.advancedBy(2)

/************常量& 变量*******************/
let constN = 100;
var varN = "sun";

/************元组*******************/
let JFTuple = ("sunjianfeng",20,"l1");

let httpState = (domain:"http",port:"8080");


let (tname,tage,tlever) = JFTuple;
print("tname= \(tname) age = \(tage)");

print("index[0]=\(JFTuple.0)")
;
func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score }
        sum += score }
    return (min, max, sum)
}
let statistics = calculateStatistics([5, 3, 100, 3, 9])
print(statistics.sum)
print(statistics.2)


/**************可选类型******************/
//如果你声明一个可选常量或者变量但是没有赋值，它们会自动被设置为nil
var serverPort:Int?;
print(serverPort);
serverPort = 8090;

var serverDomain:String?;
serverDomain = "http";

//可选绑定-> 用来判断可选的类型是否包含值，如果包含就将值付给一个常量或者变量
if let domain = serverDomain {
    print("domain = \(domain)");
}else{
    print("domain = nil");
}

//你可以包含多个可选绑定在if语句中，并使用where子句做布尔值判断。
if let firstNumber = Int("4"), secondNumber = Int("42") where firstNumber < secondNumber {
    print("\(firstNumber) < \(secondNumber)")
}

//有时候在程序架构中，第一次被赋值之后，可以确定一个可选类型_总会_有值。在这种情况下，每次都要判断和解析可选值是非常低效的，因为可以确定它总会有值。
/********************隐式解析可选类型**********/
let implicitType :String! = "implicitType";
print("implicit  \(implicitType)");

/************基本运算***************/

/*注意 === 和!==  恒等 不恒等 来判断是否引用了同一个对象

区间运算符 a...b ->[a,b]
半开区间 a..< b ->[a,)
*/















