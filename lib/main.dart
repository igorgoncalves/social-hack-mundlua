import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:vetores/src/app.dart';
import 'package:sentry/sentry.dart';

final SentryClient sentry = SentryClient(
  dsn: 'https://73a6456747ed4f7f8c89f5b572b432b8@sentry.io/1795676',
);

Future main() async {
  await DotEnv().load('.env');
  await Parse().initialize(
      DotEnv().env['PARSE_APP_ID'], DotEnv().env['PARSE_APP_URL'],
      clientKey: DotEnv().env['PARSE_APP_CLINT_KEY'], debug: false);
  // runApp(MyApp());

  FlutterError.onError = (details, {bool forceReport = false}) {
    try {
      sentry.captureException(
        exception: details.exception,
        stackTrace: details.stack,
      );
    } catch (e) {
      print('Sending report to sentry.io failed: $e');
    } finally {
      // Also use Flutter's pretty error logging to the device's console.
      FlutterError.dumpErrorToConsole(details, forceReport: forceReport);
    }
  };

  runZoned(
    () => runApp(MyApp()),
    onError: (Object error, StackTrace stackTrace) {
      try {
        sentry.captureException(
          exception: error,
          stackTrace: stackTrace,
        );
        print('Error sent to sentry.io: $error');
      } catch (e) {
        print('Sending report to sentry.io failed: $e');
        print('Original error: $error');
      }
    },
  );
}
