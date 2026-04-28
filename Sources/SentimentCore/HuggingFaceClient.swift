import Foundation
import FoundationNetworking

/// Handles communication with the Hugging Face Inference API.
///
/// Uses `async/await` and `URLSession` to send text to a hosted
/// sentiment analysis model and return the parsed result.
public struct HuggingFaceClient {

    private let apiToken: String
    private let modelURL = URL(
        string: "https://router.huggingface.co/hf-inference/models/ProsusAI/finbert")!

    /// Creates a new client with your Hugging Face API token.
    /// - Parameter apiToken: Your Hugging Face Inference API token.
    public init(apiToken: String) {
        self.apiToken = apiToken
    }

    /// Sends text to the Hugging Face API and returns a ``SentimentResult``.
    /// - Parameter text: The text to analyze.
    /// - Returns: A ``SentimentResult`` with the top label and confidence score.
    /// - Throws: A `URLError` if the network request fails, or a
    ///           `DecodingError` if the response cannot be parsed.
    public func analyze(text: String) async throws -> SentimentResult {
        var request = URLRequest(url: modelURL)
        request.httpMethod = "POST"
        request.setValue("Bearer \(apiToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ["inputs": text]
        request.httpBody = try JSONEncoder().encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)

        return try SentimentParser.parse(data: data)
    }
}