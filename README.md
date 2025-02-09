# Crypto Tracker

A Flutter application that displays real-time cryptocurrency data using the CoinGecko API.

![Dark Mode](screenshots/dark_mode.png)
![Light Mode](screenshots/light_mode.png)

## Features Implemented
- Display top 10 cryptocurrencies sorted by market cap
- Pull to refresh functionality
- 7-day price chart for each listed coin
- Theme toggle (light/dark mode)
- Test Coverage (only for the cubit due to time constraints)

## Potential Improvements

- Persist theme preference using shared preferences
- Add searchbar to filter coins
- More robust error handling with different error types
- Add UI tests and golden tests

### Installation

1. Clone the repository
2. Install dependencies:
```shell
flutter pub get
```
3. Generate code:
```shell
flutter pub run build_runner build --delete-conflicting-outputs
```
4. Run the app:
```shell
flutter run
```
