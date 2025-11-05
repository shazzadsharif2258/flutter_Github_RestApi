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
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: () => Get.toNamed(
          RoutesNames.detailsView,
          arguments: repo,
        ),
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                repo.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              if (repo.description != null)
                Text(
                  repo.description!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 12),
                ),
              const Spacer(),
              Wrap(
                spacing: 8,
                children: [
                  if (repo.language != null)
                    Chip(
                      label: Text(repo.language!),
                      materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                    ),
                  Chip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          size: 14,
                          color: Colors.amber,
                        ),
                        SizedBox(width: 2),
                        Text('${repo.stargazersCount}'),
                      ],
                    ),
                    materialTapTargetSize:
                        MaterialTapTargetSize.shrinkWrap,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
