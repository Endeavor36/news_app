import 'package:http/http.dart' as http;
import 'dart:convert';

String newsUrl = 'https://api.first.org/data/v1/news';

Future<dynamic> getNews() async {
  http.Response response = await http.get(Uri.parse(newsUrl));

  if (response.statusCode == 200) {
    var body = response.body;
    return jsonDecode(body);
  } else {
    print('Failed to load data.');
  }
}
