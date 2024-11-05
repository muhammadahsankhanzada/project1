abstract class BaseApiServices {
  // Get api abstract method
  Future<dynamic> getApiResponse(String url);

  // Post api abstract method
  Future<dynamic> postApiResponse(String url, dynamic data);
}
