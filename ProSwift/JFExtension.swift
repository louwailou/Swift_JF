//
//  JFExtension.swift
//  ProSwift
//
//  Created by Sun on 15/12/19.
//  Copyright © 2015年 Sun. All rights reserved.
//

import Foundation



/*

extension Array{
    subscript(input: [Int]) -> Slice<T> {
        get {
            var result = Slice<T>()
            for i in input {
                assert(i < self.count, "Index out of range")
                result.append(self[i])
            }
            return result
        }
        
        set {
            for (index,i) in enumerate(input) {
                assert(i < self.count, "Index out of range")
                self[i] = newValue[index]
            }
        }
    }
}

extension NSCharacterSet: StringLiteralConvertible {
    typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    
    public class func convertFromExtendedGraphemeClusterLiteral(value: StringLiteralType) -> Self {
        return self(charactersInString: value)
    }
    
    public class func convertFromStringLiteral(value: StringLiteralType) -> Self {
        return self(charactersInString: value)
    }
}

// MARK: NSExpression

extension NSExpression: StringLiteralConvertible {
    typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    
    public class func convertFromExtendedGraphemeClusterLiteral(value: StringLiteralType) -> Self {
        return self(format: value, argumentArray: [])
    }
    
    public class func convertFromStringLiteral(value: StringLiteralType) -> Self {
        return self(format: value, argumentArray: [])
    }
}

// MARK: NSIndexPath

extension NSIndexPath: ArrayLiteralConvertible {
    public class func convertFromArrayLiteral(indexes: Int...) -> Self {
        return self(indexes: indexes, length: indexes.count)
    }
}

// MARK: NSIndexSet

extension NSIndexSet: ArrayLiteralConvertible {
    public class func convertFromArrayLiteral(indexes: Int...) -> Self {
        var mutableIndexSet = NSMutableIndexSet()
        for index in indexes {
            mutableIndexSet.addIndex(index)
        }
        
        return self(indexSet: mutableIndexSet)
    }
}

// MARK: NSNull

extension NSNull: NilLiteralConvertible {
    public class func convertFromNilLiteral() -> Self {
        return self()
    }
}

// MARK: NSOrderedSet

extension NSOrderedSet: ArrayLiteralConvertible {
    public class func convertFromArrayLiteral(elements: AnyObject...) -> Self {
        return self(array: elements)
    }
}

// MARK: NSPredicate

extension NSPredicate: StringLiteralConvertible {
    typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    
    public class func convertFromExtendedGraphemeClusterLiteral(value: StringLiteralType) -> Self {
        return self(format: value, argumentArray: [])
    }
    
    public class func convertFromStringLiteral(value: StringLiteralType) -> Self {
        return self(format: value, argumentArray: [])
    }
}

// MARK: NSRegularExpression

extension NSRegularExpression: StringLiteralConvertible {
    typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    
    public class func convertFromExtendedGraphemeClusterLiteral(value: StringLiteralType) -> Self {
        return self(pattern: value, options: nil, error: nil)
    }
    
    public class func convertFromStringLiteral(value: StringLiteralType) -> Self {
        return self(pattern: value, options: nil, error: nil)
    }
}

// MARK: NSScanner

extension NSScanner: StringLiteralConvertible {
    typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    
    public class func convertFromExtendedGraphemeClusterLiteral(value: StringLiteralType) -> Self {
        return self(string: value)
    }
    
    public class func convertFromStringLiteral(value: StringLiteralType) -> Self {
        return self(string: value)
    }
}

// MARK: NSSet

extension NSSet: ArrayLiteralConvertible {
    public class func convertFromArrayLiteral(elements: AnyObject...) -> Self {
        return self(array: elements)
    }
}

// MARK: NSTimeZone

extension NSTimeZone: StringLiteralConvertible {
    typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    
    public class func convertFromExtendedGraphemeClusterLiteral(value: StringLiteralType) -> Self {
        return self(name: value)
    }
    
    public class func convertFromStringLiteral(value: StringLiteralType) -> Self {
        return self(name: value)
    }
}

// MARK: NSURL

extension NSURL: StringLiteralConvertible {
    typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
    
    public class func convertFromExtendedGraphemeClusterLiteral(value: StringLiteralType) -> Self {
        return self(string: value)
    }
    
    public class func convertFromStringLiteral(value: StringLiteralType) -> Self {
        return self(string: value)
    }
}

// MARK: - UIKit -

#if os(iOS)
    
    import UIKit
    
    // MARK: UIColor
    
    extension UIColor: IntegerLiteralConvertible {
        public class func convertFromIntegerLiteral(value: IntegerLiteralType) -> Self {
            let red = CGFloat((value & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((value & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(value & 0x0000FF) / 255.0
            let alpha = CGFloat(1.0)
            
            return self(red: red, green: green, blue: blue, alpha: alpha)
        }
    }
    
    // MARK: UIImage
    
    extension UIImage: StringLiteralConvertible {
        typealias ExtendedGraphemeClusterLiteralType = StringLiteralType
        
        public class func convertFromExtendedGraphemeClusterLiteral(value: StringLiteralType) -> Self {
            return self(named: value)
        }
        
        public class func convertFromStringLiteral(value: StringLiteralType) -> Self {
            return self(named: value)
        }
    }
    
#endif

*/


extension String {
    
    subscript (i: Int) -> Character {
        print("\(self.startIndex.advancedBy(i))")
        print("\(self[self.startIndex])")
        let chara = self[self.startIndex.advancedBy(i)]
        return chara;
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
