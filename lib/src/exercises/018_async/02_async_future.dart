import 'package:http/http.dart' as http;

void main() {
  print("staring main ....");
  var x = 10;
  var y = 20;
  var z = x + y;
  print("z = $z");

  var url1 = 'https://www.gutenberg.org/cache/epub/1513/pg1513.txt'; // Romeo and Juliet
  var url2 = 'https://www.gutenberg.org/cache/epub/2701/pg2701.txt'; // Moby Dick
  var url3 = 'https://www.gutenberg.org/cache/epub/1064/pg1064.txt'; // Edgar Poe
  var url4 = 'https://www.gutenberg.org/cache/epub/67098/pg67098.txt'; // Vinnie the Pooh
  var url5 = 'https://www.gutenberg.org/cache/epub/100/pg100.txt'; // Shakespeare
  var url6 = 'https://www.gutenberg.org/cache/epub/5200/pg5200.txt'; // Kafka Metamorphosis
  var url7 = 'https://www.gutenberg.org/cache/epub/174/pg174.txt'; // Dorian Grey

  var prevDelay = Duration.zero;
  var totalLens = 0;
  makeHttpGetRequest(url1, prevDelay).then((httpResp1) {
    print("url1 response 1: ${httpResp1.statusCode}, delay=$prevDelay");
    var book1Len = httpResp1.body.length;
    totalLens += book1Len;
    var book2Delay = Duration(milliseconds: book1Len % 500);
    prevDelay = book2Delay;
    var req2Future = makeHttpGetRequest(url2, book2Delay);
    print("after request 1");
    print("reading Romeo and Juliet: \n${snippet(httpResp1.body)}");
    print("");
    return req2Future;
  }).then((httpResp2) {
    print("url2 response 2: ${httpResp2.statusCode}, delay=$prevDelay");
    var book2Len = httpResp2.body.length;
    totalLens += book2Len;
    var book3Delay = Duration(milliseconds: book2Len % 500);
    prevDelay = book3Delay;
    var req3Future = makeHttpGetRequest(url3, book3Delay);
    print("after request 2");
    print("reading Moby Dick: \n${snippet(httpResp2.body)}");
    print("");
    return req3Future;
  }).then((httpResp3) {
    print("url3 response3: ${httpResp3.statusCode}, delay=$prevDelay");
    var book3Len = httpResp3.body.length;
    totalLens += book3Len;
    var book4Delay = Duration(milliseconds: book3Len % 500);
    prevDelay = book4Delay;
    var req4Future = makeHttpGetRequest(url4, book4Delay);
    print("after request 3");
    print("reading Edgar Poe: \n${snippet(httpResp3.body)}");
    print("");
    return req4Future;
  }).then((httpResp4) {
    print("url4 response4: ${httpResp4.statusCode}, delay=$prevDelay");
    var book4Len = httpResp4.body.length;
    totalLens += book4Len;
    var book5Delay = Duration(milliseconds: book4Len % 500);
    prevDelay = book5Delay;
    var req5Future = makeHttpGetRequest(url5, book5Delay);
    print("after request 4");
    print("reading Vinnie the Pooh: \n${snippet(httpResp4.body)}");
    print("");
    return req5Future;
  }).then((httpResp5) {
    print("url5 response 5: ${httpResp5.statusCode}, delay=$prevDelay");
    var book5Len = httpResp5.body.length;
    totalLens += book5Len;
    var book6Delay = Duration(milliseconds: book5Len % 500);
    prevDelay = book6Delay;
    var req6Future = makeHttpGetRequest(url6, book6Delay);
    print("after request 5");
    print("reading Shakespeare: \n${snippet(httpResp5.body)}");
    print("");
    return req6Future;
  }).then((httpResp6) {
    print("url6 response 6: ${httpResp6.statusCode}, delay=$prevDelay");
    var book6Len = httpResp6.body.length;
    totalLens += book6Len;
    var book7Delay = Duration(milliseconds: book6Len % 500);
    prevDelay = book7Delay;
    var req7Future = makeHttpGetRequest(url7, book7Delay);
    print("after request 6");
    print("reading Kafka Metamorphosis: \n${snippet(httpResp6.body)}");
    print("");
    return req7Future;
  }).then((httpResp7) {
    print("url7 response 7: ${httpResp7.statusCode}, delay=$prevDelay");
    var book7Len = httpResp7.body.length;
    totalLens += book7Len;
    print('total lens: $totalLens');
    print("after request 7");
    print("reading Dorian Grey: \n${snippet(httpResp7.body)}");
    print("");
  });

  var a = 10;
  var b = 20;
  var c = a + b;
  print("c = $c");
  print("ending main ....");
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
