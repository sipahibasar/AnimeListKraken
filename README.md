KrakenAnimeList App

This Flutter application showcases a list of top anime and provides detailed information about each anime. The project follows Clean Architecture principles and utilizes the following technologies: Chopper, Bloc, and GetIt with Injectable for dependency injection.

Features

Anime List Page:
Displays at least 20 anime with pagination.
Shows anime images, titles, and rating scores.
Anime Detail Page:
Displays the anime's image, title, rating score, genres, synopsis, episodes count, and a list of characters with their images and names.
Architecture

The project adheres to Clean Architecture, ensuring a clear separation of concerns:

Domain: Contains the business logic, including entities repositories and use cases.
Data: Responsible for data retrieval and mapping between data models and domain models. This layer uses Chopper for network requests.
Presentation: Manages UI logic using Bloc for state management and provides pages and widgets.
API Endpoints

The application interacts with the following API endpoints from the Jikan API:

Top Anime: https://api.jikan.moe/v4/top/anime
Anime Details and Characters: https://api.jikan.moe/v4/anime/{id}/characters
Dependency Injection

The project uses GetIt and Injectable to manage dependency injection. This approach ensures that dependencies are easily configurable and replaceable, promoting testability and flexibility.

Testing

The project includes comprehensive testing across multiple layers:

Unit Tests: Validate individual components like use cases and repositories.
Widget Tests: Ensure the correctness of individual widgets, including UI components.
Integration Tests: Verify the overall functionality and flow of the application.
Mocks are used extensively to isolate tests and ensure they are reliable and fast.# AnimeListKraken
