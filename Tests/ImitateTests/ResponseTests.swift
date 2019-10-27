import XCTest
@testable import Imitate

final class ResponseTests: XCTestCase {

    // MARK: -

    func testInitialization() {
        let response = Response()

        XCTAssertNil(response.status)
        XCTAssertNil(response.body)
        XCTAssertEqual(response.headers.count, 0)
    }

    // MARK: -

    private struct Test: Encodable {
        struct More: Encodable {
            let number: Int
            let string: String
        }
        let more: More
    }

    func testJSONSerialization() {
        let response = Response()
        response.json(Test(more: .init(number: 42, string: "hello")))

        XCTAssertEqual(response.headers.count, 1)
        XCTAssertEqual(response.headers["Content-Type"], "application/json")

        XCTAssertNotNil(response.body)
        XCTAssertEqual(response.body!, """
            {"more":{"number":42,"string":"hello"}}
            """.data(using: .utf8))
    }

    func testSubscript() {
        let response = Response()

        response["test"] = "example"

        XCTAssertEqual(response["test"], "example")
    }

    func testCaseInsensitiveHeaders() {
        let response = Response()

        response.headers["This-Is-Custom-Header"] = "hello"

        XCTAssertEqual(response["this-is-custom-header"], "hello")
        XCTAssertEqual(response["THIS-IS-CUSTOM-HEADER"], "hello")
    }

}
