# Flutter Weather App (Clean Architecture)

A simple **Flutter Weather Forecast App** that fetches real-time weather data from the [OpenWeather API](https://openweathermap.org/api).  
The project demonstrates **Clean Architecture**, **SOLID principles**, and **state management with Riverpod**.

---

## ✨ Features
- Search for weather by city.
- Display current temperature, description, and weather icon.
- Show loading & error states.
- Repository pattern for clean data separation.
- Extensible architecture (easy to add forecast, dark mode, etc.).
- Uses **Dio** for API calls and **Riverpod** for state management.

---

## 🏗️ Project Structure

```
lib/
├── core/
│   └── env.dart              # API Key configuration
├── data/
│   ├── api_service.dart      # Handles API calls
│   └── repositories/
│       └── weather_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── weather.dart      # Weather Entity
│   └── repositories/
│       └── iweather_repository.dart
├── presentation/
│   └── state/
│       └── weather_notifier.dart
└── main.dart                 # App entry point (UI)
```

- **Domain Layer**: Contains pure business logic (Entities, Repository Interfaces).
- **Data Layer**: Contains API service + repository implementations (fetching and mapping data).
- **Presentation Layer**: Handles UI and state management with Riverpod.
- **Core**: Holds environment configs and shared utilities.

---

## ⚙️ Setup Instructions

1. **Clone the repository**  
   ```bash
   git clone https://github.com/YOUR_USERNAME/weather_clean_arch.git
   cd weather_clean_arch
   ```

2. **Get dependencies**  
   ```bash
   flutter pub get
   ```

3. **Add OpenWeather API Key**  
   - Open `lib/core/env.dart`
   - Replace:
     ```dart
     const String apiKey = "YOUR_API_KEY_HERE";
     ```
     with your real key from [OpenWeather API](https://home.openweathermap.org/api_keys).

4. **Run the app**  
   ```bash
   flutter run
   ```

---

## 📡 API Endpoints Used

- Current Weather:  
  ```
  https://api.openweathermap.org/data/2.5/weather?q={CITY}&appid={API_KEY}&units=metric
  ```

- Forecast (3-hour, 5-day):  
  ```
  https://api.openweathermap.org/data/2.5/forecast?q={CITY}&appid={API_KEY}&units=metric
  ```

---

## 🧩 State Management

- **Riverpod** is used for state management.
- `WeatherNotifier` extends `StateNotifier` and manages the state:
  - `loading` while fetching
  - `data` when success
  - `error` if API fails or city not found

---

## ✅ Evaluation Criteria
- Proper use of **Clean Architecture**.
- **SOLID principles** applied:
  - **S**ingle Responsibility → Entity, Repository, UseCase, UI all separate.
  - **O**pen/Closed → Easy to extend (e.g., add forecast API).
  - **L**iskov → Interfaces can be replaced with implementations.
  - **I**nterface Segregation → Repository interface only defines `getWeatherByCity`.
  - **D**ependency Inversion → UI depends on abstractions (`IWeatherRepository`).
- Code readability & maintainability.
- User-friendly UI.

---

## 📸 Screenshots

- <img width="360" height="756" alt="لقطة شاشة 2025-09-06 165111" src="https://github.com/user-attachments/assets/7eb4bfbd-70c8-430f-ac36-e5af5a13d1df" />

- <img width="361" height="763" alt="لقطة شاشة 2025-09-06 165136" src="https://github.com/user-attachments/assets/d9434901-c38b-483d-bedb-53274fd48228" />

- <img width="357" height="752" alt="لقطة شاشة 2025-09-06 165858" src="https://github.com/user-attachments/assets/83fdf86c-fd8d-4c46-9565-4c01451ff4b7" />

---

## 🚀 Bonus Ideas
- Save last searched city in `shared_preferences`.
- Add dark mode support.
- Show **3-day forecast** with extra API call.

