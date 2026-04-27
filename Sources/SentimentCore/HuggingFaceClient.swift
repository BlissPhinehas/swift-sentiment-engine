import Foundation
import FoundationNetworking

/// Handles communication with the Hugging Face Inference API.
public struct HuggingFaceClient {

    private let apiToken: String
    private let modelURL = URL(
        string:
            "https://api-inference.huggingface.co/models/distilbert-base-uncased-finetuned-sst-2-english"
    )!

    /// Creates a new client with your Hugging Face API token.
    public init(apiToken: String) {
        self.apiToken = apiToken
    }

    /// Sends text to the API and returns the raw sentiment data.
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