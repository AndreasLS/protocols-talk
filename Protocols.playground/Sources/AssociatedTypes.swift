import Foundation

///BASE PROTOCOL

public protocol BasicRepository {
    associatedtype Entity
}


///READ & WRITE PROTOCOLS


public protocol ReadRepository: BasicRepository {
    func read(_ completion: @escaping (Entity)->Void) throws
}

public protocol WriteRepository: BasicRepository {
    func write(values: Entity, completion: @escaping (Bool)->Void) throws
}

public typealias ReadAndWriteRepository = ReadRepository & WriteRepository


//CODABLE EXTENSIONS


public enum UserDefaultsError: Error {
    case noRecordFound
}

public extension ReadRepository where Entity: Codable {
    
    func read(_ completion: @escaping (Entity)->Void) throws {
        let string = UserDefaults.standard.string(forKey: "myDummyDatabase")
        if let data = string?.data(using: .utf8) {
            let object = try JSONDecoder().decode(Entity.self, from: data)
            completion(object)
        } else {
            throw UserDefaultsError.noRecordFound
        }
    }
    
}

public extension WriteRepository where Entity: Codable {

    func write(values: Entity, completion: @escaping (Bool) -> Void) throws {
        let data = try JSONEncoder().encode(values)
        let string = String(data: data, encoding: .utf8)
        UserDefaults.standard.set(string, forKey: "myDummyDatabase")
        completion(true)
    }
}


///EXAMPLES


public struct MyEntity: Codable {
    let name: String
    let age: Int
    
    public init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

public struct MyNonCodableEntity {
    let name: String
    let age: Int
    
    public init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

public class MyRepository: ReadAndWriteRepository {
    
    public typealias Entity = MyNonCodableEntity
    
    public init() { }
    
    public func read(_ completion: @escaping (MyNonCodableEntity) -> Void) throws {
        //Should be implemented
    }
    
    public func write(values: MyNonCodableEntity, completion: @escaping (Bool) -> Void) throws {
        //Should be implemented
    }
    
}

public class MyJSONRepository: ReadAndWriteRepository {
    
    public typealias Entity = MyEntity
    
    public init() { }
    
}