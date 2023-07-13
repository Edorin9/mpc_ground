// ignore_for_file: prefer_const_constructors
import 'package:mocktail/mocktail.dart';
import 'package:mpc_ground_repository/mpc_ground_repository.dart';
import 'package:reqres_api/reqres_api.dart' as reqres_api;
import 'package:test/test.dart';

class MockOpenMeteoApiClient extends Mock
    implements reqres_api.ReqresApiClient {}

void main() {
  group('MpcGroundRepository', () {
    late reqres_api.ReqresApiClient reqresApiClient;
    late MpcGroundRepository mpcGroundRepository;

    setUp(() {
      reqresApiClient = MockOpenMeteoApiClient();
      mpcGroundRepository = MpcGroundRepository(
        reqresApiClient: reqresApiClient,
      );
    });

    group('constructor', () {
      test('instantiates internal reqres api client when not injected', () {
        expect(MpcGroundRepository(), isNotNull);
      });
    });

    group('uploadDiary', () {
      final diary = Diary(
        ['base64Images'],
        comments: 'comments',
        date: 'date',
        area: 'area',
        category: 'category',
        tags: 'tags',
        event: 'event',
      );
      test('calls createDiary', () async {
        try {
          await mpcGroundRepository.uploadDiary(diary);
        } catch (_) {}
        verify(
          () => reqresApiClient.createDiary(
            diary.base64Images,
            diary.comments,
            diary.date,
            diary.area,
            diary.category,
            diary.tags,
            diary.event,
          ),
        ).called(1);
      });
    });
  });
}
