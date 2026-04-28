import XCTest
@testable import SentimentCore

final class SentimentCoreTests: XCTestCase {

    // Test that valid JSON is parsed correctly
    func testParsePositiveResult() throws {
        let json = """
            [[{"label": "positive", "score": 0.9998}]]
            """.data(using: .utf8)!

        let result = try SentimentParser.parse(data: json)

        XCTAssertEqual(result.label, "positive")
        XCTAssertEqual(result.confidence, 0.9998, accuracy: 0.0001)
    }

    // Test that negative sentiment is parsed correctly
    func testParseNegativeResult() throws {
        let json = """
            [[{"label": "negative", "score": 0.8708}]]
            """.data(using: .utf8)!

        let result = try SentimentParser.parse(data: json)

        XCTAssertEqual(result.label, "negative")
        XCTAssertEqual(result.confidence, 0.8708, accuracy: 0.0001)
    }

    // Test that empty response throws the right error
    func testEmptyResponseThrows() throws {
        let json = """
            [[]]
            """.data(using: .utf8)!

        XCTAssertThrowsError(try SentimentParser.parse(data: json)) { error in
            XCTAssertEqual(error as? SentimentError, SentimentError.emptyResponse)
        }
    }

    // Test that invalid JSON throws an error
    func testInvalidJSONThrows() throws {
        let json = "not valid json".data(using: .utf8)!

        XCTAssertThrowsError(try SentimentParser.parse(data: json))
    }

    // Test SentimentResult initializer
    func testSentimentResultInit() {
        let result = SentimentResult(label: "positive", confidence: 0.99)

        XCTAssertEqual(result.label, "positive")
        XCTAssertEqual(result.confidence, 0.99)
    }
}