import XCTest
import ImitateTests

var tests = [XCTestCaseEntry]()

tests += Environment.allTests()

XCTMain(tests)
