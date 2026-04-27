import Foundation
import SentimentCore

// Read the API token from environment variables
guard let token = ProcessInfo.processInfo.environment["HF_API_TOKEN"] else {
    print("Error: HF_API_TOKEN environment variable not set.")
    exit(1)
}

// Read the text from command line arguments
guard CommandLine.arguments.count > 1 else {
    print("Usage: sentiment-cli <text>")
    exit(1)
}

let text = CommandLine.arguments.dropFirst().joined(separator: " ")

// Run the analysis
Task {
    do {
        let engine = SentimentEngine(apiToken: token)
        let result = try await engine.analyze(text: text)
        print("{")
        print("  \"label\": \"\(result.label)\",")
        print("  \"confidence\": \(result.confidence)")
        print("}")
    } catch {
        print("Error: \(error)")
        exit(1)
    }
}

// Keep the process alive until the Task finishes
RunLoop.main.run()