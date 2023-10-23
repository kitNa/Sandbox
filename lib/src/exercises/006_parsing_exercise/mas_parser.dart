import 'dart:io';

final RegExp appHeaderPattern =
    RegExp(r'^\s*<h2>(?<idx>\d+)\.\s+(?<name>.+)\s+-\s+(?<rating>\d\.\d),\s+\b(?<downloads>.*)\b.*</?h2>\s*$');
final RegExp numDownloadsPattern = RegExp(r'(?<num>\d+)(?<sfx>mln|thd)');
final RegExp commentAuthorPattern = RegExp(r'^(?<appIdx>\d+)\.(?<commendIdx>\d+)\s+(?<author>.+)$');
final RegExp commentDatePattern = RegExp(r'^(?<day>\d+)\s+(?<month>[А-Яа-я]+)\s+(?<year>\d+).*$');

// TODO: pass secrets in CLI args
Future<void> main(List<String> args) async {
  // TODO: parse DB uri, username, password from args

  // read lines from file
  final file = File('/home/dburyak/idea/wimm/sandbox-dart-kit/lib/src/exercises/006_parsing_exercise/analyzes_existing_program.md');
  final lines = await file.readAsLines();
  final List<App> apps = [];
  var currentApp = App(idx: -1, name: '<INVALID_APP>', rating: -1, numDownloads: -1, comments: []);
  var currentComment = Comment(
      appIdx: -1,
      commentIdx: -1,
      author: '<INVALID_COMMENT_AUTHOR>',
      date: DateTime.now(),
      text: '<INVALID_COMMENT_TEXT>');
  var currentState = CurrentParserState.app;
  for (var line in lines) {
    if (isAppHeader(line)) {
      var newAppRecord = parseAppHeader(line);
      var newApp = App(
          idx: newAppRecord.idx,
          name: newAppRecord.name,
          rating: newAppRecord.rating,
          numDownloads: newAppRecord.numDownloads,
          comments: []);
      apps.add(newApp);
      currentApp = newApp;
      currentState = CurrentParserState.app;
    } else if (isCommentAuthor(line)) {
      var newCommentAuthorRecord = parseCommentAuthor(line);
      var newComment = Comment(
          appIdx: newCommentAuthorRecord.appIdx,
          commentIdx: newCommentAuthorRecord.commentIdx,
          author: newCommentAuthorRecord.author,
          date: DateTime.now(),
          text: '');
      currentApp.comments.add(newComment);
      currentComment = newComment;
      currentState = CurrentParserState.comment;
    } else if (isCommentDate(line)) {
      var newCommentDateRecord = parseCommentDate(line);
      currentComment.date =
          DateTime(newCommentDateRecord.year, newCommentDateRecord.month.monthValue, newCommentDateRecord.day);
    } else {
      if (currentState == CurrentParserState.app) {
        currentApp.comment += line;
      } else if (currentState == CurrentParserState.comment) {
        currentComment.text += line;
      }
    }
  }

  for (var app in apps) {
    print('app: ${app.name}, comment: ${app.comment}');
    for (var comment in app.comments) {
      print('  comment: ${comment.text}');
    }
  }
}

/// Format: &lt;h2&gt;idx. AppName&lt;/h2&gt;
///
/// Example: &lt;h2&gt;1. 1Money&lt;/h2&gt;
///
/// Returns: (idx, appName, numDownloads) - idx > 0 indicates valid app header,
/// idx < 0 indicates invalid app header
App parseAppHeader(String line) {
  var match = appHeaderPattern.firstMatch(line);
  var newApp;
  if (match == null) {
    newApp = App(
    idx: -1, name: '<INVALID_HEADER>', rating: -1, numDownloads: -1, comments: []);
    return newApp;
  }
  var [idx, appName, rating, numDownloadsWithSfx] = match.groups([1, 2, 3, 4]);
  var numDownloadsMatch = numDownloadsPattern.firstMatch(numDownloadsWithSfx!);
  var [numDownloadsStr, sfx] = numDownloadsMatch!.groups([1, 2]);
  switch (sfx) {
    case 'mln':
      numDownloadsStr = '${numDownloadsStr!}000000';
      break;
    case 'thd':
      numDownloadsStr = '${numDownloadsStr!}000';
      break;
  }
  var numDownloads = int.parse(numDownloadsStr!);
  newApp = App(
idx:  int.parse(idx!), name:  appName!, rating: double.parse(rating!), numDownloads: numDownloads, comments: []);
  return newApp;
}

bool isAppHeader(String line) {
  return appHeaderPattern.hasMatch(line);
}

({int appIdx, int commentIdx, String author}) parseCommentAuthor(String line) {
  var match = commentAuthorPattern.firstMatch(line);
  if (match == null) {
    return (appIdx: -1, commentIdx: -1, author: '<INVALID_COMMENT_AUTHOR>');
  }
  var [appIdx, commentIdx, author] = match.groups([1, 2, 3]);
  return (appIdx: int.parse(appIdx!), commentIdx: int.parse(commentIdx!), author: author!.trim());
}

bool isCommentAuthor(String line) {
  return commentAuthorPattern.hasMatch(line);
}

({int day, Month month, int year}) parseCommentDate(String line) {
  var match = commentDatePattern.firstMatch(line);
  if (match == null) {
    return (day: -1, month: Month.jan, year: -1);
  }
  var [day, monthUaStr, year] = match.groups([1, 2, 3]);
  var month = Month.jan;
  switch (monthUaStr) {
    case 'січня':
      month = Month.jan;
      break;
    case 'лютого':
      month = Month.feb;
      break;
    case 'березня':
      month = Month.mar;
      break;
    case 'квітня':
      month = Month.apr;
      break;
    case 'травня':
      month = Month.may;
      break;
    case 'червня':
      month = Month.jun;
      break;
    case 'липня':
      month = Month.jul;
      break;
    case 'серпня':
      month = Month.aug;
      break;
    case 'вересня':
      month = Month.sep;
      break;
    case 'жовтня':
      month = Month.oct;
      break;
    case 'листопада':
      month = Month.nov;
      break;
    case 'грудня':
      month = Month.dec;
      break;
  }
  return (day: int.parse(day!), month: month, year: int.parse(year!));
}

bool isCommentDate(String line) {
  return commentDatePattern.hasMatch(line);
}

enum Month {
  jan(monthValue: 1),
  feb(monthValue: 2),
  mar(monthValue: 3),
  apr(monthValue: 4),
  may(monthValue: 5),
  jun(monthValue: 6),
  jul(monthValue: 7),
  aug(monthValue: 8),
  sep(monthValue: 9),
  oct(monthValue: 10),
  nov(monthValue: 11),
  dec(monthValue: 12);

  final int monthValue;

  const Month({required this.monthValue});
}

class App {
  final int idx;
  final String name;
  final double rating;
  final int numDownloads;
  final List<Comment> comments;
  String comment;

  App(
      {required this.idx,
      required this.name,
      required this.rating,
      required this.numDownloads,
      required this.comments,
      this.comment = ''});
}

class Comment {
  final int appIdx;
  final int commentIdx;
  final String author;
  DateTime date;
  String text;

  Comment({required this.appIdx, required this.commentIdx, required this.author, required this.date, this.text = ''});
}

enum CurrentParserState { app, comment }
