import Foundation

/// The main entry point for performing sentiment analysis.
///
/// `SentimentEngine` connects to the Hugging Face Inference API
/// and returns a ``SentimentResult`` for any given text input.
///
/// ## Example
/// ```swift
/// let engine = SentimentEngine(apiToken: "your-token")
/// let result = try await engine.analyze(text: "I love this!")
/// print(result.label)      // "positive"
/// print(result.confidence) // 0.9998
/// ```
public struct SentimentEngine {

    private let client: HuggingFaceClient

    /// Creates a new `SentimentEngine` with your Hugging Face API token.
    /// - Parameter apiToken: Your Hugging Face Inference API token.
    public init(apiToken: String) {
        self.client = HuggingFaceClient(apiToken: apiToken)
    }

    /// Analyzes the sentiment of the given text.
    /// - Parameter text: The text to analyze.
    /// - Returns: A ``SentimentResult`` containing the label and confidence score.
    /// - Throws: ``SentimentError`` if the API call fails or returns unexpected data.
    public func analyze(text: String) async throws -> SentimentResult {
        return try await client.analyze(text: text)
    }
}