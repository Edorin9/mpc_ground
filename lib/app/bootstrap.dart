import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mpc_ground_repository/mpc_ground_repository.dart';

import 'app.dart';
import 'app_bloc_observer.dart';

Future<void> bootstrap() async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  Bloc.observer = AppBlocObserver();

  runZonedGuarded(
    () => runApp(App(MpcGroundRepository(), ImagePicker())),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
