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

    func testChunkedArraySizeOne() throws {
        let initialArray = [1,2,3]
        let chunked = initialArray.chunked(into: 1)

        XCTAssertEqual(chunked.count, 3)
        XCTAssertEqual(chunked[0], [1])
        XCTAssertEqual(chunked[1], [2])
        XCTAssertEqual(chunked[2], [3])
    }

    func testChunkedArraySizeLargerThanCount() throws {
        let initialArray = [1,2,3]
        let chunked = initialArray.chunked(into: 10)

        XCTAssertEqual(chunked.count, 1)
        XCTAssertEqual(chunked.first ?? [], [1,2,3])
    }

    func testArrayDiffDropsDuplicates() throws {
        let array1 = [1,1,2]
        let array2 = [2]

        let diff = array1.difference(from: array2)

        XCTAssertEqual(Set(diff), Set([1]))
    }
    
    func testDates() throws {
        let date = Date.dateFromDayAndMonth(day: 1, month: 12)
        let dayMonth = date?.get(.day, .month)
        
        assert(dayMonth != nil)
        assert(dayMonth!.day == 1 && dayMonth!.month == 12)
        
        assert(date?.getDayInYear() == 336)
    }
    
    func testMonths() throws {
        let months = Date.months()
        
        assert(months != nil)
        assert(months?.count == 12)
    }

    func testDateFromInvalidDayMonthNormalizesToValidDate() throws {
        let date = Date.dateFromDayAndMonth(day: 31, month: 2)

        XCTAssertNotNil(date)
        XCTAssertEqual(date?.get(.year), 2000)
        XCTAssertEqual(date?.get(.month), 3)
        XCTAssertEqual(date?.get(.day), 2)
    }

    func testDateGetSingleComponent() throws {
        let date = Date.dateFromDayAndMonth(day: 1, month: 12)

        XCTAssertEqual(date?.get(.day), 1)
        XCTAssertEqual(date?.get(.month), 12)
        XCTAssertEqual(date?.get(.year), 2000)
    }
    
    func testDouble() throws {
        let doubleTest = 2.13232434
        let formattedString = doubleTest.format(f: 0.2)
        
        assert(formattedString == "2.13")
    }

    func testDoubleRoundedToPlaces() throws {
        let positive = 1.2345
        let negative = -1.2345

        XCTAssertEqual(positive.rounded(toPlaces: 2), 1.23)
        XCTAssertEqual(negative.rounded(toPlaces: 2), -1.23)
        XCTAssertEqual(positive.rounded(toPlaces: 0), 1.0)
    }
    
    func testNumbers() throws {
        let testNumber = 1.2
        
        let whole = testNumber.whole
        let fraction = testNumber.fraction.rounded(toPlaces: 2)
        
        assert(whole == 1)
        assert(fraction == 0.2)
    }

    func testNumbersNegativeFraction() throws {
        let testNumber = -1.25

        let whole = testNumber.whole
        let fraction = testNumber.fraction.rounded(toPlaces: 2)

        assert(whole == -1)
        assert(fraction == -0.25)
    }
    
    @available(watchOS 9.0.0, *)
    @available(iOS 16.0.0, *)
    @available(macOS 10.15, *)
    @available(tvOS 16.0.0, *)
    func testTasks() async throws {
        let clock = ContinuousClock()
        
        let result = try await clock.measure {
            try await Task.sleep(seconds: 1)
        }
        
        assert(result.components.seconds >= 1)
    }

    @available(watchOS 6.0, *)
    @available(iOS 13.0, *)
    @available(tvOS 13.0, *)
    @available(macOS 10.15, *)
    func testTaskSleepFractionalSeconds() async throws {
        try await Task.sleep(seconds: 0.05)
        XCTAssertTrue(true)
    }

    @available(iOS 16.0, *)
    @available(macOS 13.0, *)
    @available(tvOS 16.0, *)
    @available(watchOS 9.0, *)
    @available(visionOS 1.0, *)
    func testTaskTimeoutCompletesBeforeDeadline() async throws {
        let task = Task<Int, Error>(timeout: .milliseconds(200)) {
            try await Task.sleep(nanoseconds: 20_000_000)
            return 42
        }

        let value = try await task.value
        XCTAssertEqual(value, 42)
    }

    @available(iOS 16.0, *)
    @available(macOS 13.0, *)
    @available(tvOS 16.0, *)
    @available(watchOS 9.0, *)
    @available(visionOS 1.0, *)
    func testTaskTimeoutThrowsOnDeadline() async throws {
        let timeout = Duration.milliseconds(50)
        let task: Task<String, Error> = Task.withTimeout(duration: timeout) {
            try await Task.sleep(nanoseconds: 200_000_000)
            return "late"
        }

        do {
            _ = try await task.value
            XCTFail("Expected timeout error")
        } catch let error as TaskTimeoutError {
            switch error {
            case .timeout(let duration):
                XCTAssertEqual(duration, timeout)
            }
        } catch {
            XCTFail("Unexpected error: \\(error)")
        }
    }

    @available(iOS 16.0, *)
    @available(macOS 13.0, *)
    @available(tvOS 16.0, *)
    @available(watchOS 9.0, *)
    @available(visionOS 1.0, *)
    func testWithTimeoutAwaitingValue() async throws {
        let value = try await Task.withTimeout(duration: .milliseconds(200)) {
            try await Task.sleep(nanoseconds: 20_000_000)
            return 7
        }

        XCTAssertEqual(value, 7)
    }

    func testTaskTimeoutCancelsOperation() async throws {
        let cancelled = expectation(description: "operation cancelled")
        let timeout = Duration.milliseconds(50)

        do {
            _ = try await Task.withTimeout(duration: timeout) {
                try await withTaskCancellationHandler(operation: {
                    try await Task.sleep(nanoseconds: 200_000_000)
                    return 1
                }, onCancel: {
                    cancelled.fulfill()
                })
            }
            XCTFail("Expected timeout error")
        } catch _ as TaskTimeoutError {
            // expected
        } catch {
            XCTFail("Unexpected error: \(error)")
        }

        await fulfillment(of: [cancelled], timeout: 1.0)
    }

    func testSkipEncodeDecodesWrappedValue() throws {
        struct Payload: Codable {
            var id: Int
            @SkipEncode var secret: String
        }

        let data = Data(#"{"id":1,"secret":"token"}"#.utf8)
        let payload = try JSONDecoder().decode(Payload.self, from: data)

        XCTAssertEqual(payload.id, 1)
        XCTAssertEqual(payload.secret, "token")
    }

    func testSkipEncodeSkipsEncoding() throws {
        struct Payload: Codable {
            var id: Int
            @SkipEncode var secret: String
        }

        let payload = Payload(id: 1, secret: "token")
        let data = try JSONEncoder().encode(payload)
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
        let json = jsonObject as? [String: Any]

        XCTAssertEqual(json?["id"] as? Int, 1)
        XCTAssertNil(json?["secret"])
    }
    
#if os(macOS)
    @available(macOS 10.15, *)
    func testScreenSizes() async throws {
        let width = await Convenience.deviceWidth
        let height = await Convenience.deviceHeight
        
        assert(width != nil && width ?? 0 > 0)
        assert(height != nil && height ?? 0 > 0)
    }
#else
    @available(watchOS 9.0.0, *)
    @available(iOS 16.0.0, *)
    @available(tvOS 16.0.0, *)
    func testScreenSizes() async throws {
        let width = Convenience.deviceWidth
        let height = Convenience.deviceHeight
        
        assert(width > 0)
        assert(height > 0)
    }
#endif
}
