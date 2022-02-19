import Foundation

protocol MyProtocol {
    
    func myFunction(with paramenters: Any)
    
    func myOptionalFunction(with paramenters: Any)
    
}

extension MyProtocol {
    
    func myOptionalFunction(with paramenters: Any) {
        //Does nothing
    }
    
}

struct MyStruct: MyProtocol {
    
    func myFunction(with paramenters: Any) {
        //Non-optional method code
    }
    
}


@objc protocol MyObjcProtocol: AnyObject {
    
    func myFunction(with paramenters: Any)
    
    @objc optional func myOptFunction(with paramenters: Any)
    
}

class MyClass: MyObjcProtocol {
    
    func myFunction(with paramenters: Any) {
        //Non-optional method code
    }
    
}

