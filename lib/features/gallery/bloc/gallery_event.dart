part of 'gallery_bloc.dart';

@freezed
class GalleryEvent with _$GalleryEvent {
  const factory GalleryEvent.pageEntered() = PageEntered;


  factory GalleryEvent.fromJson(Map<String, dynamic> json) =>
      _$GalleryEventFromJson(json);
}
