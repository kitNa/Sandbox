import 'dart:io';
import 'package:mongo_dart/mongo_dart.dart';

Future<void> main(List<String> args) async {
  // parse CLI args
  if (args.length != 2) {
    print('usage: dart mas_parser_classes.dart <comments-file> <db_uri>');
    return Future.value(null);
  }
  var [commentsFile, dbUri] = args;

  // parse file
  final file = File(commentsFile);
  final lines = await file.readAsLines();
  final List<App> apps = parse(lines);

  // store to DB
  final db = await Db.create(dbUri);
  await db.open();
  final collection = db.collection('apps');


  // TODO: insert apps and comments to DB
  // ------------------------------------

  await db.close();
}

List<App> parse(List<String> lines) {
  final List<App> apps = [];
  App? currentApp;
  Comment? currentComment;
  var currentState = CurrentParserState.app;

  // process lines
  for (var line in lines) {
    if (App.isHeader(line)) {
      var newApp = App.fromHeader(line);
      apps.add(newApp);
      currentApp = newApp;
      currentState = CurrentParserState.app;
    } else if (Comment.isAuthor(line)) {
      var newComment = Comment.fromAuthor(line);
      currentApp?.comments.add(newComment);
      currentComment = newComment;
      currentState = CurrentParserState.comment;
    } else if (Comment.isDate(line) && currentState != CurrentParserState.commentText) {
      currentComment?.withDate(line);
    } else {
      if (currentState == CurrentParserState.app) {
        currentApp?.comment += line;
      } else {
        currentComment?.text += line;
        currentState = CurrentParserState.commentText;
      }
    }
  }

  /*
  for (var app in apps) {
    print('app: ${app.name}, comment: ${app.comment}');
    for (var comment in app.comments) {
      print('  comment: ${comment.appIdx}.${comment.commentIdx} (${comment.author}) ${comment.date.toIso8601String().substring(0, 10)} - ${comment.text}');
    }
  }
   */

  return apps;
}

class App {
  static final RegExp appHeaderPattern =
      RegExp(r'^\s*<h2>(?<idx>\d+)\.\s+(?<name>.+)\s+-\s+(?<rating>\d\.\d),\s+\b(?<downloads>.*)\b.*</?h2>\s*$');
  static final RegExp numDownloadsPattern = RegExp(r'(?<num>\d+)(?<sfx>mln|thd)');

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

  static bool isHeader(String line) {
    return appHeaderPattern.hasMatch(line);
  }

  static App fromHeader(String appHeader) {
    var match = appHeaderPattern.firstMatch(appHeader);
    if (match == null) {
      throw Exception('invalid app header: $appHeader');
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
    return App(
        idx: int.parse(idx!), name: appName!, rating: double.parse(rating!), numDownloads: numDownloads, comments: []);
  }
}

class Comment {
  static final RegExp commentAuthorPattern = RegExp(r'^(?<appIdx>\d+)\.(?<commendIdx>\d+)\s+(?<author>.+)$');
  static final RegExp commentDateUaPattern = RegExp(r'^(?<day>\d+)\s+(?<month>[А-яа-яіїє]+)\s+(?<year>\d+).*$');

  final int appIdx;
  final int commentIdx;
  final String author;
  DateTime date;
  String text;

  Comment({required this.appIdx, required this.commentIdx, required this.author, required this.date, this.text = ''});

  static bool isAuthor(String line) {
    return commentAuthorPattern.hasMatch(line);
  }

  static Comment fromAuthor(String authorStr) {
    var match = commentAuthorPattern.firstMatch(authorStr);
    if (match == null) {
      throw Exception('invalid comment author: $authorStr');
    }
    var [appIdx, commentIdx, author] = match.groups([1, 2, 3]);
    return Comment(
        appIdx: int.parse(appIdx!),
        commentIdx: int.parse(commentIdx!),
        author: author!.trim(),
        date: DateTime.now(),
        text: '');
  }

  static bool isDate(String line) {
    return commentDateUaPattern.hasMatch(line);
  }

  Comment withDate(String dateStr) {
    var match = commentDateUaPattern.firstMatch(dateStr);
    if (match == null) {
      throw Exception('invalid comment date: $dateStr');
    }
    var [day, monthUaStr, year] = match.groups([1, 2, 3]);
    var month = Month.fromUaStr(monthUaStr!);
    date = DateTime(int.parse(year!), month.monthValue, int.parse(day!));
    return this;
  }
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
  static final Map<String, Month> _monthMap = {
    'січня': Month.jan,
    'лютого': Month.feb,
    'березня': Month.mar,
    'квітня': Month.apr,
    'травня': Month.may,
    'червня': Month.jun,
    'липня': Month.jul,
    'серпня': Month.aug,
    'вересня': Month.sep,
    'жовтня': Month.oct,
    'листопада': Month.nov,
    'грудня': Month.dec
  };

  const Month({required this.monthValue});

  static Month fromUaStr(String monthUaStr) {
    return _monthMap[monthUaStr]!;
  }
}

enum CurrentParserState { app, comment, commentText }
