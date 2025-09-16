import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'google_address_with_autocomplete_platform_interface.dart';

/// An implementation of [GoogleAddressWithAutocompletePlatform] that uses method channels.
class MethodChannelGoogleAddressWithAutocomplete extends GoogleAddressWithAutocompletePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('google_address_with_autocomplete');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
