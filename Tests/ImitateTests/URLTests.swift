import XCTest
@testable import Imitate

final class URLTests: XCTestCase {

    func testFullPath() {
        let url = URL(string: "https://example.org/fullpath")

        XCTAssertNotNil(url)
        XCTAssertEqual(url?.matches("https://example.org/fullpath"), true)
    }

}
