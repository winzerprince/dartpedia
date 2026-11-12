import 'dart:io';

import 'package:http/http.dart' as http;

const version = "1.0.0";

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    print("Hello dart!");
  } else if (arguments.first == "version") {
    print("cli version: $version");
  } else if (arguments.first == 'wikipedia') {
    final List<String>? inputArgs = arguments.length > 1
        ? arguments.sublist(1)
        : null;
    searchWikipedia(inputArgs);
  } else {
    printUsage();
  }
}

void printUsage() {
  print(
    "The following commands are valid: 'help', 'version', 'search <ARTICLE-TITLE>'",
  );
}

void searchWikipedia(List<String>? arguments) async {
  final String? articleTitle;
  if (arguments == null || arguments.isEmpty) {
    print("Please provide and article title.");
    final String? inputFromStdin = stdin.readLineSync();
    if (inputFromStdin == null || inputFromStdin.isEmpty) {
      print("No article title given");
      return;
    }
    articleTitle = inputFromStdin;
  } else {
    articleTitle = arguments.join(' ');
  }

  print('Looking up articles about "$articleTitle". Please wait.');

  final results = await getWikipedia(articleTitle);
  print(results);
}

Future<String> getWikipedia(String articleTitle) async {
  final url = Uri.https(
    'en.wikipedia.org',
    '/api/rest_v1/page/summary/$articleTitle',
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    return response.body;
  }

  return 'Error: Failed to fetch article: $articleTitle. Status code: $response.statusCode';
}
