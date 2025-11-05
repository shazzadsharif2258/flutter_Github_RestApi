import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_restapi/model/repository_model/repo_model.dart';
import 'package:github_restapi/routes/routes_names.dart';
import 'package:github_restapi/viewModel/repo_controller.dart';
import 'package:github_restapi/views/widgets/repo_grid_item.dart';
import 'package:github_restapi/views/widgets/repo_list_item.dart';

class RepoList extends StatelessWidget {
  RepoList({super.key});

  final _repoController = Get.find<RepoController>();
  final String username = Get.arguments as String;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final repos = _repoController.filteredRepoList;

      if (_repoController.isGird.value) {
        return RefreshIndicator(
          onRefresh: () =>
              _repoController.getReposApi(username),

          child: GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.2,
                ),
            itemCount: repos.length,
            itemBuilder: (context, index) => RepoGridItem(
              repo: repos[index],
              onTap: () => _onRepoTap(repos[index]),
            ),
          ),
        );
      } else {
        return RefreshIndicator(
          onRefresh: () =>
              _repoController.getReposApi(username),
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: repos.length,
            itemBuilder: (context, index) => RepoListItem(
              repo: repos[index],
              onTap: () => _onRepoTap(repos[index]),
            ),
          ),
        );
      }
    });
  }

  void _onRepoTap(RepoModel repo) {
    Get.toNamed(RoutesNames.detailsView, arguments: repo);
  }
}
