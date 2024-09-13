import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../models/article.dart';
import '../models/memo.dart';

class ApiClient {
  static const String baseUrl = 'http://localhost:8080/api';
  static const Map<String, String> headers = {
    'Content-Type': 'application/json'
  };

  Future<String?> _getSessionToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('session_token');
  }

  Future<void> _setSessionToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('session_token', token);
  }

  Future<User> signUp(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/signup'),
      headers: headers,
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final user = User.fromJson(jsonResponse['user']);
      await _setSessionToken(response.headers['set-cookie'] ?? '');
      return user;
    } else {
      throw Exception('ユーザー登録に失敗しました');
    }
  }

  Future<User> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/signin'),
      headers: headers,
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final user = User.fromJson(jsonDecode(response.body));
      await _setSessionToken(response.headers['set-cookie'] ?? '');
      return user;
    } else {
      throw Exception('Failed to sign in');
    }
  }

  Future<List<Article>> getLatestArticles() async {
    final token = await _getSessionToken();
    final response = await http.get(
      Uri.parse('$baseUrl/articles/latest'),
      headers: {...headers, 'Cookie': 'session=$token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load latest articles');
    }
  }

  Future<Article> getArticle(String articleId) async {
    final token = await _getSessionToken();
    final response = await http.get(
      Uri.parse('$baseUrl/articles/$articleId'),
      headers: {...headers, 'Cookie': 'session=$token'},
    );

    if (response.statusCode == 200) {
      return Article.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load article');
    }
  }

  Future<List<Article>> getRecommendedArticles() async {
    final token = await _getSessionToken();
    final response = await http.get(
      Uri.parse('$baseUrl/articles/recommended'),
      headers: {...headers, 'Cookie': 'session=$token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load recommended articles');
    }
  }

  Future<List<Article>> searchArticles(String query) async {
    final token = await _getSessionToken();
    final response = await http.get(
      Uri.parse('$baseUrl/articles/search?q=$query'),
      headers: {...headers, 'Cookie': 'session=$token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to search articles');
    }
  }

  Future<void> createMemo(String articleId, String content) async {
    final token = await _getSessionToken();
    final response = await http.post(
      Uri.parse('$baseUrl/memo'),
      headers: {...headers, 'Cookie': 'session=$token'},
      body: jsonEncode({
        'article': {'id': articleId},
        'content': content,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create memo');
    }
  }

  Future<Memo> getMemo(String articleId) async {
    final token = await _getSessionToken();
    final response = await http.get(
      Uri.parse('$baseUrl/memo/$articleId'),
      headers: {...headers, 'Cookie': 'session=$token'},
    );

    if (response.statusCode == 200) {
      return Memo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load memo');
    }
  }

  Future<void> updateMemo(String articleId, String content) async {
    final token = await _getSessionToken();
    final response = await http.put(
      Uri.parse('$baseUrl/memo/$articleId'),
      headers: {...headers, 'Cookie': 'session=$token'},
      body: jsonEncode({'content': content}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update memo');
    }
  }

  Future<void> deleteMemo(String articleId) async {
    final token = await _getSessionToken();
    final response = await http.delete(
      Uri.parse('$baseUrl/memo/$articleId'),
      headers: {...headers, 'Cookie': 'session=$token'},
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete memo');
    }
  }

  Future<List<Memo>> getMemoList() async {
    final token = await _getSessionToken();
    final response = await http.get(
      Uri.parse('$baseUrl/memo/list'),
      headers: {...headers, 'Cookie': 'session=$token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Memo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load memo list');
    }
  }
}
