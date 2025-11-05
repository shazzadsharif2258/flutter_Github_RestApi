import 'package:github_restapi/data/network/network_api_service.dart';
import 'package:github_restapi/model/userModel/user_model.dart';
import 'package:github_restapi/resources/app_urls/app_urls.dart';

class GithubRepository {
  final _api = NetworkApiService();

  Future<UserModel> getUser(String userName) async {
    try {
      dynamic res = await _api.getApi(
        AppUrls.getUserUrl(userName),
      );
      return UserModel.fromJson(res);
    } catch (e) {
      rethrow;
    }
  }
}
