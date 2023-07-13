import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mpc_ground_repository/mpc_ground_repository.dart';

import '../features/gallery/view/gallery_page.dart';
import 'routes.dart';

class App extends StatelessWidget {
  const App(this._mpcGroundRepository, this._imagePicker, {super.key});

  final MpcGroundRepository _mpcGroundRepository;
  final ImagePicker _imagePicker;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MpcGroundRepository>(
          create: (context) => _mpcGroundRepository,
        ),
        RepositoryProvider<ImagePicker>(
          create: (context) => _imagePicker,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
        ),
        initialRoute: GalleryPage.name,
        routes: routes,
      ),
    );
  }
}
