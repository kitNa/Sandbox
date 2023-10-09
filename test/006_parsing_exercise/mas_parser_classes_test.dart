import 'package:sandbox/src/exercises/006_parsing_exercise/mas_parser_classes.dart';
import 'package:test/test.dart';

void main() {
  test('parses date with 1 digit', () {
    // given: date string with 1 digit
    var dateStr = '1 вересня 2023 р.';

    // when: parse date
    var comment = Comment.fromAuthor('1.20 Aliks S.');
    comment.withDate(dateStr);

    // then: date is parsed correctly
    expect(comment.date, DateTime(2023, 9, 1));
  });

  test('parses date with ua symbols', () {
    // given: date string with ua symbols
    var dateStr = '14 січня 2023 р.';

    // when: parse date
    var comment = Comment.fromAuthor('1.20 Aliks S.');
    comment.withDate(dateStr);

    // then: date is parsed correctly
    expect(comment.date, DateTime(2023, 1, 14));
  });
}
