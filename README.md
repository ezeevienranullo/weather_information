🌦️ Weather Information App
A Flutter project that provides real-time and historical weather information,
along with the ability to save personal notes for specific days.

# Getting Started

Note: Please enable location services on your device for the best experience.

Flutter version: 3.7.12
Dart version: 2.19.6

This project uses Stacked Framework utilizing MVVM (Model, View, ViewModel) architecture.
Implemented MVVM (Model-View-ViewModel) architecture to separate business logic from UI components,
resulting in a cleaner and more manageable codebase.
Stacked link -> https://pub.dev/packages/stacked


🌤️ App Features
* Live Weather Data
Get current weather conditions using the OpenWeatherMap API.
🔗 https://openweathermap.org/api

* Weather History
View past weather information by selecting a specific date.

* Notes per Day (Local Storage)
Add and save personal notes for a selected day using SQLite.
Useful for journaling or tracking weather-related events.

🧩 Tech Stack
* Flutter + Dart
* Stacked Framework (MVVM)
* SQLite (sqlite package) for local notes
* OpenWeatherMap API
