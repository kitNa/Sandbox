import 'package:http/http.dart' as http;

void main() async {
  print("staring main ....");
  var x = 10;
  var y = 20;
  var z = x + y;
  print("z = $z");

  var url1 =
      'https://www.gutenberg.org/cache/epub/1513/pg1513.txt'; // Romeo and Juliet
  var url2 =
      'https://www.gutenberg.org/cache/epub/2701/pg2701.txt'; // Moby Dick
  var url3 =
      'https://www.gutenberg.org/cache/epub/1064/pg1064.txt'; // Edgar Poe
  var url4 =
      'https://www.gutenberg.org/cache/epub/67098/pg67098.txt'; // Vinnie the Pooh
  var url5 =
      'https://www.gutenberg.org/cache/epub/100/pg100.txt'; // Shakespeare
  var url6 =
      'https://www.gutenberg.org/cache/epub/5200/pg5200.txt'; // Kafka Metamorphosis
  var url7 =
      'https://www.gutenberg.org/cache/epub/174/pg174.txt'; // Dorian Grey

  var totalLens = 0;


  var httpResp1 = makeHttpGetRequest(url1).then((httpResp1) {
    print("url2 response 2: ${httpResp1.statusCode}");
    var book2Len = httpResp1.body.length;
    totalLens += book2Len;
    print("after request 2");
    print("reading Moby Dick: \n${snippet(httpResp1.body)}");
    print("");
  });

  var httpResp2 =  makeHttpGetRequest(url2).then((httpResp2) {
    print("url2 response 2: ${httpResp2.statusCode}");
    var book2Len = httpResp2.body.length;
    totalLens += book2Len;
    print("after request 2");
    print("reading Moby Dick: \n${snippet(httpResp2.body)}");
    print("");
  });;

  var httpResp3 = makeHttpGetRequest(url3).then((httpResp3) {
    print("url3 response3: ${httpResp3.statusCode}");
    var book3Len = httpResp3.body.length;
    totalLens += book3Len;
    print("after request 3");
    print("reading Edgar Poe: \n${snippet(httpResp3.body)}");
    print("");
  });

  var httpResp4 = makeHttpGetRequest(url4).then((httpResp4) {
    print("url4 response4: ${httpResp4.statusCode}");
    var book4Len = httpResp4.body.length;
    totalLens += book4Len;
    print("after request 4");
    print("reading Vinnie the Pooh: \n${snippet(httpResp4.body)}");
    print("");
  });

  var httpResp5 = makeHttpGetRequest(url5).then((httpResp5) {
    print("url5 response 5: ${httpResp5.statusCode}");
    var book5Len = httpResp5.body.length;
    totalLens += book5Len;
    print("after request 5");
    print("reading Shakespeare: \n${snippet(httpResp5.body)}");
    print("");
  });

  var httpResp6 = makeHttpGetRequest(url6).then((httpResp6) {
    print("url6 response 6: ${httpResp6.statusCode}");
    var book6Len = httpResp6.body.length;
    totalLens += book6Len;
    print("after request 6");
    print("reading Kafka Metamorphosis: \n${snippet(httpResp6.body)}");
    print("");
  });

  var httpResp7 = makeHttpGetRequest(url7).then((httpResp7) {
    print("url7 response 7: ${httpResp7.statusCode}");
    var book7Len = httpResp7.body.length;
    totalLens += book7Len;
    print("after request 7");
    print("reading Dorian Grey: \n${snippet(httpResp7.body)}");
    print("");
  });

  Future.wait([
    httpResp1,
    httpResp2,
    httpResp3,
    httpResp4,
    httpResp5,
    httpResp6,
    httpResp7
  ]).then((httpResp) {
    print('total lens: $totalLens');
  });

  var a = 10;
  var b = 20;
  var c = a + b;
  print("c = $c");
  print("ending main ....");
  print("");
}

// -------------------- somewhere in the library -------------------------------
Future<http.Response> makeHttpGetRequest(String url) async {
  return http.get(Uri.parse(url));
}

String snippet(String book) {
  var lines = book.split(RegExp('\n'));
  return lines.skip(500).firstWhere((line) => line.isNotEmpty);
}
