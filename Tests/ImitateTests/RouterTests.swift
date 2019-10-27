import XCTest
@testable import Imitate

final class RouterTests: XCTestCase {

    func testStart() {
        let imitate = MockImitate()
        let router = ChildRouter()

        imitate.register(router)

        XCTAssertEqual(imitate.actions.count, 1)
        XCTAssertEqual(imitate.actions.first, "+ GET /example")
    }

    func testStop() {
        let imitate = MockImitate()
        let router = ChildRouter()

        imitate.unregister(router)

        XCTAssertEqual(imitate.actions.count, 1)
        XCTAssertEqual(imitate.actions.first, "- GET /example")
    }

}

final class ChildRouter: Router {

    func start(with imitate: Imitate) {
        imitate.get("/example") { env in
            // ...
        }
    }

    func stop(with imitate: Imitate) {
        imitate.unmatch(get: "/example")
    }

}
