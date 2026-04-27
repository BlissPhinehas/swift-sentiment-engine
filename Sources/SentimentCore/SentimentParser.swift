import Foundation

/// Parses the JSON response from the Hugging Face Inference API.
public struct SentimentParser {

    /// Parses raw API response data into a SentimentResult.
    public static func parse(data: Data) throws -> SentimentResult {
        // The API returns an array of arrays: [[{"label": "POSITIVE", "score": 0.9998}]]
        let decoded = try JSONDecoder().decode([[HFResult]].self, from: data)

        guard let first = decoded.first?.first else {
            throw SentimentError.emptyResponse
        }

        return SentimentResult(label: first.label, confidence: first.score)
    }
}

/// A single result item from the Hugging Face API response.
private struct HFResult: Codable {
    let label: String
    let score: Double
}

/// Errors that can occur during sentiment analysis.
public enum SentimentError: Error {
    case emptyResponse
    case invalidResponse
}