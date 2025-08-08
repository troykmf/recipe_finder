import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:recipe_finder/core/error/exceptions.dart';
import 'package:recipe_finder/core/network/api_constants.dart';

class NetworkClient {
  final http.Client client;

  NetworkClient(this.client);

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? queryParams,
  }) async {
    try {
      final uri = Uri.parse(
        '${ApiConstants.baseUrl}$endpoint',
      ).replace(queryParameters: queryParams);
      final response = await client
          .get(uri)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        try {
          final jsonResponse =
              json.decode(response.body) as Map<String, dynamic>;
          if (jsonResponse['meals'] == null &&
              endpoint.contains(ApiConstants.searchByName)) {
            throw const NoResultsException(
              message: 'No recipes found for the given query',
            );
          }
          if (jsonResponse is! Map<String, dynamic>) {
            throw const ServerException(
              message: 'Invalid response format',
              statusCode: 200,
            );
          }
          return jsonResponse;
        } catch (e) {
          if (e is FormatException) {
            throw const ServerException(
              message: 'Failed to parse response',
              statusCode: 200,
            );
          }
          rethrow;
        }
      } else {
        throw ServerException(
          message: 'Server error: ${response.reasonPhrase}',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      throw const NetworkException(message: 'No internet connection');
    } on TimeoutException {
      throw const NetworkException(message: 'Request timed out');
    } catch (e) {
      throw ServerException(message: 'Unexpected error: $e');
    }
  }

  void dispose() {
    client.close();
  }
}
