/// The result of a sentiment analysis operation.
public struct SentimentResult {

    /// The sentiment label, e.g. "POSITIVE" or "NEGATIVE".
    public let label: String

    /// The confidence score between 0.0 and 1.0.
    public let confidence: Double

    /// Creates a new SentimentResult.
    public init(label: String, confidence: Double) {
        self.label = label
        self.confidence = confidence
    }
}