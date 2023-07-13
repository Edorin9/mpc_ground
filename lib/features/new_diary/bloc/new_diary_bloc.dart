import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mpc_ground_repository/mpc_ground_repository.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../enums/message_status.dart';

part 'new_diary_bloc.freezed.dart';
part 'new_diary_bloc.g.dart';
part 'new_diary_event.dart';
part 'new_diary_state.dart';

class NewDiaryBloc extends Bloc<NewDiaryEvent, NewDiaryState> {
  NewDiaryBloc({
    required MpcGroundRepository mpcGroundRepository,
    required ImagePicker imagePicker,
  })  : _mpcGroundRepository = mpcGroundRepository,
        _imagePicker = imagePicker,
        super(const NewDiaryState()) {
    on<AddPhotosClicked>(_onAddPhotosClicked);
    on<SavePhotosToggled>(_onSavePhotosToggled);
    on<LinkEventToggled>(_onLinkEventToggled);
    on<NextClicked>(_onNextClicked);
  }

  final MpcGroundRepository _mpcGroundRepository;
  final ImagePicker _imagePicker;

  Future<void> _onAddPhotosClicked(
    AddPhotosClicked event,
    Emitter<NewDiaryState> emit,
  ) async {
    final photosList = await _imagePicker.pickMultiImage();
    final selectedPhotos = photosList.map((p) => p.path).toList();
    if (photosList.isEmpty) {
      emit(
        state.copyWith(
          message: 'No photos selected',
          messageStatus: MessageStatus.regular,
        ),
      );
    } else {
      emit(NewDiaryState(photos: selectedPhotos));
    }
  }

  Future<void> _onSavePhotosToggled(
    SavePhotosToggled event,
    Emitter<NewDiaryState> emit,
  ) async {
    emit(state.copyWith(isSaveChecked: event.isChecked));
  }

  Future<void> _onLinkEventToggled(
    LinkEventToggled event,
    Emitter<NewDiaryState> emit,
  ) async {
    emit(state.copyWith(isLinkEventChecked: event.isChecked));
  }

  Future<void> _onNextClicked(
    NextClicked event,
    Emitter<NewDiaryState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    if (state.isSaveChecked) {
      final dir = await getApplicationDocumentsDirectory();
      state.photos?.forEach((p) async {
        final file = File(
          path.join(
            dir.path,
            path.basename(p),
          ),
        );
        final source = await File(p).readAsBytes();
        file.writeAsBytesSync(source);
      });
    }

    final diary = Diary(
      state.photos ?? <String>[],
      comments: event.comments,
      date: event.date,
      area: event.area,
      category: event.category,
      tags: event.tags,
      event: state.isLinkEventChecked ? event.event : null,
    );
    final diaryId = await _mpcGroundRepository.uploadDiary(diary);
    emit(state.copyWith(isLoading: false));
    if (diaryId.isEmpty) {
      emit(
        state.copyWith(
          message: 'Upload failed',
          messageStatus: MessageStatus.failure,
        ),
      );
    } else {
      emit(
        const NewDiaryState(
          message: 'Upload success',
          messageStatus: MessageStatus.success,
        ),
      );
    }
  }
}
