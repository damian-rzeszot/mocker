import XCTest
@testable import Imitate

final class ImitateTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Imitate().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
