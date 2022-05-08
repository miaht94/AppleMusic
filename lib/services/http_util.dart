import 'package:apple_music/constant.dart';
import 'package:apple_music/models/UserModel.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

class HttpUtil {
  static final HttpUtil httpUtilSingleton = HttpUtil._internal();
  factory HttpUtil() {  
    return httpUtilSingleton;
  }
  HttpUtil._internal() {
    dio.httpClientAdapter = isTestingMode ? GetIt.I.get<HttpClientAdapter>() : DefaultHttpClientAdapter();
  }
  Dio dio = Dio();

  Future<UserModel?> fetchUserModel(String appToken) async {
    try {
      final Response<UserModel> userModelFuture = await dio.get('$SV_HOSTNAME/$MY_PROFILE_PATH', queryParameters: {
      'app_token': appToken
    });
    return userModelFuture.data;
    } catch(e) {
      return null;
    } 
  }
}