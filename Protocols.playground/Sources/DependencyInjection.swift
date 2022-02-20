import Foundation
import XCTest

protocol MyWorkerProtocol {
    func getUserData()
}

class MyPresenter: MyWorkerDelegate {
    
    var myWorker: MyWorkerProtocol
    
    init(worker: MyWorkerProtocol) {
        self.myWorker = worker
    }
    
    func getUser() {
        myWorker.getUserData()
    }
    
    func update(user: User) {
        //Update User in View
    }
    
    func showGenericError() {
        //Show generic error
    }
}

class MockWorker: MyWorkerProtocol {
    var isGetUserDataCalled = false
    weak var delegate: MyWorkerDelegate?
    func getUserData() {
        
    }
}

class MyPresenterTests: XCTestCase {
    func testMyPresenter() throws {
        let mock = MockWorker()
        let presenter = MyPresenter(worker: mock)
        mock.delegate = presenter
        presenter.getUser()
        XCTAssertTrue(mock.isGetUserDataCalled)
    }
}
