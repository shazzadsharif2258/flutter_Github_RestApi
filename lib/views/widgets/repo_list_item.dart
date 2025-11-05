import 'package:flutter/material.dart';
import 'package:github_restapi/model/repository_model/repo_model.dart';

class RepoListItem extends StatelessWidget {
  final RepoModel repo;
  final VoidCallback onTap;

  const RepoListItem({
    super.key,
    required this.repo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                repo.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),

              if (repo.description != null &&
                  repo.description!.isNotEmpty)
                Column(
                  children: [
                    Text(
                      repo.description!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),

              Row(
                children: [
                  if (repo.language != null &&
                      repo.language!.isNotEmpty) ...[
                    _buildStatItem(
                      Icons.code,
                      repo.language!,
                    ),
                    const SizedBox(width: 16),
                  ],

                  _buildStatItem(
                    Icons.star,
                    '${repo.stargazersCount}',
                  ),
                  const SizedBox(width: 16),

                  _buildStatItem(
                    Icons.call_split,
                    '${repo.forksCount}',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
