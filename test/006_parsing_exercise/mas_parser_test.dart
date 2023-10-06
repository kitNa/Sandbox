import 'package:sandbox/src/exercises/006_parsing_exercise/mas_parser.dart';
import 'package:test/test.dart';

void main() {
  test("parses valid app header", () {
    // given: valid app header (with wrong html enclosing tag)
    var validAppHeader = '<h2>1. 1Money - 4.6, 5mln+<h2>';
    var [expIdx, expName, expRtng, expDwnld] = [1, '1Money', 4.6, 5000000];

    // when: parse valid app header
    var (idx, appName, rating, numDownloads) = parseAppHeader(validAppHeader);

    // then: parsed values returned
    print('idx: $idx, appName: $appName, rating: $rating, numDownloads: $numDownloads');
    expect(idx, expIdx);
    expect(appName, expName);
    expect(rating, expRtng);
    expect(numDownloads, expDwnld);
  });

  test("returns magic values for invalid app header", () {
    // given: invalid app header
    var invalidAppHeader = 'blah-blah-blah';
    var [expInvalidIdx, expInvalidAppName, expInvalidRating, expInvalidNumDownloads] = [-1, '<INVALID_HEADER>', -1, -1];

    // when: parse invalid app header
    var (idx, appName, rating, numDownloads) = parseAppHeader(invalidAppHeader);

    // then: magic values returned
    print('idx: $idx, appName: $appName, rating: $rating, numDownloads: $numDownloads');
    expect(idx, expInvalidIdx);
    expect(appName, expInvalidAppName);
    expect(rating, expInvalidRating);
    expect(numDownloads, expInvalidNumDownloads, reason: 'invalid numDownloads should be -1');
  });

  test('parses valid comment header', () {
    // given: valid comment header
    var validCommentHeader = '1.5 Marina Kolbina';
    var [expAppIdx, expCommentIdx, expAuthor] = [1, 5, 'Marina Kolbina'];

    // when: parse valid comment header
    var (appIdx, commentIdx, author) = parseCommentAuthor(validCommentHeader);

    // then: parsed values returned
    print('appIdx: $appIdx, commentIdx: $commentIdx, author: $author');
    expect(appIdx, expAppIdx);
    expect(commentIdx, expCommentIdx);
    expect(author, expAuthor);
  });

  test('returns magic values for invalid comment header', () {
    // given: invalid comment header
    var invalidCommentHeader = 'blah-blah-blah';
    var [expInvalidAppIdx, expInvalidCommentIdx, expInvalidAuthor] = [-1, -1, '<INVALID_COMMENT_AUTHOR>'];

    // when: parse invalid comment header
    var (appIdx, commentIdx, author) = parseCommentAuthor(invalidCommentHeader);

    // then: magic values returned
    print('appIdx: $appIdx, commentIdx: $commentIdx, author: $author');
    expect(appIdx, expInvalidAppIdx);
    expect(commentIdx, expInvalidCommentIdx);
    expect(author, expInvalidAuthor);
  });

  test('parses comment date', () {
    // given: valid comment date
    var validCommentDate = '12 вересня 2021';
    var [expDay, expMonth, expYear] = [12, Month.sep, 2021];

    // when: parse valid comment date
    var (day, month, year) = parseCommentDate(validCommentDate);

    // then: parsed values returned
    print('day: $day, month: $month, year: $year');
    expect(day, expDay);
    expect(month, expMonth);
    expect(year, expYear);
  });
}
