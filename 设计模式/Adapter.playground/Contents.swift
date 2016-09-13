//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


protocol Circularity {
    var radius : Double {get}
}
class RoundPeg : Circularity{
    let radius: Double
    init(radius:Double){
        self.radius = radius;
    }
}

class  RoundHole: Circularity {
    let  radius: Double
    init(radius:Double){
        self.radius = radius;
    }
    func pegFits(peg:Circularity)-> Bool{
        return peg.radius <= radius
    }
}


class SquarePeg{
    let width :Double
    init(width:Double){
        self.width = width
    }
    
}

class SquarePegAdapter:Circularity{
    private let peg:SquarePeg
    var radius:Double{
        get {
            return sqrt(pow(peg.width/2, 2)*2)
        }
    }
    init(peg:SquarePeg){
        self.peg = peg
    }
}


let hole = RoundHole(radius: 5.0)
for i in 5...10 {
  		let squarePeg = SquarePeg(width: Double(i))
  		let peg: Circularity = SquarePegAdapter(peg: squarePeg)
  		let fit = hole.pegFits(peg)
  		print("width:\(i), fit:\(fit)")
}

// 进一步简化 省略适配器类
extension SquarePeg:Circularity{
    var radius:Double{
        get {
            return sqrt(pow(width/2, 2)*2)
        }
    }
}


for i in 5...10 {
  		let peg = SquarePeg(width: Double(i))
  		let fit = hole.pegFits(peg)
  		print("width:\(i), fit:\(fit)")
}




