import XCTest
import Combine
class ViewModel: ObservableObject {
    private let valueSubject = CurrentValueSubject<Int, Never>(0)
    
    var valuePublisher: AnyPublisher<String, Never> {
        valueSubject.map { value in
            "0"
        }
        .eraseToAnyPublisher()
    }
    
    func set(value: Int) {
        valueSubject.send(value)
    }
    
}

final class CombineTests: XCTestCase {
    func test() {
        let viewModel = ViewModel()
        
        XCTAssertNotNil(viewModel)
        XCTAssertTrue(viewModel is (any ObservableObject))

        viewModel.set(value: 0)
        
        let exp = expectation(description: "Wait for value")
        
        let cancellable = viewModel.valuePublisher.sink { result in
            XCTAssertEqual(result, "0")
            exp.fulfill()
        }
        
        wait(for: [exp], timeout: 1)
        
        viewModel.set(value: 1)

        let exp1 = expectation(description: "Wait for value")
        
        let cancellable1 = viewModel.valuePublisher.sink { result in
            XCTAssertEqual(result, "1")
            exp1.fulfill()
        }
        
        wait(for: [exp1], timeout: 1)
                
    }
}
