//: Playground - noun: a place where people can play

import UIKit
enum ShapeEnum{
    case Line
    case Circle
}

class JFLine {
    func drawLine(frame:CGRect) -> Void {
        print("drawLine...")
    }
}

class JFCircle {
    func drawCircle(frame:CGRect) -> Void {
        print("draw circle...")
    }
}

class JFView {
    var line: JFLine?
    var circle: JFCircle?
    
    func draw(shapeType:ShapeEnum) -> Void {
        switch shapeType {
        case .Line:
            line?.drawLine(frame:CGRect(x: 10.0, y: 10.0, width: 100.0, height: 1.0));
        case .Circle:
              circle?.drawCircle(frame: CGRect(x: 10.0, y: 50.0, width: 100.0, height: 100.0))
            
        }
        
      
    }
}
/*：
  现在我们要增加一个三角形， 嗯，修改JFView,ShapeEnum ,添加Triangle... 这违反了开闭原则啊啊啊啊啊
 
 肿么办？？？ 抽象，抽象，再抽象
 */

protocol JFShape {
    func draw(frame:CGRect) -> Void;
}

class JFOCPLine:JFShape{
     func draw(frame: CGRect) {
        print("ocp draw line...")
    }
}

class JFOCPCircle:JFShape{
    func draw(frame: CGRect) {
        print("ocp draw circle ...")
    }
}

class JFOCPTriangle:JFShape{
    func draw(frame: CGRect) {
        print("ocp draw triangle ...")

    }
}

class JFOCPView {
    
    var shapes:Array<JFShape> = Array();
    init() {
    // .....
    }
    func draw() -> Void {
       
        for shape in shapes {
            shape.draw(frame: CGRect(x: 0, y: 0, width: 0, height: 0));
        }
        
    }
}







