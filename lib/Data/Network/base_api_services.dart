abstract class BaseApiServices {
  // Get api method
  Future<dynamic> getApiResponse(String url);

  // Post api method
  Future<dynamic> postApiResponse(String url, dynamic data);
}
