import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:youapp_test/app/app.dart';
import 'package:youapp_test/app/locator.dart';
import 'package:youapp_test/core/core.dart';

import 'app/flavor.dart';

Future<void> main() async {
  F.flavor = Flavor.prod;

  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await setupLocator();

    Bloc.observer = AppBlocObserver();

    return runApp(const App());
  }, (error, stackTrace) {
    GetIt.I<CaptureErrorUseCase>().call(
      CaptureErrorParams(error, stackTrace),
    );
    log(
      error.toString(),
      name: 'LOG',
      stackTrace: stackTrace,
    );
  });
}
