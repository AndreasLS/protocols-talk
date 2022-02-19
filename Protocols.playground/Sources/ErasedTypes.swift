import Foundation

public struct AnyReadWriteRepository<T: ReadAndWriteRepository>: ReadAndWriteRepository {
    
    public typealias Entity = T.Entity
    let repository: T
    
    public init(_ repository: T) {
        self.repository = repository
    }
    
    public func read(_ completion: @escaping (Entity) -> Void) throws {
        try self.repository.read(completion)
    }
    
    public func write(values: Entity, completion: @escaping (Bool) -> Void) throws {
        try self.repository.write(values: values, completion: completion)
    }
    
}

public struct User {
    let id: UUID
    let name: String
}

public protocol MyWorkerDelegate: AnyObject {
    func update(user: User)
    func showGenericError()
}

public class MyWorker<T: ReadAndWriteRepository> {
    
    public var repository: AnyReadWriteRepository<T>?
    public weak var delegate: MyWorkerDelegate?
    
    public init(repository: T) {
        self.repository = AnyReadWriteRepository(repository)
    }
    
    public func getUserData() throws {
        try repository?.repository.read({[weak self] result in
            if let result = result as? MyEntity {
                let user = User(id: UUID(), name: result.name)
                self?.delegate?.update(user: user)
            } else {
                self?.delegate?.showGenericError()
            }
        })
    }
    
}
