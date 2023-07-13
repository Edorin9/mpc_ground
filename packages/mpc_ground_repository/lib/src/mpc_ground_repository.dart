import 'dart:async';

import 'package:reqres_api/reqres_api.dart';

import '../mpc_ground_repository.dart';

class MpcGroundRepository {
  MpcGroundRepository({ReqresApiClient? reqresApiClient})
      : _reqresApiClient = reqresApiClient ?? ReqresApiClient();

  final ReqresApiClient _reqresApiClient;

  Future<String> uploadDiary(Diary diary) async {
    final diaryId = await _reqresApiClient.createDiary(
      diary.base64Images,
      diary.comments,
      diary.date,
      diary.area,
      diary.category,
      diary.tags,
      diary.event,
    );
    return diaryId;
  }
}
