import 'dart:convert';
import 'package:http/http.dart' as http;
import 'export.dart';

class GoogleAddressWithAutocomplete extends StatefulWidget {
  final String apiKey;
  final String? hintText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final InputDecoration? inputDecoration;
  final Widget? loadingWidget;
  final double suggestionsHeight;
  final Widget Function(BuildContext, PredictionGoogle, VoidCallback)?
  suggestionItemBuilder;
  final void Function(AddressDetails)? onAddressSelected;
  final void Function(BuildContext, String)?
  onError; // Updated to include BuildContext
  final bool showErrorInUI;

  const GoogleAddressWithAutocomplete({
    super.key,
    required this.apiKey,
    this.hintText,
    this.textStyle,
    this.hintStyle,
    this.inputDecoration,
    this.loadingWidget,
    this.suggestionsHeight = 150.0,
    this.suggestionItemBuilder,
    this.onAddressSelected,
    this.onError,
    this.showErrorInUI = true,
  });

  @override
  GoogleAddressWithAutocompleteState createState() =>
      GoogleAddressWithAutocompleteState();
}

class GoogleAddressWithAutocompleteState
    extends State<GoogleAddressWithAutocomplete> {
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);
  final ValueNotifier<List<PredictionGoogle>> _predictions = ValueNotifier([]);
  final ValueNotifier<String?> _errorMessage = ValueNotifier(null);
  Timer? _debounceTimer;

  @override
  void dispose() {
    _controller.dispose();
    _isLoading.dispose();
    _predictions.dispose();
    _errorMessage.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _handleError(String message) {
    if (widget.showErrorInUI) {
      _errorMessage.value = message;
    }
    if (widget.onError != null) {
      widget.onError!(context, message); // Pass context to onError
    } else {
      debugPrint('GoogleAddressAutocomplete Error: $message');
    }
  }

  void _clearError() {
    _errorMessage.value = null;
  }

  void _searchAddress(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (query.trim().isEmpty) {
        _predictions.value = [];
        _clearError();
        return;
      }
      _fetchGoogleAddress(query);
    });
  }

  Future<void> _fetchGoogleAddress(String address) async {
    _isLoading.value = true;
    _clearError();
    try {
      final uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json',
      ).replace(queryParameters: {'input': address, 'key': widget.apiKey});

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = GoogleMapClassPrediction.fromJson(
          jsonDecode(response.body),
        );
        if (data.status == 'OK') {
          _predictions.value = data.predictions ?? [];
        } else {
          String errorMessage;
          switch (data.status) {
            case 'REQUEST_DENIED':
              errorMessage =
                  'Invalid API key. Please check your Google API key.';
              break;
            case 'OVER_QUERY_LIMIT':
              errorMessage = 'API quota exceeded. Try again later.';
              break;
            case 'INVALID_REQUEST':
              errorMessage = 'Invalid request. Please try again.';
              break;
            default:
              errorMessage = 'API error: ${data.status}';
          }
          _predictions.value = [];
          _handleError(errorMessage);
        }
      } else {
        _predictions.value = [];
        _handleError('HTTP error: ${response.statusCode}');
      }
    } catch (e) {
      _predictions.value = [];
      _handleError('Failed to fetch addresses: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> _selectPrediction(PredictionGoogle prediction) async {
    _controller.text = prediction.structuredFormatting?.mainText ?? '';
    _predictions.value = [];
    _clearError();

    final details = await _getPlaceDetails(prediction.placeId ?? '');
    if (details != null && widget.onAddressSelected != null) {
      widget.onAddressSelected!(details);
    }
  }

  Future<AddressDetails?> _getPlaceDetails(String placeId) async {
    try {
      final uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json',
      ).replace(queryParameters: {'place_id': placeId, 'key': widget.apiKey});

      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = PlaceDetailsResponse.fromJson(response.body);
        if (data.status == 'OK') {
          final location = data.result?.geometry?.location;
          if (location != null) {
            return AddressDetails(
              formattedAddress: data.result?.formattedAddress ?? '',
              latitude: location.lat ?? 0.0,
              longitude: location.lng ?? 0.0,
            );
          } else {
            _handleError('No location data found for this place.');
            return null;
          }
        } else {
          String errorMessage;
          switch (data.status) {
            case 'REQUEST_DENIED':
              errorMessage = 'Invalid API key for place details.';
              break;
            case 'OVER_QUERY_LIMIT':
              errorMessage = 'API quota exceeded for place details.';
              break;
            case 'INVALID_REQUEST':
              errorMessage = 'Invalid place ID.';
              break;
            case 'NOT_FOUND':
              errorMessage = 'Place not found.';
              break;
            default:
              errorMessage = 'API error: ${data.status}';
          }
          _handleError(errorMessage);
          return null;
        }
      } else {
        _handleError('HTTP error for place details: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      _handleError('Failed to fetch place details: $e');
      return null;
    }
  }

  Widget _defaultSuggestionItemBuilder(
    BuildContext context,
    PredictionGoogle prediction,
    VoidCallback onTap,
  ) {
    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              const Icon(Icons.location_on, color: Colors.blueGrey, size: 24),
              const SizedBox(width: 12.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      prediction.structuredFormatting?.mainText ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      prediction.structuredFormatting?.secondaryText ?? '',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _controller,
          onChanged: _searchAddress,
          style: widget.textStyle,
          decoration:
              widget.inputDecoration ??
              InputDecoration(
                hintText: widget.hintText ?? 'Enter location',
                hintStyle: widget.hintStyle,
                border: const OutlineInputBorder(),
              ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _isLoading,
          builder: (context, isLoading, _) {
            if (isLoading) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    widget.loadingWidget ??
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.blue,
                          ),
                        ),
                      ),
                    ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        ValueListenableBuilder<String?>(
          valueListenable: _errorMessage,
          builder: (context, error, _) {
            if (error != null && widget.showErrorInUI) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Text(
                  error,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
        ValueListenableBuilder<List<PredictionGoogle>>(
          valueListenable: _predictions,
          builder: (context, predictions, _) {
            if (predictions.isEmpty) {
              return const SizedBox.shrink();
            }
            return SizedBox(
              height: widget.suggestionsHeight,
              child: ListView.builder(
                itemCount: predictions.length,
                itemBuilder: (context, index) {
                  final prediction = predictions[index];
                  return widget.suggestionItemBuilder != null
                      ? widget.suggestionItemBuilder!(
                          context,
                          prediction,
                          () => _selectPrediction(prediction),
                        )
                      : _defaultSuggestionItemBuilder(
                          context,
                          prediction,
                          () => _selectPrediction(prediction),
                        );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
