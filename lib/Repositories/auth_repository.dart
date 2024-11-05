import 'package:project1/Data/Network/base_api_services.dart';
import 'package:project1/Data/Network/network_api_services.dart';
import 'package:project1/Utils/app_urls.dart';

class AuthRepository {
  BaseApiServices _apiServices = NetworkApiServices();

  // This method will get data from auth_provider and send to server using post request
  Future<dynamic> loginApi(dynamic data) async {
    try {
      final response = _apiServices.postApiResponse(AppUrls.login, data);
      return response;
    } catch (error) {
      throw error;
    }
  }
}
