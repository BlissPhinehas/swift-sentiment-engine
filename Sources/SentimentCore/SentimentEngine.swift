import Foundation

/// The main entry point for performing sentiment analysis.
public struct SentimentEngine {

    private let client: HuggingFaceClient

    /// Creates a new SentimentEngine with your Hugging Face API token.
    public init(apiToken: String) {
        self.client = HuggingFaceClient(apiToken: apiToken)
    }

    /// Analyzes the sentiment of the given text.
    /// - Parameter text: The text to analyze.
    /// - Returns: A SentimentResult containing the label and confidence score.
    public func analyze(text: String) async throws -> SentimentResult {
        return try await client.analyze(text: text)
    }
}