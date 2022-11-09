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
        let spy = ValueSpy(viewModel.valuePublisher)
                
        XCTAssertEqual(spy.values, ["0"])
        
        viewModel.set(value: 1)
        
        XCTAssertEqual(spy.values, ["0", "1"])

        viewModel.set(value: 2)
        
        XCTAssertEqual(spy.values, ["0", "1", "2"])
    }
}

private class ValueSpy {
    private(set) var values = [String]()
    private var cancellable: AnyCancellable?
    
    init(_ publisher: AnyPublisher<String, Never>) {
        cancellable = publisher.sink { [weak self] value in
            self?.values.append(value)
        }
    }
}
