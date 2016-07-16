import Foundation



/*******泛型**************/
// 注意where 的使用
/*
func anyCommonElements <T: SequenceType, U: SequenceType where T.Generator.Element: Equatable, T.Generator.Element == U.Generator.Element>(lhs:[T],rhs :[U])-> Bool{
    
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                return true }
        } }
    return false
}
anyCommonElements([1, 2, 3], [3])

*/


class TypeA: NSObject {
    override init() {
        print("TypeA");
    }
}

class ObjectA<T:TypeA>: NSObject {
    var type = [TypeA]();
    init(type:T) {
        self.type.append(type);
    }
    func addNewTyep(){
        let newType = TypeA();
        self.type.append(newType);// T 是TypeA  的子类，只能添加T 和T 的子类，但是不能TypeA，因此 type = [T](); 添加newType报错
    }
}

struct Stack<T>{
    var items = [T]();
    mutating func push(item :T) {
        items.append(item);
    }
    mutating func pop()->T  {
        return items.removeLast()
    }
    
    
}
extension String {
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = startIndex.advancedBy(r.startIndex)
        let end = start.advancedBy(r.endIndex - r.startIndex)
        return self[Range(start: start, end: end)]
    }
}




//
//func format(amout :Double, currency :Currency) -> String {
//    let formatter =  NSNumberFormatter();
//    formatter.numberStyle = .CurrencyStyle;
//    formatter.currencySymbol = symbole(currency);
//    return formatter.stringFromNumber(amout)!;
//    
//}


