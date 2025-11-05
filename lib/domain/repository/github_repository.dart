import 'package:github_restapi/data/network/network_api_service.dart';
import 'package:github_restapi/model/repository_model/repo_model.dart';
import 'package:github_restapi/model/userModel/user_model.dart';
import 'package:github_restapi/resources/app_urls/app_urls.dart';

class GithubRepository {
  final _api = NetworkApiService();

  Future<UserModel> getUser(String userName) async {
    dynamic res = await _api.getApi(
      AppUrls.getUserUrl(userName),
    );
    return UserModel.fromJson(res);
  }

  Future<List<RepoModel>> getUserRepos(
    String username,
  ) async {
    dynamic res = await _api.getApi(
      AppUrls.getUserReposUrl(username),
    );
    final data = (res as List)
        .map((e) => RepoModel.fromJson(e))
        .toList();
    return data;
  }
}
