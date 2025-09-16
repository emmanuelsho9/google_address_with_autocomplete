import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_address_with_autocomplete/google_address_with_autocomplete_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelGoogleAddressWithAutocomplete platform = MethodChannelGoogleAddressWithAutocomplete();
  const MethodChannel channel = MethodChannel('google_address_with_autocomplete');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
