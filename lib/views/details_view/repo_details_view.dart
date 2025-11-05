import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_restapi/model/repository_model/repo_model.dart';
import 'package:github_restapi/resources/components/custom_button.dart';
import 'package:github_restapi/theme/app_colors.dart';

import 'package:github_restapi/views/widgets/details_items.dart';
import 'package:url_launcher/url_launcher.dart';

class RepoDetailsView extends StatelessWidget {
  const RepoDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final RepoModel repo = Get.arguments;
    final theme = Theme.of(context);

    String formatDate(DateTime date) {
      return '${date.day}/${date.month}/${date.year}';
    }

    Future<void> launchUrlSafe(String? url) async {
      if (url == null || url.trim().isEmpty) {
        Get.snackbar('Error', 'No URL provided');
        return;
      }

      final fixed =
          url.startsWith('http://') ||
              url.startsWith('https://')
          ? url
          : 'https://$url';

      final uri = Uri.parse(fixed);

      final ok = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );

      if (!ok) {
        Get.snackbar('Error', 'Could not launch URL');
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Repository Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.open_in_new),
            onPressed: () => launchUrlSafe(repo.htmlUrl),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.book, color: theme.primaryColor),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    repo.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            if (repo.description != null &&
                repo.description!.isNotEmpty) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                    255,
                    151,
                    96,
                    96,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  repo.description!,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.inversePrimary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                children: [
                  _buildStatItem(
                    Icons.star,
                    '${repo.stargazersCount}',
                    'Stars',
                  ),
                  _buildStatItem(
                    Icons.call_split,
                    '${repo.forksCount}',
                    'Forks',
                  ),
                  _buildStatItem(
                    Icons.bug_report,
                    '${repo.openIssuesCount}',
                    'Issues',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Repository Info',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: theme.primaryColor,
              ),
            ),
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.inversePrimary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  DetailsItems(
                    label: 'Full Name',
                    value: repo.fullName,
                  ),
                  const SizedBox(height: 8),
                  DetailsItems(
                    label: 'Language',
                    value: repo.language ?? 'Not specified',
                  ),
                  const SizedBox(height: 8),
                  DetailsItems(
                    label: 'Size',
                    value: '${repo.size} KB',
                  ),
                  const SizedBox(height: 8),
                  DetailsItems(
                    label: 'Created',
                    value: formatDate(repo.createdAt),
                  ),
                  const SizedBox(height: 8),
                  DetailsItems(
                    label: 'Updated',
                    value: formatDate(repo.updatedAt),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Column(
              children: [
                CustomButton(
                  loading: false,
                  title: 'Visit Homepage',
                  height: 50,
                  width: double.infinity,
                  textColor: Colors.white,
                  filled: true,
                  onPress: () =>
                      launchUrlSafe(repo.homepage),
                ),
                const SizedBox(height: 12),
                if (repo.homepage != null &&
                    repo.homepage!.isNotEmpty)
                  CustomButton(
                    loading: false,
                    title: 'Visit Homepage',
                    height: 50,
                    width: double.infinity,
                    textColor: theme.primaryColor,
                    filled: false,
                    onPress: () =>
                        launchUrlSafe(repo.homepage),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    IconData icon,
    String value,
    String label,
  ) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Colors.blue),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.primaryDeep,
          ),
        ),
      ],
    );
  }
}
