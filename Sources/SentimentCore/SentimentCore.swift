/// The result of a sentiment analysis operation.
///
/// Contains the predicted sentiment label and the model's
/// confidence score for that prediction.
public struct SentimentResult {

    /// The sentiment label returned by the model.
    ///
    /// Common values include `"positive"`, `"negative"`, and `"neutral"`.
    public let label: String

    /// The model's confidence in its prediction, between `0.0` and `1.0`.
    ///
    /// A value closer to `1.0` indicates higher confidence.
    public let confidence: Double

    /// Creates a new `SentimentResult`.
    /// - Parameters:
    ///   - label: The sentiment label, e.g. `"positive"`.
    ///   - confidence: The confidence score between `0.0` and `1.0`.
    public init(label: String, confidence: Double) {
        self.label = label
        self.confidence = confidence
    }
}