import Foundation

/// Parses the JSON response from the Hugging Face Inference API.
///
/// The API returns a nested array of results. `SentimentParser`
/// extracts the top result and converts it into a ``SentimentResult``.
public struct SentimentParser {

    /// Parses raw API response data into a ``SentimentResult``.
    /// - Parameter data: The raw JSON data returned by the API.
    /// - Returns: A ``SentimentResult`` with the top label and confidence score.
    /// - Throws: ``SentimentError/emptyResponse`` if no results are found,
    ///           or a `DecodingError` if the JSON is malformed.
    public static func parse(data: Data) throws -> SentimentResult {
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

    /// The API returned an empty response with no results.
    case emptyResponse

    /// The API returned a response in an unexpected format.
    case invalidResponse
}