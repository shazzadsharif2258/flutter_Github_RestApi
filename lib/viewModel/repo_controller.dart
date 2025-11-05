import 'package:get/get.dart';
import 'package:github_restapi/data/response/status.dart';
import 'package:github_restapi/domain/repository/github_repository.dart';
import 'package:github_restapi/model/repository_model/repo_model.dart';

class RepoController extends GetxController {
  final _api = GithubRepository();
  final rxRequestStatus = Status.LOADING.obs;
  final repoList = <RepoModel>[].obs;
  final filteredRepoList = <RepoModel>[].obs;
  final error = ''.obs;
  final isGird = false.obs;
  final sortBy = 'name'.obs;

  void setRxRequestStatus(Status value) =>
      rxRequestStatus.value = value;
  void setRepoList(List<RepoModel> value) =>
      repoList.value = value;
  void setError(String value) => error.value = value;

  Future<void> getReposApi(String username) async {
    setRxRequestStatus(Status.LOADING);
    setError('');

    try {
      final repos = await _api.getUserRepos(username);

      if (repos.isEmpty) {
        setRepoList([]);
        filteredRepoList.value = [];
        setError('No repositories found for this user');
        setRxRequestStatus(Status.FAILED);
      } else {
        setRepoList(repos);
        filteredRepoList.value = List.from(repos);
        sortRepositories(sortBy.value);
        setRxRequestStatus(Status.CONNECTED);
      }
    } catch (e) {
      setError(_getErrorMessage(e));
      setRxRequestStatus(Status.FAILED);
    }
  }

  String _getErrorMessage(dynamic error) {
    final errorString = error.toString();

    if (errorString.contains('404')) {
      return 'User not found';
    } else if (errorString.contains('403')) {
      return 'API rate limit exceeded. Please try again later.';
    } else if (errorString.contains('401')) {
      return 'Unauthorized access';
    } else if (errorString.contains('500')) {
      return 'GitHub server error';
    } else if (errorString.contains('socket') ||
        errorString.contains('Internet')) {
      return 'No internet connection';
    } else if (errorString.contains('timeout')) {
      return 'Request timeout. Please try again.';
    } else {
      return 'Failed to load repositories: $errorString';
    }
  }

  void sortRepositories(String sortType) {
    sortBy.value = sortType;
    switch (sortType) {
      case 'name':
        filteredRepoList.sort(
          (a, b) => a.name.compareTo(b.name),
        );
        break;
      case 'stars':
        filteredRepoList.sort(
          (a, b) => b.stargazersCount.compareTo(
            a.stargazersCount,
          ),
        );
        break;
      case 'updated':
        filteredRepoList.sort(
          (a, b) => b.updatedAt.compareTo(a.updatedAt),
        );
        break;
    }
  }

  void applyFilters({
    String? language,
    int? minStars,
    DateTime? updatedAfter,
  }) {
    var temp = List<RepoModel>.from(repoList);
    if (language != null && language.isNotEmpty) {
      temp = temp
          .where(
            (r) =>
                (r.language ?? '').toLowerCase() ==
                language.toLowerCase(),
          )
          .toList();
    }
    if (minStars != null) {
      temp = temp
          .where((r) => (r.stargazersCount) >= minStars)
          .toList();
    }
    if (updatedAfter != null) {
      temp = temp
          .where((r) => r.updatedAt.isAfter(updatedAfter))
          .toList();
    }
    filteredRepoList.value = temp;
    sortRepositories(sortBy.value);
  }

  void toggleView() {
    isGird.value = !isGird.value;
  }
}
