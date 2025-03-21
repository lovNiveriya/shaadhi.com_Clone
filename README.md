Shaadhi.com Clone

Shaadhi.com Clone is an iOS application developed using Swift 6 and Xcode 16.2. The project leverages various technologies and libraries to provide a seamless user experience.

Features

User Profiles: Displays user profiles with images, names, ages, and locations.
Image Loading: Utilizes SDWebImage for asynchronous image downloading and caching.
Data Persistence: Implements Core Data for local data storage and management.
Dependencies

The project incorporates the following dependencies:

SDWebImage: A powerful library for asynchronous image downloading and caching. Integrated using Swift Package Manager (SPM). For more details, visit the SDWebImage GitHub repository.
Important Notes

Image Caching Behavior: SDWebImage caches images by default. However, if you don't scroll through the list, some images may not be cached. Consequently, attempting to use the app offline might result in images not being rendered. To ensure images are cached, it's recommended to scroll through the list while online.​
Core Data Usage: The application employs Core Data for local data storage. This ensures that user data persists between app launches and provides a smooth offline experience for textual data.​
Getting Started

To run the project locally:

Clone the Repository: ```bash git clone https://github.com/yourusername/shaadhi-com-clone.git
Open in Xcode: Navigate to the project directory and open the .xcodeproj file in Xcode 16.2 or later.​
Resolve Dependencies: Ensure that all Swift Package Manager dependencies are resolved.​
Build and Run: Select your target device or simulator and run the project.​
Acknowledgements

SDWebImage: For efficient image downloading and caching solutions.​
For more information on SDWe
