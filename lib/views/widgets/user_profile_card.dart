import 'package:flutter/material.dart';
import 'package:github_restapi/model/userModel/user_model.dart';
import 'package:github_restapi/theme/app_text_style.dart';

class UserProfileCard extends StatelessWidget {
  final UserModel user;
  const UserProfileCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: user.avatarUrl != null
                  ? NetworkImage(user.avatarUrl!)
                  : null,
              child: user.avatarUrl == null
                  ? const Icon(Icons.person, size: 40)
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name ??
                        user.login ??
                        'Unkown User',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (user.bio != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      user.bio!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 16,
                    children: [
                      _buildInfoItem(
                        Icons.folder,
                        'Repos: ${user.publicRepos ?? 0}',
                      ),
                      _buildInfoItem(
                        Icons.people,
                        'Followers: ${user.followers ?? 0}',
                      ),
                      _buildInfoItem(
                        Icons.person_add,
                        'Following: ${user.following ?? 0}',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16),
        const SizedBox(width: 4),
        Text(text),
      ],
    );
  }
}
