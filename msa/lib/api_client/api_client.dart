import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl = 'https://myfootballnewsapp.uk/';
  final String authToken;
  final Map<String, dynamic> cache = HashMap<String, dynamic>();

  ApiClient.free() : authToken = '';
  ApiClient({required this.authToken});

  Future<dynamic> getLinks({int offset = 0}) async {
    final endpoint = 'https://myfootballnewsapp.uk/api/links?offset=$offset';
    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      // If the request is successful, parse the response body
      return json.decode(response.body);
    } else {
      // If the request fails, throw an exception or handle the error accordingly
      throw Exception('Failed to load links');
    }
  }

  Future<dynamic> getLabels() async {
    const endpoint = 'api/labels';
    return _getCachedOrFetch(endpoint);
  }

  Future<dynamic> authPost(String endpoint, Map<String, dynamic> body) async {
    return _handleResponse(await http.post(
      Uri.parse('$baseUrl/$endpoint/'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(body),
    ));
  }

  Future<dynamic> get(String endpoint) async {
    return _getCachedOrFetch('$baseUrl/$endpoint/');
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    return _handleResponse(await http.post(
      Uri.parse('$baseUrl/$endpoint/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode(body),
    ));
  }

  Future<dynamic> _getCachedOrFetch(String endpoint) async {
    if (cache.containsKey(endpoint)) {
      return cache[endpoint];
    } else {
      final response = await http.get(
        Uri.parse(baseUrl + endpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken',
        },
      );

      final data = _handleResponse(response);
      cache[endpoint] = data;
      return data;
    }
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return json.decode(response.body);
    } else {
      return response.statusCode;
    }
  }
}
