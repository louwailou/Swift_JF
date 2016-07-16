//: [Previous](@previous)

import Foundation


/*:
 ##字符串
*/

let greeting = "Guten Tag!"
greeting[greeting.startIndex]
// G
greeting[greeting.endIndex.predecessor()]
// !
greeting[greeting.startIndex.successor()]
// u
let index = greeting.startIndex.advancedBy(7)
greeting[index]

// 插入,删除
//insertContentsOf(_:at:)

//removeRange(_:)

//hasSuffix(_:)

var sun = "sunjianfeng";
//var indexAt :String = sun[2]; x

let arr = [1,2,3,4,5];
let brr = arr.map({ (a) -> String in
    "NO." + String(a);
    
})
let Brr = arr.map { a in
    "N20."+String(a);
}
arr.reduce(0) { (a, b) -> Int in
    return a+b;
}

/*:
 ##数组
 */


let arrE = [Int]();
//arr.append(1);
let arrUnmutable = [1,2];
// 不可变的数组，元素也是不可变得
//arrUnmutable[0] = 100;

var shoppingList :[String] = ["1","2"];
// 数组+数组 -> 新数组
var addTwo = arrE + arrUnmutable;

//数组遍历
for (index,value) in shoppingList.enumerate(){
    print("index -> \(index) value-> \(value)");
}

/**************字典*****************/
var namesOfIntegers = [Int:String]();
namesOfIntegers[10] = "10";
namesOfIntegers.updateValue("12", forKey: 10);
namesOfIntegers.updateValue("1", forKey: 1);// 添加或者更新元素
namesOfIntegers[1] = nil;//删除元素

for (port ,index) in namesOfIntegers{
    
}




