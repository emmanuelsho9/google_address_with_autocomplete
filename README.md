google_address_with_autocomplete
A Flutter package that provides a customizable TextField with Google Places Autocomplete integration. Users can input an address, see suggestions, and retrieve the selected address's primary text, latitude, and longitude. The package uses the http package for API calls and requires a Google API key. Includes robust error handling for API issues.
Features

Customizable TextField with options for hint, style, and validation.
Google Places Autocomplete for address suggestions.
Returns formatted address, latitude, and longitude on selection.
Debounced search to optimize API calls.
Customizable loading indicator.
Fully customizable suggestion list items via suggestionItemBuilder.
Error handling with onError callback and optional UI display for errors (e.g., invalid API key, quota exceeded).
Support for displaying full description or structured formatting in suggestions.
Lightweight with minimal dependencies.

Screenshots
https://asset.cloudinary.com/ducx7nije/5ef7bd5d4ee1a8c424e2c63569f32473
Screenshot of the autocomplete widget in action, showing address suggestions.
Installation
Add the package to your pubspec.yaml:
dependencies:
  google_address_with_autocomplete: ^0.1.0

Run flutter pub get to install.
Setup

Get a Google API Key:

Enable the Google Places API in your Google Cloud Console.
Ensure billing is enabled (required for Places API).


Add the API Key:Pass your Google API key to the widget.


Usage
Import the package:
import 'package:google_address_with_autocomplete/google_address_with_autocomplete.dart';

Use the GoogleAddressAutocomplete widget in your app:
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

Parameters

apiKey: Your Google Places API key (required).
hintText: Placeholder text for the TextField (optional).
textStyle: Style for the TextField text (optional).
hintStyle: Style for the hint text (optional).
inputDecoration: Custom decoration for the TextField (optional).
loadingWidget: Custom loading widget (optional; defaults to a styled CircularProgressIndicator).
suggestionsHeight: Height of the suggestions list (optional; default: 150.0).
suggestionItemBuilder: Custom builder for suggestion items (optional; receives context, prediction, and onTap callback).
useDescription: Whether to display the full description in suggestions (optional; default: false).
onAddressSelected: Callback returning AddressDetails with formatted address, lat, and lng (optional).
onError: Callback for handling errors (receives context and error message; optional).
showErrorInUI: Whether to display errors below the TextField (optional; default: true).

Example
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
                  subtitle: Text(prediction.structuredFormatting?.secondaryText ?? ''),
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

Error Handling

The package handles HTTP errors, Google API status codes (e.g., REQUEST_DENIED, OVER_QUERY_LIMIT), and network issues.
Use onError to customize error responses (e.g., show SnackBar or dialog).
Set showErrorInUI: false to disable inline error messages and rely on onError.

Notes

Ensure your Google API key has the Places API enabled and billing set up.
The package uses debouncing (500ms) to reduce API calls during typing.
Customize the TextField appearance using textStyle, hintStyle, or inputDecoration.
For custom suggestion items, use suggestionItemBuilder to access PredictionGoogle fields like description, mainText, secondaryText, or types.
When useDescription: true, the full address description is shown in suggestions and set in the TextField on selection.

Contributing
Contributions are welcome! Please submit issues or pull requests to the GitHub repository.
License
MIT License