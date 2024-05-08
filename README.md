![Screenshot 2024-05-08 at 10 40 54](https://github.com/yamkovyy/MVVM-C/assets/6614977/bb1b3d46-f980-4c8c-9f94-0bef9e9b2b7a)
This iOS application adheres to the MVVM+C architectural pattern, leveraging the robust Combine framework by Apple. However, it's essential to acknowledge that while this example demonstrates the pattern, it offers only a partial view of the high-level design, as certain critical layers are omitted, potentially for brevity. Additionally, the absence of test coverage is noted, though this can be addressed in future iterations.

The app features a primary screen displaying a list of countries alongside their respective capitals, sourced from a remote server via a REST API. The user interface is constructed using UITableViewDiffableDataSource. Furthermore, a search functionality is incorporated to enable users to query countries easily.

<img src="https://github.com/yamkovyy/MVVM-C/assets/6614977/98dc1788-16db-4c15-b4ba-5ee9ee9b7f59" width="200">

An important aspect of this project is the deliberate avoidance of singletons, enhancing encapsulation and promoting independence among code blocks. Leveraging Swift's protocol-oriented nature, the implementation is structured around protocols to adhere to best practices.

Key responsibilities within the application are divided among several components:

- **AppCoordinator**: Serving as the primary app coordinator, responsible for managing app navigation and facilitating the display of required feature coordinators based on contextual needs.
- **CountriesListCoordinator**: A feature coordinator dedicated to navigating within a specific feature set.
- **FetchCountriesUseCase**: Handles network calls, specifically responsible for fetching countries data.
- **CountriesListViewModel**: Encompasses all business logic pertinent to the implementation, orchestrating interactions between various components to ensure seamless functionality.

