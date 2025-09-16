import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'google_address_with_autocomplete_method_channel.dart';

abstract class GoogleAddressWithAutocompletePlatform extends PlatformInterface {
  /// Constructs a GoogleAddressWithAutocompletePlatform.
  GoogleAddressWithAutocompletePlatform() : super(token: _token);

  static final Object _token = Object();

  static GoogleAddressWithAutocompletePlatform _instance = MethodChannelGoogleAddressWithAutocomplete();

  /// The default instance of [GoogleAddressWithAutocompletePlatform] to use.
  ///
  /// Defaults to [MethodChannelGoogleAddressWithAutocomplete].
  static GoogleAddressWithAutocompletePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GoogleAddressWithAutocompletePlatform] when
  /// they register themselves.
  static set instance(GoogleAddressWithAutocompletePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
