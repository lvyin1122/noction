import 'dart:convert';
import 'dart:io';
import 'dart:developer' as developer;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:noction/failure_model.dart';
import 'package:http/http.dart' as http;
import 'package:noction/screens/reading/reading_model.dart';

class ReadingRepository {
  static const String _baseUrl = 'https://api.notion.com/v1/';

  final http.Client _client;

  ReadingRepository({http.Client? client}) : _client = client ?? http.Client();

  void dispose() {
    _client.close();
  }

  Future<List<ReadingRecord>> getItems() async {
    try {
      final url =
          '${_baseUrl}databases/${dotenv.env['NOTION_DB_READING']}/query';

      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['NOTION_API_KEY']}',
          'Notion-Version': '2022-02-22',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        // developer.log("200 Request Success", name: 'noction');
        final data = jsonDecode(response.body) as Map<String, dynamic>;

        return (data['results'] as List)
            .map((e) => ReadingRecord.fromMap(e))
            .toList()
          ..sort((a, b) => b.createdTime.compareTo(a.createdTime));
      } else {
        throw const Failure(message: 'Something went wrong!');
      }
    } catch (_) {
      throw const Failure(message: 'Something went wrong!');
    } finally {
      dispose();
    }
  }

  Future<void> addItem(ReadingRecord data) async {
    try {
      final url = '${_baseUrl}pages/';
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['NOTION_API_KEY']}',
          'Notion-Version': '2022-02-22',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'parent': {
            'database_id': '${dotenv.env['NOTION_DB_READING']}',
          },
          "properties": {
            "Name": {
              "title": [
                {
                  "text": {"content": data.name}
                }
              ]
            },
            "Type": {
              "select": {"name": data.type}
            },
            "Status": {
              "select": {"name": data.status}
            },
            "Score": {"number": 2.5}
          }
        }),
      );
    } catch (_) {
      throw const Failure(message: 'Something went wrong!');
    } finally {}
  }

  Future<void> updateItem(ReadingRecord data) async {
    try {
      final url = '${_baseUrl}pages/${data.id}';
      final response = await http.patch(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['NOTION_API_KEY']}',
          'Notion-Version': '2022-02-22',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          "properties": {
            "Name": {
              "title": [
                {
                  "text": {"content": data.name}
                }
              ]
            },
            "Type": {
              "select": {"name": data.type}
            },
            "Status": {
              "select": {"name": data.status}
            },
            "Score": {"number": 2.5}
          }
        }),
      );
    } catch (_) {
      throw const Failure(message: 'Something went wrong!');
    } finally {}
  }
}
