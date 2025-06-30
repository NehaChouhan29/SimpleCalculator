import XCTest
@testable import StringCalculatorApp

final class StringCalculatorTests: XCTestCase {
    var calculator: StringCalculator!

    override func setUp() {
        calculator = StringCalculator()
    }

    func testEmptyStringReturnsZero() throws {
        XCTAssertEqual(try calculator.add(""), 0)
    }

    func testSingleNumberReturnsItself() throws {
        XCTAssertEqual(try calculator.add("1"), 1)
    }

    func testTwoNumbersCommaSeparated() throws {
        XCTAssertEqual(try calculator.add("1,2"), 3)
    }

    func testMultipleNumbersWithNewLine() throws {
        XCTAssertEqual(try calculator.add("1\n2,3"), 6)
    }

    func testCustomDelimiter() throws {
        XCTAssertEqual(try calculator.add("//;\n1;2"), 3)
    }

    func testNegativeNumberThrowsError() {
        XCTAssertThrowsError(try calculator.add("1,-2,3")) { error in
            XCTAssertEqual(error.localizedDescription, "negative numbers not allowed: -2")
        }
    }

    func testMultipleNegatives() {
        XCTAssertThrowsError(try calculator.add("1,-2,-3,4")) { error in
            XCTAssertEqual(error.localizedDescription, "negative numbers not allowed: -2,-3")
        }
    }
}
