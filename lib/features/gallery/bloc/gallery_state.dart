part of 'gallery_bloc.dart';

@freezed
class GalleryState with _$GalleryState {
  const factory GalleryState({
    @Default([]) List<String> imagePaths,
  }) = _GalleryState;

  factory GalleryState.fromJson(Map<String, dynamic> json) =>
      _$GalleryStateFromJson(json);
}
