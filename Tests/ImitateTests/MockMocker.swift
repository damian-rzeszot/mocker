import Foundation
@testable import Imitate

final class MockImitate: Imitate {

    // MARK: -

    var handler: ((Environment) -> Void)?

    override func find(_ request: URLRequest) -> Imitate.Handler? {
        return handler
    }

    // MARK: -

    private(set) var actions: [String] = []

    func reset() {
        actions = []
    }

    // MARK: -

    override func get(_ string: String, with handler: @escaping Imitate.Handler) {
        actions.append("+ GET \(string)")
    }

    override func unmatch(get string: String) {
        actions.append("- GET \(string)")
    }

}
