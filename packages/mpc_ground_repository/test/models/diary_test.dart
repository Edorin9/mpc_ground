import 'package:mpc_ground_repository/mpc_ground_repository.dart';
import 'package:test/test.dart';

void main() {
  group('Diary', () {
    group('fromJson', () {
      test('returns correct Diary object', () {
        expect(
          const Diary(
            ['a', 'b'],
            comments: 'm-comments',
            date: 'm-date',
            area: 'm-area',
            category: 'm-category',
            tags: 'm-tags',
            event: 'm-event',
          ),
          isA<Diary>()
              .having((d) => d.base64Images, 'base64Images', ['a', 'b'])
              .having((d) => d.comments, 'comments', 'm-comments')
              .having((d) => d.date, 'date', 'm-date')
              .having((d) => d.area, 'area', 'm-area')
              .having((d) => d.category, 'category', 'm-category')
              .having((d) => d.tags, 'tags', 'm-tags')
              .having((d) => d.event, 'event', 'm-event'),
        );
      });
    });
  });
}
