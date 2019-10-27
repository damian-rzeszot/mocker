import XCTest
@testable import Imitate

final class ImitateTests: XCTestCase {

    func testGetRequest() {
        let imitate = Imitate()
        imitate.get("/test") { _ in }

        XCTAssertNotNil(imitate.find(.get("https://example.org/test")))
    }

    func testPostRequest() {
        let imitate = Imitate()
        imitate.post("/test") { _ in }

        XCTAssertNotNil(imitate.find(.post("https://example.org/test")))
    }

    func testGetRequestUnmatching() {
        let imitate = Imitate()
        imitate.get("/test") { _ in }

        imitate.unmatch(get: "/test")

        XCTAssertNil(imitate.find(.get("https://example.org/test")))
    }

    func testPostRequestUnmatching() {
        let imitate = Imitate()
        imitate.post("/test") { _ in }

        imitate.unmatch(post: "/test")

        XCTAssertNil(imitate.find(.post("https://example.org/test")))
    }

    func testGetMatching() {
        var called = false
        let request = URLRequest.get("https://example.org/test")

        let imitate = Imitate()
        imitate.get("/test") { env in
            called = true
        }

        let env = Environment(request: request)
        let handler = imitate.find(request)

        handler?(env)
        XCTAssertTrue(called)
    }

    func testStrictMatching() {
        let imitate = Imitate()
        imitate.get("https://example.org/v1") { _ in }

        XCTAssertNotNil(imitate.find(.get("https://example.org/v1")))
    }

    func testPatternPartialMatching() {
        let imitate = Imitate()
        imitate.get("/posts/*/details") { _ in }

        XCTAssertNotNil(imitate.find(.get("https://example.org/posts/12345/details")))
    }

    func testPatternFullMatching() {
        let imitate = Imitate()
        imitate.get("https://example.org/posts/*/details") { _ in }

        XCTAssertNotNil(imitate.find(.get("https://example.org/posts/12345/details")))
    }

}

private extension URLRequest {

    static func get(_ url: String) -> URLRequest {
        return URLRequest(url: URL(string: url)!)
    }

    static func post(_ url: String) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        return request
    }

}
