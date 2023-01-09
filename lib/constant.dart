import 'dart:convert';
import 'package:http/http.dart' as http;
// ignore: constant_identifier_names

const String API_KEY = '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';

class AppiService {
  static Future<String> getAItext(String text, selectedValue) async {
    Map<String, dynamic> getText = {};
    Map<String, String> header = {
      "Content-Type": "application/json",
      "Authorization": 'Bearer $API_KEY',
    };
    if (selectedValue == 'Spelling correct') {
      print('in spelling ');
      String baseUrl = 'https://api.openai.com/v1/edits';

      var response = await http.post(
        Uri.parse(baseUrl),
        headers: header,
        body: jsonEncode(
          {
            "model": "text-davinci-edit-001",
            "input": text,
            "instruction": "Fix the spelling mistakes"
          },
        ),
      );

      if (response.statusCode == 200) {
        getText = jsonDecode(response.body);
        print(getText['choices']);
        return getText['choices'][0]['text'];
      } else {
        print('Faild to load data');
      }
      return getText['choices'][0]['text'];
    } else if (selectedValue == 'Search IMG') {
      print('in search IMG');
      String baseUrl = 'https://api.openai.com/v1/images/generations';

      var response = await http.post(
        Uri.parse(baseUrl),
        headers: header,
        body: jsonEncode(
          {"prompt": text, "n": 2, "size": "256x256"},
        ),
      );

      if (response.statusCode == 200) {
        getText = jsonDecode(response.body);
        print(getText);
        return getText['data'][0]['url'];
      } else {
        print('Faild to load data');
      }
      return getText['data'][0]['url'];
    } else {
      print(selectedValue);
      String baseUrl = 'https://api.openai.com/v1/completions';
      print('in search Completions');

      var response = await http.post(
        Uri.parse(baseUrl),
        headers: header,
        body: jsonEncode(
          {
            "model": "text-davinci-003",
            "prompt": text,
            "max_tokens": 100,
            "temperature": 0,
            "top_p": 1,
            "frequency_penalty": 0.0,
            "presence_penalty": 0.0,
            "stream": false,
            "logprobs": null,
            "stop": ["Human", "AI"]
          },
        ),
      );

      if (response.statusCode == 200) {
        getText = jsonDecode(response.body);
        print(getText);
        return getText['choices'][0]['text'];
      } else {
        print('Faild to load data');
      }
      return getText['choices'][0]['text'];
    }
  }
}
