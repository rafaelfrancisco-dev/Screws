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
    
    func testArrayDiff() throws {
        let array1 = [1,2,3]
        let array2 = [2,3,4]
        
        let diff = array1.difference(from: array2)
        
        assert(diff.contains(1) && diff.contains(4))
    }
    
    func testDates() throws {
        let date = Date.dateFromDayAndMonth(day: 1, month: 12)
        let dayMonth = date?.get(.day, .month)
        
        assert(dayMonth != nil)
        assert(dayMonth!.day == 1 && dayMonth!.month == 12)
        
        assert(date?.getDayInYear() == 336)
    }
    
    func testDouble() throws {
        let doubleTest = 2.13232434
        let formattedString = doubleTest.format(f: 0.2)
        
        assert(formattedString == "2.13")
    }
}
