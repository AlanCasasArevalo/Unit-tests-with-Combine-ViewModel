import XCTest
import Combine
class ViewModel: ObservableObject {
    private let valueSubject = CurrentValueSubject<Int, Never>(0)
    
    var valuePublisher: AnyPublisher<String, Never> {
        valueSubject.map { value in
            ""
        }
        .eraseToAnyPublisher()
    }
    
    func set(value: Int) {
        
    }
    
}

final class CombineTests: XCTestCase {
    func test() {
        let viewModel = ViewModel()
        
        XCTAssertNotNil(viewModel)
        XCTAssertTrue(viewModel is (any ObservableObject))
    }
}
