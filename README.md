# The Rick Sanchez Universe

## Overview

The Rick Sanchez Universe is an iOS application that displays a list of characters from the Rick and Morty universe. The application fetches character data from a network API and displays it in a table view. Each character cell includes an image, name, and species. Images are loaded asynchronously and cached to improve performance and reduce redundant network requests.

## Features

- Display a list of characters with their images, names, and species.
- Asynchronous image loading.
- Image caching to reduce redundant network requests and improve performance.

## Requirements

- Xcode 12.0 or later
- Swift 5.0 or later
- iOS 13.0 or later

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/thericksanchezuniverse.git
   cd thericksanchezuniverse
   ```

2. Open the Xcode project:
   ```bash
   open TheRickSanchezUniverse.xcodeproj
   ```

3. Build and run the project using Xcode:
   - Select your target device or simulator.
   - Click on the "Run" button or press `Cmd + R`.

## Assumptions and Decisions

- **Design**: The design follows the prototype guideline but is not exactly a copy of it. Due to time constraints and lack of debuggable design ie. (Figma, Sketch) the design implemented might have slight discrepancies with the prototype. eg, spacing, corner radius.. etc.
- **No Storyboards**: The application is built programmatically without the use of storyboards to provide more control over the view hierarchy and transitions.
- **SwiftUI Integration**: SwiftUI is used for defining the `CharacterCell` view, providing a modern and declarative way to build UI components.
- **Image Caching**: Implemented a simple in-memory cache using `NSCache` to store downloaded images, improving performance by avoiding redundant network requests.
- **Network Calls**: Assumed a reliable network connection for fetching character data and images. No offline capabilities are included in this version.
- **Dependency Management**: No external dependencies or package managers (e.g., CocoaPods, Carthage, Swift Package Manager) are used.

## Challenges and Solutions

### Challenge 1: Integrating SwiftUI with UIKit

- **Problem**: Integrating SwiftUI views within a `UITableViewCell` presented challenges in ensuring the SwiftUI views correctly resize and layout within the cell.
- **Solution**: Used `UIHostingController` to embed SwiftUI views in UIKit. Properly set up constraints to ensure the SwiftUI view stretches to fill the cell.

### Challenge 2: Reusing Table View Cells

- **Problem**: `UITableView` cells were displaying incorrect or mixed-up images when scrolled quickly.
- **Solution**: Implemented a custom `UITableViewCell` that updates its content correctly upon reuse. Ensured the `character` property of the cell is reset properly in `cellForRowAt`.

### Challenge 3: Asynchronous Image Loading

- **Problem**: Loading images asynchronously can cause delays and potential flickering if not handled correctly.
- **Solution**: Created an `AsyncImageView` using `Combine` to handle asynchronous image loading. Cached images using `NSCache` to prevent redundant network requests and reduce flickering.

### Challenge 4: Memory Management with Image Caching

- **Problem**: Managing memory effectively while caching images is crucial to prevent memory leaks and excessive memory usage.
- **Solution**: Utilized `NSCache` for its automatic eviction policies, which help manage memory under pressure. This ensures the cache does not grow indefinitely and consumes excessive memory.

## Contact

For any questions or issues, please contact:

- Ahmed Abdelfattah
- Email: ahmedmuslimani609@gmail.com
- GitHub: [AhmedAElfattah](https://github.com/AhmedAElfattah)

---

Thank you for using The Rick Sanchez Universe! Hope you enjoy exploring the characters from the Rick and Morty universe.
