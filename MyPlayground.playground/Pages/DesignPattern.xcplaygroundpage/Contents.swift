//: [Previous](@previous)


class JFPet: NSObject {
    var name: String?
    var  weigh: Float?
    init(name:String,weigh:Float) {
        self.name = name;
        self.weigh = weigh;
    }
    
}

class JFPerson: NSObject {
    var  pet:JFPet?
    var  name:String?
    var height :Float?
    init(name:String?,height:Float,pet:JFPet?){
        self.pet = pet;
        self.name = name;
        self.height = height;
    }
}

let pet = JFPet(name: "sunjianfeng", weigh: 12.6);
let author = JFPerson(name: "你好", height: 145.0, pet: pet);
var persons  = [JFPerson]();
for _ in 0...9 {
    persons.append(JFPerson(name:author.name!, height: author.height!, pet: pet));
}
// 声明一个cloning 协议

protocol Cloning{
    func clone() -> AnyObject?
}

extension JFPet:Cloning{
    func clone() -> AnyObject? {
        return JFPet(name: self.name!, weigh: self.weigh!);
    }
}

extension JFPerson:Cloning{
    func clone() -> AnyObject? {
        return JFPerson(name: self.name!, height: self.height!, pet: (pet?.clone() as! JFPet))
    }
}

let cauthor = JFPerson(name: "林欣达", height: 173, pet: JFPet(name: "球球", weigh: 2.0))
var cpersons: [JFPerson] = [JFPerson]()
for _ in 0...9 {
    cpersons.append(cauthor.clone()as! JFPerson)
}
/*:
#####  原型模式
 简单点来说，原型模式在iOS开发中就是NSCopying协议，通过实现这个协议完成对象和其成员对象的完全内存拷贝，也可以称为深拷贝。从这个角度而言，原型模式Prototype就是深拷贝的理论化
 
 */

class CloneManager :NSObject{
    static let shareManager = CloneManager()
    private var mapper:[String:Cloning] = [String:Cloning]()
    private override init() {
        super.init()
    }
    
    func storeV(protoType:Cloning,for identifier:String) -> Void {
        mapper[identifier] = protoType;
    }
    func protoType(identifier:String) -> Cloning? {
        return mapper[identifier];
    }
    func remove(identifier:String) -> Void {
        mapper[identifier] = nil;
    }
    
}

let cloneAuthor = cauthor.clone();
CloneManager.shareManager.storeV((cloneAuthor as? Cloning)!, for: "clone!");
let stroedClone = CloneManager.shareManager.protoType("clone!")
if cloneAuthor === cauthor {
    print("equal...")
}else{
    print("not equal..")
}

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




/*:
 ##### 面向协议编程
 
 
 */
protocol Bird{
    var name: String{get}
    var canFly :Bool {get }
}
protocol Flyable {
    var airSpeedVelocity: Double {get}
}

struct FlappyBird : Bird,Flyable {
    let name: String
    let flappyAmplitude : Double
    let flappyFrequency:Double
   // let canFly = true
    var airSpeedVelocity: Double{
        return 3.0 * flappyFrequency * flappyAmplitude;
    }
    
}

// 不会飞 所以使用继承就有问题了
struct Penguin :Bird{
    let name: String
    let canFly: Bool
    
    
}

struct SwiftBird: Bird,Flyable {
    var name: String{
        return "swift \(version)"
    }
    let version :Double
    //let canFly: Bool = true
    var airSpeedVelocity: Double {
        return 2000.0
    }
}
// 使用扩展添加默认实现
extension Bird where Self : Flyable{
    var canFly:Bool {
        return true;
    }
}


//遵守BooleanType协议意味着你的类型需要有一个Bool类型的 boolValue属性。那么是不是意味着你必须给现在或者之后的每一个Bird类型都添加这么个属性呢？
//当然，我们有更容易的办法———协议扩展
extension BooleanType where Self: Bird {
    var boolValue: Bool {return self.canFly}
}


//我们如何创建一个包含不同类型数据的数组，然后访问他们的属性的时候不用类型转换呢？

struct Hero {
    let name :String
    let power :String
    init?(json:[String:AnyObject]){
        guard let
           name = json["name"] as? String,
           power = json["power"] as? String
            else{
                return nil
        }
        self.name = name;
        self.power = power;
    }
}



struct  Princess {
    let name :String
    let kingdom :String
    init?(json :[String:AnyObject]){
        guard let
           name = json["name"] as? String,
        kingdom = json["kingdom"] as? String
            else{
                return nil;
        }
        self.name = name;
        self.kingdom = kingdom;
    }
}


struct  Civilian {
    let name :String
    init?(json:[String:AnyObject]){
        guard let
           name = json["name"] as? String
            else{
                return nil
        }
        self.name = name
    }
}

enum Character {
    case hero(Hero)
    case princess(Princess)
    case civilian(Civilian)
    private enum Type :String{
        case hero,princess,civilian
        static let key = "type"
    }
    init?(json:[String:AnyObject]){
        guard let
            stringV = json[Type.key] as? String,
        type = Type(rawValue:stringV)// 返回一个类型值
            
            else { return nil}
        switch type {
            // 构建具体的model类
        case .hero:
            guard let hero = Hero(json:json)
                else {return nil}
            self = .hero(hero)
        case .princess:
            guard let princess = Princess(json: json) else { return nil }
            self = .princess(princess)
            
        case .civilian:
            guard let civilian = Civilian(json: json) else { return nil }
            self = .civilian(civilian)
        }
    }
}


// 类型转换
let characters :[Character] = []

characters.forEach { (Character) in
    switch Character{
    case .hero(let hero):
        print(hero.name)
    case .princess(let princess):
        print(princess.kingdom)
        
    case .civilian(let civilian):
        print(civilian.name)
    
    }
    
}

// 每次使用需case 哦哦
func printPower(character:Character){
    if case Character.hero(let hero) = character {
        print(hero.power)
    }
}



//  ##### 工厂方法
