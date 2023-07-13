import 'package:freezed_annotation/freezed_annotation.dart';

part 'diary.freezed.dart';
part 'diary.g.dart';

@freezed
class Diary with _$Diary {
  const factory Diary(
    List<String> base64Images, {
    String? comments,
    String? date,
    String? area,
    String? category,
    String? tags,
    String? event,
  }) = _Diary;

  factory Diary.fromJson(Map<String, dynamic> json) => _$DiaryFromJson(json);
}
