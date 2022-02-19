import Foundation


public class MyOpaqueWorker {
    
    public var repository: some ReadAndWriteRepository = {
        return MyJSONRepository()
    }()
    public weak var delegate: MyWorkerDelegate?
    
    public init() { }
    
    public func getUserData() throws {
        try repository.read({[weak self] result in
            if let result = result as? MyEntity {
                let user = User(id: UUID(), name: result.name)
                self?.delegate?.update(user: user)
            } else {
                self?.delegate?.showGenericError()
            }
        })
    }
    
}

