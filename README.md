# Swift Sentiment Analysis Engine

![CI](https://github.com/BlissPhinehas/swift-sentiment-engine/actions/workflows/ci.yml/badge.svg)

A command-line Swift package that accepts text, calls the Hugging Face Inference API to run sentiment analysis, parses the result, and returns structured output with a confidence score.

## Features
- Multi-target Swift Package (library core + CLI executable)
- Async/Await REST API calls to Hugging Face
- Full XCTest unit tests
- DocC documentation on every public type
- GitHub Actions CI on every push

## Usage
```bash
export HF_API_TOKEN="your-token-here"
swift run sentiment-cli "I love this project!"
```

## Output
```json
{
  "label": "positive",
  "confidence": 0.9998
}
```

## Requirements
- Swift 6.0+
- Hugging Face Inference API token (free)