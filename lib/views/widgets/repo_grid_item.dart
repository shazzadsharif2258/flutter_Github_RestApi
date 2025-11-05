import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_restapi/model/repository_model/repo_model.dart';
import 'package:github_restapi/routes/routes_names.dart';

class RepoGridItem extends StatelessWidget {
  final RepoModel repo;
  final VoidCallback onTap;
  const RepoGridItem({
    super.key,
    required this.repo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(4),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => Get.toNamed(
          RoutesNames.detailsView,
          arguments: repo,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [
              // Header section
              Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    repo.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (repo.description != null &&
                      repo.description!.isNotEmpty)
                    Text(
                      repo.description!,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        color: theme.hintColor,
                        height: 1.3,
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 8),

              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: [
                  if (repo.language != null &&
                      repo.language!.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: theme.primaryColor.withAlpha(
                          1,
                        ),
                        borderRadius: BorderRadius.circular(
                          4,
                        ),
                      ),
                      child: Text(
                        repo.language!,
                        style: TextStyle(
                          fontSize: 10,
                          color: theme.primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber.withAlpha(1),
                      borderRadius: BorderRadius.circular(
                        4,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          size: 12,
                          color: Colors.amber[700],
                        ),
                        const SizedBox(width: 2),
                        Text(
                          _formatCount(
                            repo.stargazersCount,
                          ),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.amber[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(
                        4,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.call_split,
                          size: 12,
                          color: Colors.green[700],
                        ),
                        const SizedBox(width: 2),
                        Text(
                          _formatCount(repo.forksCount),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.green[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatCount(int count) {
    if (count < 1000) return count.toString();
    if (count < 1000000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return '${(count / 1000000).toStringAsFixed(1)}m';
  }
}
