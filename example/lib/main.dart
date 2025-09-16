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
        appBar: AppBar(title: const Text('Google Address Autocomplete')),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Example with UI error display and custom suggestion builder
              GoogleAddressWithAutocomplete(
                apiKey: 'INVALID_API_KEY', // Use an invalid key to test errors
                hintText: 'Search for an address',
                textStyle: const TextStyle(fontSize: 16),
                hintStyle: const TextStyle(color: Colors.grey),
                inputDecoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Custom List with UI Errors',
                ),
                loadingWidget: const LinearProgressIndicator(
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
                suggestionsHeight: 200.0,
                suggestionItemBuilder: (context, prediction, onTap) {
                  return ListTile(
                    leading: const Icon(
                      Icons.place,
                      color: Colors.red,
                      size: 28,
                    ),
                    title: Text(
                      prediction.structuredFormatting?.mainText ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      prediction.structuredFormatting?.secondaryText ?? '',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: onTap,
                    tileColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  );
                },
                onAddressSelected: (address) {
                  // print('Selected address: ${address.formattedAddress}');
                  // print(
                  //   'Coordinates: (${address.latitude}, ${address.longitude})',
                  // );
                },
                onError: (context, error) {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Error'),
                      content: Text(error),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                showErrorInUI: true,
              ),
              const SizedBox(height: 20),

              // Example with no UI error display and default suggestion builder
            ],
          ),
        ),
      ),
    );
  }
}
