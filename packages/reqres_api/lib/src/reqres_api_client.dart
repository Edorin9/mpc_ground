import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../reqres_api.dart';

/// Dart API Client which wraps the [Fake Reqres API](https://reqres.in).
class ReqresApiClient {
  ReqresApiClient({http.Client? httpClient})
      : _httpClient = httpClient ?? http.Client();

  static const _baseUrl = 'reqres.in';

  final http.Client _httpClient;

  /// Create new diary `/api/diary`.
  Future<String> createDiary(
    List<String>? base64Images,
    String? comments,
    String? date,
    String? area,
    String? category,
    String? tags,
    String? event,
  ) async {
    final createDiaryUri = Uri.https(
      _baseUrl,
      '/api/diaries',
    );
    final base64Photos = <http.MultipartFile>[];
    base64Images?.asMap().forEach((key, value) async {
      final base64Photo = await http.MultipartFile.fromPath(
        key.toString(),
        value,
        contentType: MediaType('image', 'jpg'),
      );
      base64Photos.add(base64Photo);
    });

    final createDiaryRequest = http.MultipartRequest('POST', createDiaryUri)
      ..fields.addAll({
        'comments': comments ?? '',
        'date': date ?? '',
        'area': area ?? '',
        'category': category ?? '',
        'event': event ?? '',
      })
      ..files.addAll(base64Photos);
    final streamedResponse = await createDiaryRequest.send();
    final createDiaryResponse =
        await http.Response.fromStream(streamedResponse);
    final bodyJson =
        jsonDecode(createDiaryResponse.body) as Map<String, dynamic>;

    final id = bodyJson['id']?.toString();
    if (id == null) throw UploadDiaryFailure();
    if (id.isEmpty == true) throw UploadDiaryFailure();
    return id;
  }
}
