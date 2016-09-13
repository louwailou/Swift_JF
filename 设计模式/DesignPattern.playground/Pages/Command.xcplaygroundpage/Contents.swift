//: [Previous](@previous)

import Foundation

/*:
 #### commandLine pattern
 
 遥控器的每一个插槽对应一个命令，这样遥控器就变成了调用者，当按下按钮，相应的命令调用execute方法，其结果就是接收者(点灯，收音机...)的动作被调用
 
 */

protocol JFCommand {
    func execute() -> Void ;
    func undo() -> Void;
}
//receiver
class Light: NSObject {
    func on () -> Void {
        print("on ....");
    }
    func off() -> Void {
        print("off ....");
    }
}

// 命令对象将动作和 接收者包装到本类中，只暴露一个execute 接口
class LightONCommand: JFCommand {
    var  light :Light;// 命令 的接收者
    
    init(alight :Light){
        light = alight;
    }
    func execute(){
        self.light.on();
    }
    func undo() {
        self.light.off();
    }
}



class LightOffCommand: JFCommand {
    var light :Light;
    init(alight :Light){
        self.light = alight;
    }
    func execute() {
        self.light.off();
    }
    func undo() {
        self.light.on();
    }
}

// invoker
class SimpleRemoteControl: NSObject {
    var undoCommand : JFCommand;
    var onCommands = [JFCommand]();
    var offCommands = [JFCommand]();
    init(aslot :JFCommand) {
        undoCommand = aslot;
    }
    
    func setCommand(acommand :JFCommand){
        self.undoCommand = acommand;
    }
    func addCommand(index:NSInteger, onCommand: JFCommand,off:JFCommand) -> Void {
        self.offCommands.append(off);
        self.onCommands.append(onCommand);
    }
    func offButtonPressedAtIndex(index:NSInteger) ->Void{
        self.offCommands[index].execute();
        self.undoCommand = self.offCommands[index];
    }
    func onbuttonPressedAtIndex(index:NSInteger) -> Void{
        let  co = self.onCommands[index];
        co.execute();
        self.undoCommand = co;
    }
    func buttonPressed(){
        self.undoCommand.execute();
    }
    
}

let alight = Light();
let com = LightONCommand(alight: alight) ;
var remote =  SimpleRemoteControl(aslot: com);
remote.buttonPressed();

// 如果是想让一个按钮控制所有的电器开关，怎么版？？

/*
 
 Light = Light();
 TV = TV();
 Stereo = Stereo();
 lightOn = LightOnCommand(light);
 stereoO = StereoOnCommand(stereo);
 tvOn = TVOnCommand(tv);
 
 新增一个集合命令
 class MacroCommand :JFCommand
 {
 
 commands = [JFCommand]();
 
 func execute(){
 for ... in commands
 commands[i].execute();
 }
 */


//: [Next](@next)
