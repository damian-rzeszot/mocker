import XCTest
@testable import Imitate

final class ImitateURLProtocolTests: XCTestCase {

    func testInstance() {
        let imitate = MockImitate()
        ImitateURLProtocol.imitate = imitate

        let proto = ImitateURLProtocol(request: .example, cachedResponse: nil, client: nil)

        XCTAssertTrue(proto.imitate === imitate)
        XCTAssertTrue(ImitateURLProtocol.imitate === imitate)
    }

    func testCanInit() {
        let imitate = MockImitate()
        ImitateURLProtocol.imitate = imitate

        imitate.handler = { _ in }
        XCTAssertTrue(ImitateURLProtocol.canInit(with: .example))

        imitate.handler = nil
        XCTAssertFalse(ImitateURLProtocol.canInit(with: .example))
    }

    func testCannonicalRequest() {
        let input = URLRequest.example

        let request = ImitateURLProtocol.canonicalRequest(for: input)

        XCTAssertNotNil(request.url)
        XCTAssertEqual(request.url?.absoluteString, input.url?.absoluteString)
    }



    func testStartLoading() {
        // given
        let client = MockClient()
        let imitate = MockImitate()
        let proto = ImitateURLProtocol(request: .example, cachedResponse: nil, client: client)
        ImitateURLProtocol.imitate = imitate


        let exp = expectation(description: "")
        imitate.handler = { env in
            env.response.status = 123
            env.response.headers["Hello"] = "World"
            env.response.body = "test hello".data(using: .utf8)
            exp.fulfill()
        }

        // when
        proto.startLoading()

        wait(for: [exp], timeout: 1)

        XCTAssertTrue(client.finished)

        XCTAssertNotNil(client.data)
        XCTAssertEqual(String(data: client.data!, encoding: .utf8), "test hello")

        XCTAssertNotNil(client.response)
        XCTAssertEqual(client.response?.statusCode, 123)

        XCTAssertEqual(client.response?.allHeaderFields["hello"] as? String, "World")
    }

    func testStopLoading() {
        let client = MockClient()
        let imitate = MockImitate()
        let proto = ImitateURLProtocol(request: .example, cachedResponse: nil, client: client)
        ImitateURLProtocol.imitate = imitate

        proto.stopLoading()
    }

    func testStartLoadingWithDelay() {
        // given
        let client = MockClient()
        let imitate = MockImitate()
        let proto = ImitateURLProtocol(request: .example, cachedResponse: nil, client: client)
        ImitateURLProtocol.imitate = imitate

        let responding = expectation(description: "")
        client.expectation = responding


        let handling = expectation(description: "")
        imitate.handler = { env in
            env.delay = 0.2
            handling.fulfill()
        }

        // when
        proto.startLoading()

        wait(for: [handling], timeout: 0.1)

        XCTAssertFalse(client.finished)

        wait(for: [responding], timeout: 0.3)

        XCTAssertTrue(client.finished)
        XCTAssertNotNil(client.response)
        XCTAssertEqual(client.response?.statusCode, 200)
    }

}

private extension URLRequest {

    static var example: URLRequest {
        return URLRequest(url: URL(string: "https://example.org/")!)
    }

}

private class MockClient: NSObject, URLProtocolClient {

    var response: HTTPURLResponse?
    var data: Data?
    var finished = false

    var expectation: XCTestExpectation?

    // MARK: -

    func urlProtocol(_ protocol: URLProtocol, didReceive response: URLResponse, cacheStoragePolicy policy: URLCache.StoragePolicy) {
        self.response = response as? HTTPURLResponse
    }

    func urlProtocol(_ protocol: URLProtocol, didLoad data: Data) {
        self.data = data
    }

    func urlProtocolDidFinishLoading(_ protocol: URLProtocol) {
        self.finished = true
        self.expectation?.fulfill()
    }

    // MARK: -

    func urlProtocol(_ protocol: URLProtocol, wasRedirectedTo request: URLRequest, redirectResponse: URLResponse) {

    }

    func urlProtocol(_ protocol: URLProtocol, cachedResponseIsValid cachedResponse: CachedURLResponse) {

    }

    func urlProtocol(_ protocol: URLProtocol, didFailWithError error: Error) {

    }

    func urlProtocol(_ protocol: URLProtocol, didReceive challenge: URLAuthenticationChallenge) {

    }

    func urlProtocol(_ protocol: URLProtocol, didCancel challenge: URLAuthenticationChallenge) {

    }

}
