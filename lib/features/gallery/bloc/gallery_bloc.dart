import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path_provider/path_provider.dart';

part 'gallery_bloc.freezed.dart';
part 'gallery_bloc.g.dart';
part 'gallery_event.dart';
part 'gallery_state.dart';

class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  GalleryBloc() : super(const GalleryState()) {
    on<PageEntered>(_onPageEntered);
  }

  Future<void> _onPageEntered(
    PageEntered event,
    Emitter<GalleryState> emit,
  ) async {
    final directory = await getApplicationDocumentsDirectory();

    final imagePaths = directory
        .listSync()
        .map((item) => item.path)
        .where((item) => item.endsWith('.jpg'))
        .toList(growable: false);

    emit(state.copyWith(imagePaths: imagePaths));
  }
}
