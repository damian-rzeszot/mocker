import XCTest
@testable import Imitate

final class EnvironmentTests: XCTestCase {

    func testInitialization() {
        let request = URLRequest(url: URL(string: "https://example.org/env")!)
        let env = Environment(request: request)

        XCTAssertNil(env.delay)
        XCTAssertEqual(env.request.url.absoluteString, "https://example.org/env")
        XCTAssertNil(env.request.body)
        XCTAssertNil(env.response.status)
        XCTAssertEqual(env.response.headers.count, 0)
        XCTAssertNil(env.response.body)
    }

//    func testLoadFromFileSuccess() {
//        let request = URLRequest(url: URL(string: "https://example.org/env")!)
//        let env = Environment(request: request)
//
//        env.load(from: "custom-response.json", in: Bundle(for: EnvironmentTests.self))
//
//        XCTAssertEqual(env.response.status, 200)
//
//        XCTAssertEqual(env.delay, 0.3)
//
//        XCTAssertEqual(env.response.headers["location"], "https://example.org/")
//        XCTAssertEqual(env.response.headers["authorization"], "bearer 12345")
//        XCTAssertEqual(env.response.headers["custom-header"], "custom-value")
//
//        XCTAssertNotNil(env.response.body)
//        XCTAssertEqual(env.response.body, "this is body\n".data(using: .utf8))
//    }

    static var allTests = [
        ("testInitialization", testInitialization),
        ("testLoadFromFileSuccess", testLoadFromFileSuccess),
    ]
}
