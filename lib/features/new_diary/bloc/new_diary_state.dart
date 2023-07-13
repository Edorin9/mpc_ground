part of 'new_diary_bloc.dart';

@freezed
class NewDiaryState with _$NewDiaryState {
  const factory NewDiaryState({
    @Default(null) List<String>? photos,
    @Default(true) bool isSaveChecked,
    @Default(false) bool isLinkEventChecked,
    @Default(null) String? message,
    @Default(MessageStatus.none) MessageStatus? messageStatus,
    @Default(false) bool isLoading,
  }) = _NewDiaryState;

  factory NewDiaryState.fromJson(Map<String, dynamic> json) =>
      _$NewDiaryStateFromJson(json);
}
