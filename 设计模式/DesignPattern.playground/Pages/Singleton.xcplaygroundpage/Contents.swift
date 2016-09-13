//: [Previous](@previous)

import Foundation


//class SingletonStatic: NSObject {
//   static func shareInstance() -> SingletonStatic {
//     var shareInstance:SingletonStatic  ;
//    if (shareInstance ){
//        shareInstance = SingletonStatic();
//    }
//    return shareInstance;
//    }
//}
//
//


/*
 java
 
 public static synchronized Singleton getInstance(){
    if(uniqueInstance == null){
        uniqueInstance = new Singleton();
 
     }
 return uniqueInstance;
 
 }
 // 这个只需要第一次同步，第二次取值就不需要同步了，所以这是一种浪费
 第二种方式：在类加载的时候就保证了单例 也保证了线程的安全
 private static Singleton uniqueInstance = new Singleton();
 public static Signleton getInstance(){
     return uniqueInstance;
  }
 
 第三种方式: 使用双重检查加锁 减少使用同步
 
 public class Singleton{
   private volatile static Singleton uniqueInstance;
   ....
   public static Singleton getInstace(){
     if(uniqueInstace == null){
       synchronized (Singleton.class){
 
      if(uniqueInstance == null){
          uniqueInstance = new Singleton()
 
         }
 
      }
 
     }
       return uniqueInstance;
   }
 }
 
 
 
 
 */
class Singleton: NSObject {
    static var shareInstance :Singleton{
        dispatch_once(&Inner.token) {
            Inner.instance = Singleton();
        }
        return Inner.instance!;
    };
    
    struct Inner {
        static var instance:Singleton?
        static var token:dispatch_once_t = 0;
    }
}
var single = Singleton.shareInstance;

//
class Singleton2: NSObject {
    static var shareInstance:Singleton2 {
        return Inner.instance;
    }
    struct Inner  {
        static let instance = Singleton2();
    }
}
//: [Next](@next)
