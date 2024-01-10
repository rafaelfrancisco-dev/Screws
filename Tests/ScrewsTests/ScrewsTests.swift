import XCTest
@testable import Screws

final class ScrewsTests: XCTestCase {
    func testExample() throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
    }
    
    func testChunkedArray() throws {
        let initialArray = [1,2,3,4,5,6,7,8,9,0]
        let chunked = initialArray.chunked(into: 3)
        
        assert(chunked.count == 4)
        assert(chunked.first!.count == 3)
    }
}
