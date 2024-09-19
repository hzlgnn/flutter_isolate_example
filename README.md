# Isolate Example in Flutter

This project demonstrates the use of `Isolate` in Flutter to perform heavy computations without blocking the main thread, ensuring a smooth and responsive UI.

## Features

- **Start with Isolate:** Runs a computationally expensive task on a separate isolate.
- **Start with compute:** Utilizes Flutter's `compute()` function to run the task on a background thread.
- **Start without Isolate:** Executes the task directly on the main thread, showcasing the impact on UI performance.

## Getting Started

1. Clone the repository.
2. Run the app on a device or emulator.
3. Press the buttons to see the different approaches in action.

### Code Explanation

- `computeProductWithIsolate`: Calculates a large product using an isolate.
- `computeProductWithoutIsolate`: Calculates the product directly on the main thread.
- `computeProductWithCompute`: Uses `compute()` to run the calculation in the background.


