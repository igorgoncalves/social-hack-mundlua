import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'src/app.dart';


Future main() async {
  await DotEnv().load('.env');
  await Parse().initialize(
      DotEnv().env['PARSE_APP_ID'], DotEnv().env['PARSE_APP_URL'],
      clientKey: DotEnv().env['PARSE_APP_CLINT_KEY'], debug: false);
  // runApp(MyApp());
  runZoned(() => runApp(MyApp()));
}
