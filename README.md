# BaseApp

## Purpose
BaseApp is a Swift-based application designed to provide a robust and scalable architecture for building modern iOS applications. The project aims to streamline the development process by leveraging best practices in software design and architecture.

## Technology Stack
- **Swift**: The primary programming language used for developing the application, taking advantage of its modern features and performance.
- **SwiftUI**: Utilized for building the user interface, allowing for a declarative and reactive approach to UI development.
- **Swift Package Manager**: Used for dependency management, simplifying the integration of third-party libraries and frameworks.
- **The Composable Architecture (TCA)**: A library for building applications in a modular way. It helps manage application state and side effects efficiently.
- **Dependencies**: A library for managing dependencies in a type-safe manner.

### Project Structure
- **/Core**: Contains the central logic and shared components.
- **/Features**: Independent functionality modules.
  - **Feature1**: A mocked feature.
  - **Feature2**: A mocked feature.
  - **Register**: Registration functionality.
  - **Settings**: App configuration.
  - **Welcome**: Welcome screen.
- **/App**: Contains the main app and base configuration.
- **/External**: External dependencies.
- **/AppTests** and **/AppUITests**: Unit and UI tests.

### Design Patterns
- Utilizes the Redux pattern through TCA with:
  - **State**: To manage the application state.
  - **Action**: To define the actions that can occur.
  - **Reducer**: To handle business logic.
- Implements dependency injection using `@Dependency`.

### Testing
- Structure prepared for testing with separation of unit and UI tests.

### Key Features
- Authentication system.
- Navigation system based on paths and tabs.
- Deep link handling.
- Support for push notifications.
- Global state management through TCA Store.

### Technical Features
- Support for Sign in with Apple.
- Application state management (scenePhase).
- Logging system for debugging.
- Architecture prepared for scalability.

## Getting Started
To get started with the project, clone the repository and open it in Xcode. Ensure that you have the necessary dependencies installed via Swift Package Manager.

Add API Client url in `BaseApp/Dependencies/CoreDependencies.swift`

## Contribution
Contributions are welcome! Please feel free to submit a pull request or open an issue for any suggestions or improvements.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
