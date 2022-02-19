import Foundation

//ASSOCIATED TYPES EXAMPLE

let value = MyEntity(name: "Paulo", age: 33)
let myRepository = MyJSONRepository()
try? myRepository.write(values: value) { completed in
    //Does nothing
}
try? myRepository.read { object in
    print(object)
}


//ERASED TYPES EXAMPLE

class MyDelegateImplementation: MyWorkerDelegate {
    func update(user: User) {
        print(user)
    }
    
    func showGenericError() {
        print("Generic Error")
    }
    
}

let delegate = MyDelegateImplementation()
let myWorker = MyWorker(repository: MyJSONRepository())
myWorker.delegate = delegate

try? myWorker.getUserData()

let myOpaqueWorker = MyOpaqueWorker()
myWorker.delegate = delegate

try? myOpaqueWorker.repository.read { object in
    print(object)
}

try? myOpaqueWorker.getUserData()
