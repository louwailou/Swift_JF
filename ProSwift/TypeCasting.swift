//
//  TypeCasting.swift
//  ProSwift
//
//  Created by Sun on 15/12/3.
//  Copyright © 2015年 Sun. All rights reserved.
//

import Foundation
class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

class typeCastingTest {
    var movie :Movie;
    init (m:Movie){
        movie = m;
    }
    func test(){
        let library = [
            Movie(name: "Casablanca", director: "Michael Curtiz"),
            Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
            Movie(name: "Citizen Kane", director: "Orson Welles"),
            Song(name: "The One And Only", artist: "Chesney Hawkes"),
            Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
        ]
        var movieCount = 0
        var songCount = 0
        
        for item in library {
            if item is Movie {
                //print("\(item.name) dir = \(item.director)") // is  仅仅是判断 是否是该类型，并不是类型转换
                let mo = item as! Movie;// as! 强制进行类型转换
                print("\(mo.name) dir = \(mo.director)")
                ++movieCount
            } else if item is Song {
                ++songCount
            }
        }
        
        print("Media library contains \(movieCount) movies and \(songCount) songs")
        // 打印 “Media library contains 2 movies and 3 songs”
        
        // step 2
        
        
        for item in library {
            if let movie = item as? Movie {
                print("Movie: '\(movie.name)', dir. \(movie.director)")
            } else if let song = item as? Song {
                print("Song: '\(song.name)', by \(song.artist)")
            }
            /* 
            当向下转型为 Movie 应用在两个 Song 实例时将会失败。为了处理这种情况，上面的例子使用了可选绑定（optional binding）来检查可选 Movie 真的包含一个值（这个是为了判断下转是否成功。）可选绑定是这样写的“if let movie = item as? Movie”，可以这样解读：
            
            “尝试将 item 转为 Movie 类型。若成功，设置一个新的临时常量 movie 来存储返回的可选 Movie 中的值”
            
            若向下转型成功，然后 movie 的属性将用于打印一个 Movie 实例的描述，包括它的导演的名字 director。相似的原理被用来检测 Song 实例，当 Song 被找到时则打印它的描述（包含 artist 的名字）。
            

            */
        }
        
        // Movie: 'Casablanca', dir. Michael Curtiz
        // Song: 'Blue Suede Shoes', by Elvis Presley
        // Movie: 'Citizen Kane', dir. Orson Welles
        // Song: 'The One And Only', by Chesney Hawkes
        // Song: 'Never Gonna Give You Up', by Rick Astley
    }
    
    /*
    向下转型（Downcasting）
    某类型的一个常量或变量可能在幕后实际上属于一个子类。当确定是这种情况时，你可以尝试向下转到它的子类型，用类型转换操作符（as? 或 as!）。
    当你不确定向下转型可以成功时，用类型转换的条件形式（as?）。条件形式的类型转换总是返回一个可选值（optional value），并且若下转是不可能的，可选值将是 nil。这使你能够检查向下转型是否成功。
    
    只有你可以确定向下转型一定会成功时，才使用强制形式（as!）。当你试图向下转型为一个不正确的类型时，强制形式的类型转换会触发一个运行时错误。
    
    
    
    Any 和 AnyObject 的类型转换
    Swift 为不确定类型提供了两种特殊的类型别名：
    
    AnyObject 可以表示任何类类型的实例。
    Any 可以表示任何类型，包括函数类型。
    注意
    只有当你确实需要它们的行为和功能时才使用 Any 和 AnyObject。在你的代码里使用你期望的明确类型总是更好的。
    */
    func any(){
        var things = [Any]()
        
        things.append(0)
        things.append(0.0)
        things.append(42)
        things.append(3.14159)
        things.append("hello")
        things.append((3.0, 5.0))
        things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
        things.append({ (name: String) -> String in "Hello, \(name)" })
        
        
        for thing in things {
            switch thing {
            case 0 as Int:
                print("zero as an Int")
            case 0 as Double:
                print("zero as a Double")
            case let someInt as Int:
                print("an integer value of \(someInt)")
            case let someDouble as Double where someDouble > 0:
                print("a positive double value of \(someDouble)")
            case is Double:
                print("some other double value that I don't want to print")
            case let someString as String:
                print("a string value of \"\(someString)\"")
            case let (x, y) as (Double, Double):
                print("an (x, y) point at \(x), \(y)")
            case let movie as Movie:
                print("a movie called '\(movie.name)', dir. \(movie.director)")
            case let stringConverter as String -> String:
                print(stringConverter("Michael"))
            default:
                print("something else")
            }
        }

    }
}