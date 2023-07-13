import 'package:flutter/widgets.dart';

import '../features/gallery/view/gallery_page.dart';
import '../features/new_diary/view/new_diary_page.dart';

final routes = <String, WidgetBuilder>{
  GalleryPage.name: GalleryPage.route(),
  NewDiaryPage.name: NewDiaryPage.route(),
};
