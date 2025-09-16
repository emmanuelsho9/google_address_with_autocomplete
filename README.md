
# google_address_with_autocomplete

A **Flutter package** that provides a customizable `TextField` with **Google Places Autocomplete** integration.  
Users can input an address, see suggestions, and retrieve the selected address's **formatted address**, **latitude**, and **longitude**.  

The package uses the [`http`](https://pub.dev/packages/http) package for API calls and requires a **Google API Key**.  
Includes robust error handling for API issues.

---

## ✨ Features
- Customizable `TextField` with options for hint, style, and validation.
- Google Places Autocomplete for address suggestions.
- Returns formatted address, latitude, and longitude on selection.
- Debounced search to optimize API calls.
- Customizable loading indicator.
- Fully customizable suggestion list items via `suggestionItemBuilder`.
- Error handling with `onError` callback and optional UI display for errors  
  *(e.g., invalid API key, quota exceeded)*.
- Support for displaying full description or structured formatting in suggestions.
- Lightweight with minimal dependencies.

---

## 📸 Screenshots
![Autocomplete Example](https://asset.cloudinary.com/ducx7nije/5ef7bd5d4ee1a8c424e2c63569f32473)  
*Screenshot of the autocomplete widget in action, showing address suggestions.*

---

## ⚙️ Installation
Add the package to your **`pubspec.yaml`**:
```yaml
dependencies:
  google_address_with_autocomplete: ^0.0.1
````

Run:

```bash
flutter pub get
```

---

## 🔑 Setup

1. Get a **Google API Key**:

   * Enable the **Google Places API** in your [Google Cloud Console](https://console.cloud.google.com/).
   * Ensure **billing is enabled** (required for Places API).

2. Add the API Key:
   Pass your API key to the widget.

---

## 🚀 Usage

Import the package:

```dart
import 'package:google_address_with_autocomplete/google_address_with_autocomplete.dart';
```

Use the widget in your app:

```dart
GoogleAddressAutocomplete(
  apiKey: 'YOUR_GOOGLE_API_KEY',
  hintText: 'Enter location',
  useDescription: true, // Use full description in suggestions
  onAddressSelected: (address) {
    print('Selected address: ${address.formattedAddress}');
    print('Latitude: ${address.latitude}, Longitude: ${address.longitude}');
  },
  onError: (context, error) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(error)),
    );
  },
),
```

---

## 🔧 Parameters

| Parameter               | Type              | Description                                                                   | Default                     |
| ----------------------- | ----------------- | ----------------------------------------------------------------------------- | --------------------------- |
| `apiKey`                | `String`          | Your **Google Places API key** *(required)*                                   | —                           |
| `hintText`              | `String`          | Placeholder text for the `TextField`                                          | —                           |
| `textStyle`             | `TextStyle`       | Style for the `TextField` text                                                | —                           |
| `hintStyle`             | `TextStyle`       | Style for the hint text                                                       | —                           |
| `inputDecoration`       | `InputDecoration` | Custom decoration for the `TextField`                                         | —                           |
| `loadingWidget`         | `Widget`          | Custom loading widget                                                         | `CircularProgressIndicator` |
| `suggestionsHeight`     | `double`          | Height of the suggestions list                                                | `150.0`                     |
| `suggestionItemBuilder` | `Widget Function` | Custom builder for suggestion items (receives context, prediction, and onTap) | —                           |
| `useDescription`        | `bool`            | Display full description in suggestions                                       | `false`                     |
| `onAddressSelected`     | `Function`        | Callback returning address details *(formattedAddress, lat, lng)*             | —                           |
| `onError`               | `Function`        | Callback for handling errors *(receives context and error message)*           | —                           |
| `showErrorInUI`         | `bool`            | Whether to display errors below the `TextField`                               | `true`                      |

---

## 📖 Example

```dart
import 'package:flutter/material.dart';
import 'package:google_address_with_autocomplete/google_address_with_autocomplete.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Address Autocomplete')),
        body: Builder(
          builder: (context) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: GoogleAddressAutocomplete(
              apiKey: 'YOUR_GOOGLE_API_KEY',
              hintText: 'Search for an address',
              useDescription: true,
              loadingWidget: const LinearProgressIndicator(),
              suggestionItemBuilder: (context, prediction, onTap) {
                return ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text(prediction.description ?? ''),
                  subtitle: Text(
                    prediction.structuredFormatting?.secondaryText ?? '',
                  ),
                  onTap: onTap,
                );
              },
              onAddressSelected: (address) {
                print('Address: ${address.formattedAddress}');
                print('Coordinates: (${address.latitude}, ${address.longitude})');
              },
              onError: (context, error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: $error')),
                );
              },
              showErrorInUI: true,
            ),
          ),
        ),
      ),
    );
  }
}
```

---

## ⚠️ Error Handling

* Handles:

  * HTTP errors
  * Google API status codes (`REQUEST_DENIED`, `OVER_QUERY_LIMIT`, etc.)
  * Network issues
* Use `onError` to customize error responses (e.g., show `SnackBar` or dialog).
* Set `showErrorInUI: false` to disable inline error messages and rely only on `onError`.

---

## 📝 Notes

* Ensure your API key has **Places API enabled** and **billing set up**.
* The widget uses **debouncing (500ms)** to reduce API calls while typing.
* Customize `TextField` appearance with `textStyle`, `hintStyle`, or `inputDecoration`.
* Use `suggestionItemBuilder` to fully customize suggestions (e.g., icons, colors).
* When `useDescription: true`, the full address description is shown in suggestions.

---

## 🤝 Contributing

Contributions are welcome!
Please submit **issues** or **pull requests** to the GitHub repository.

---

## 📄 License

This project is licensed under the **MIT License**.

