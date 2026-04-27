// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SentimentEngine",
    products: [
        .library(
            name: "SentimentCore",
            targets: ["SentimentCore"]
        ),
        .executable(
            name: "sentiment-cli",
            targets: ["sentiment-cli"]
        )
    ],
    targets: [
        .target(
            name: "SentimentCore"
        ),
        .executableTarget(
            name: "sentiment-cli",
            dependencies: ["SentimentCore"]
        ),
        .testTarget(
            name: "SentimentCoreTests",
            dependencies: ["SentimentCore"]
        )
    ]
)
