import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_restapi/viewModel/repo_controller.dart';

class RepoFilterSheet extends StatefulWidget {
  const RepoFilterSheet({super.key});

  static void show(BuildContext context) {
    Get.bottomSheet(
      const RepoFilterSheet(),
      backgroundColor: Theme.of(
        context,
      ).scaffoldBackgroundColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
    );
  }

  @override
  State<RepoFilterSheet> createState() =>
      _RepoFilterSheetState();
}

class _RepoFilterSheetState extends State<RepoFilterSheet> {
  final RepoController _c = Get.find<RepoController>();

  final TextEditingController _minStarsCtrl =
      TextEditingController();
  final RxString _language = ''.obs;
  final Rxn<DateTime> _updatedAfter = Rxn<DateTime>();

  @override
  void dispose() {
    _minStarsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languages = _uniqueLanguages();

    return SafeArea(
      child: Padding(
        padding: MediaQuery.of(context).viewInsets.add(
          const EdgeInsets.fromLTRB(16, 16, 16, 24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Filters',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Get.back(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Obx(
              () => DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Language',
                ),
                initialValue: _language.value.isEmpty
                    ? null
                    : _language.value,
                isExpanded: true,
                items: [
                  const DropdownMenuItem(
                    value: '',
                    child: Text('Any'),
                  ),
                  ...languages.map(
                    (l) => DropdownMenuItem(
                      value: l,
                      child: Text(l),
                    ),
                  ),
                ],
                onChanged: (v) => _language.value = v ?? '',
              ),
            ),

            const SizedBox(height: 12),

            TextFormField(
              controller: _minStarsCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Min stars',
                hintText: 'e.g. 50',
              ),
            ),

            const SizedBox(height: 12),

            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: Text(
                      _updatedAfter.value == null
                          ? 'Updated after: Any'
                          : 'Updated after: ${_formatDate(_updatedAfter.value!)}',
                    ),
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.date_range),
                    label: const Text('Pick date'),
                    onPressed: () async {
                      final now = DateTime.now();
                      final first = DateTime(now.year - 10);
                      final picked = await showDatePicker(
                        context: context,
                        initialDate:
                            _updatedAfter.value ?? now,
                        firstDate: first,
                        lastDate: now,
                      );
                      if (picked != null) {
                        _updatedAfter.value = picked;
                      }
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      _c.filteredRepoList.value = List.from(
                        _c.repoList,
                      );
                      _c.sortRepositories(_c.sortBy.value);
                      Get.back();
                    },
                    child: const Text('Clear'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final minStars = int.tryParse(
                        _minStarsCtrl.text.trim(),
                      );
                      _c.applyFilters(
                        language: _language.value.isEmpty
                            ? null
                            : _language.value,
                        minStars: minStars,
                        updatedAfter: _updatedAfter.value,
                      );
                      Get.back();
                    },
                    child: const Text('Apply'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<String> _uniqueLanguages() {
    final langs = <String>{};
    for (final r in _c.repoList) {
      final l = r.language?.trim();
      if (l != null && l.isNotEmpty) langs.add(l);
    }
    final list = langs.toList()
      ..sort(
        (a, b) =>
            a.toLowerCase().compareTo(b.toLowerCase()),
      );
    return list;
  }

  String _formatDate(DateTime d) =>
      '${d.day}/${d.month}/${d.year}';
}
