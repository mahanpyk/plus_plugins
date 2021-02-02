// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

// ignore_for_file: deprecated_member_use

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Connectivity test driver', () {
    Connectivity _connectivity;

    setUpAll(() async {
      _connectivity = Connectivity();
    });

    testWidgets('test connectivity result', (WidgetTester tester) async {
      final result = await _connectivity.checkConnectivity();
      expect(result, isNotNull);
      switch (result) {
        case ConnectivityResult.wifi:
          expect(_connectivity.getWifiName(), completes);
          expect(_connectivity.getWifiBSSID(), completes);
          expect((await _connectivity.getWifiIP()), isNotNull);
          break;
        default:
          break;
      }
    });

    testWidgets('test location methods, iOS only', (WidgetTester tester) async {
      if (Platform.isIOS) {
        expect((await _connectivity.getLocationServiceAuthorization()),
            LocationAuthorizationStatus.notDetermined);
      }
    });
  });
}
