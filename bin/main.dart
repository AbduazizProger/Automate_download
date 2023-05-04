import 'dart:convert';
import 'dart:io';

void main() async {
  String url = 'https://api.alquran.cloud/v1/surah/';
  for (int i = 2; i < 115; i++) {
    final httpClient = HttpClient();
    try {
      final request = await httpClient.getUrl(Uri.parse(url + i.toString()));
      final response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        final responseBody = await response.transform(utf8.decoder).join();
        final jsonData = jsonDecode(responseBody);

        final file = File('json/surah_$i.json');
        await file.writeAsString(jsonEncode(jsonData));

        print('Data downloaded and saved to surah_$i.json file.');
      } else {
        print('Error: Status code ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      httpClient.close();
    }
  }
}
