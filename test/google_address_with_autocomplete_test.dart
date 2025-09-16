// import 'package:flutter_test/flutter_test.dart';
// import 'package:google_address_with_autocomplete/google_address_with_autocomplete.dart';
// import 'package:google_address_with_autocomplete/google_address_with_autocomplete_platform_interface.dart';
// import 'package:google_address_with_autocomplete/google_address_with_autocomplete_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockGoogleAddressWithAutocompletePlatform
//     with MockPlatformInterfaceMixin
//     implements GoogleAddressWithAutocompletePlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

// void main() {
//   final GoogleAddressWithAutocompletePlatform initialPlatform = GoogleAddressWithAutocompletePlatform.instance;

//   test('$MethodChannelGoogleAddressWithAutocomplete is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelGoogleAddressWithAutocomplete>());
//   });

//   test('getPlatformVersion', () async {
//     GoogleAddressWithAutocomplete googleAddressWithAutocompletePlugin = GoogleAddressWithAutocomplete();
//     MockGoogleAddressWithAutocompletePlatform fakePlatform = MockGoogleAddressWithAutocompletePlatform();
//     GoogleAddressWithAutocompletePlatform.instance = fakePlatform;

//     expect(await googleAddressWithAutocompletePlugin.getPlatformVersion(), '42');
//   });
// }
