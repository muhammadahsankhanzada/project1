import 'dart:convert';
import 'dart:io';
import 'package:project1/Data/Network/base_api_services.dart';
import 'package:project1/Data/app_exceptions.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices {
  // Get Api Method
  @override
  Future getApiResponse(String url) async {
    dynamic responseJson;
    try {
      final response =
          await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  // Post Api Method
  @override
  Future postApiResponse(String url, dynamic data) async {
    dynamic responseJson;
    try {
      http.Response response = await http
          .post(
            Uri.parse(url),
            body: data,
          )
          .timeout(Duration(seconds: 10));

      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  // Method to return the api response for all get, post requests etc
  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        return BadRequestException(response.body);
      case 404:
        return BadRequestException(response.body);
      case 500:
        return UnauthorizedException(response.body);

      default:
        return FetchDataException(
            'Error while communicating with the Server With Status Code ${response.statusCode}');
    }
  }
}
