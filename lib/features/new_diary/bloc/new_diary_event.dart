part of 'new_diary_bloc.dart';

@freezed
class NewDiaryEvent with _$NewDiaryEvent {
  const factory NewDiaryEvent.addPhotosClicked() = AddPhotosClicked;
  const factory NewDiaryEvent.savePhotosToggled({
    required bool isChecked,
  }) = SavePhotosToggled;
  const factory NewDiaryEvent.linkEventToggled({
    required bool isChecked,
  }) = LinkEventToggled;
  const factory NewDiaryEvent.nextClicked({
    @Default('') String? comments,
    required String date,
    @Default('') String? area,
    @Default('') String? category,
    @Default('') String? tags,
    @Default('') String? event,
  }) = NextClicked;

  factory NewDiaryEvent.fromJson(Map<String, dynamic> json) =>
      _$NewDiaryEventFromJson(json);
}
