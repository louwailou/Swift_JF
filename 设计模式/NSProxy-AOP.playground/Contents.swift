//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class MyProxy :NSProxy {
    var _object:AnyObject?;
   override init(obj :AnyObject) {
       
        _object = obj;
    
    }
    
    open class func proxyforObject(obj:AnyObject)->MyProxy?{
        let proxya = MyProxy(obj: obj);
        return proxya;
    }
}