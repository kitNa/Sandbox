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

  var a = 10;
  var b = 20;
  var c = a + b;
  print("c = $c");
  print("ending main ....");
  print("");

  var delay = Duration.zero;

  var httpResp1 = await makeHttpGetRequest(url1, delay);
  print("url1 response 1: ${httpResp1.statusCode}, delay=$delay");
  print("after request 1");
  print("reading Romeo and Juliet: \n${snippet(httpResp1.body)}");
  print("");

  var book2Delay = Duration(milliseconds: httpResp1.body.length % 500);
  var httpResp2 = await makeHttpGetRequest(url2, book2Delay);
  print("url2 response 2: ${httpResp2.statusCode}, delay=$book2Delay");
  print("after request 2");
  print("reading Moby Dick: \n${snippet(httpResp2.body)}");
  print("");

  var book3Delay = Duration(milliseconds: httpResp2.body.length % 500);
  var httpResp3 = await makeHttpGetRequest(url3, book3Delay);
  print("url3 response3: ${httpResp3.statusCode}, delay=$book3Delay");
  print("after request 3");
  print("reading Edgar Poe: \n${snippet(httpResp3.body)}");
  print("");

  var book4Delay = Duration(milliseconds: httpResp3.body.length % 500);
  var httpResp4 = await makeHttpGetRequest(url4, book4Delay);
  print("url4 response4: ${httpResp4.statusCode}, delay=$book4Delay");
  print("after request 4");
  print("reading Vinnie the Pooh: \n${snippet(httpResp4.body)}");
  print("");

  var book5Delay = Duration(milliseconds: httpResp4.body.length % 500);
  var httpResp5 = await makeHttpGetRequest(url5, book5Delay);
  print("url5 response 5: ${httpResp5.statusCode}, delay=$book5Delay");
  print("after request 5");
  print("reading Shakespeare: \n${snippet(httpResp5.body)}");
  print("");

  var book6Delay = Duration(milliseconds: httpResp5.body.length % 500);
  var httpResp6 = await makeHttpGetRequest(url6, book6Delay);
  print("url6 response 6: ${httpResp6.statusCode}, delay=$book6Delay");
  print("after request 6");
  print("reading Kafka Metamorphosis: \n${snippet(httpResp6.body)}");
  print("");

  var book7Delay = Duration(milliseconds: httpResp6.body.length % 500);
  var httpResp7 = await makeHttpGetRequest(url7, book7Delay);
  print("url7 response 7: ${httpResp7.statusCode}, delay=$book7Delay");
  var totalBooksLens = httpResp1.body.length +
      httpResp2.body.length +
      httpResp3.body.length +
      httpResp4.body.length +
      httpResp5.body.length +
      httpResp6.body.length +
      httpResp7.body.length;
  print('total lens: $totalBooksLens');
  print("after request 7");
  print("reading Dorian Grey: \n${snippet(httpResp7.body)}");
  print("");
}

// -------------------- somewhere in the library -------------------------------
Future<http.Response> makeHttpGetRequest(String url, Duration delay) {
  return http.get(Uri.parse(url));
}

String snippet(String book) {
  var lines = book.split(RegExp('\n'));
  return lines.skip(500).firstWhere((line) => line.isNotEmpty);
}
