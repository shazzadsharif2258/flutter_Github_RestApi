import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:github_restapi/data/response/status.dart';
import 'package:github_restapi/resources/components/error_widget_view.dart';
import 'package:github_restapi/resources/components/loading_widget.dart';
import 'package:github_restapi/viewModel/login_controller.dart';
import 'package:github_restapi/viewModel/repo_controller.dart';
import 'package:github_restapi/viewModel/theme_controller.dart';
import 'package:github_restapi/views/widgets/repo_filter_sheet.dart';
import 'package:github_restapi/views/widgets/repo_list.dart';
import 'package:github_restapi/views/widgets/user_profile_card.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _c = Get.put(RepoController());
  final _themeC = Get.find<ThemeController>();
  final _userC = Get.find<LoginController>();
  final String username = Get.arguments as String;

  @override
  void initState() {
    _c.getReposApi(username);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$username \'s Repositories',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                _c.toggleView();
              },
              icon: _c.isGird.value
                  ? Icon(Icons.list)
                  : Icon(Icons.grid_view),
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) =>
                _c.sortRepositories(value),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'name',
                child: Text('Sort by Name'),
              ),
              const PopupMenuItem(
                value: 'stars',
                child: Text('Sort by Stars'),
              ),
              const PopupMenuItem(
                value: 'updated',
                child: Text('Sort by Updated'),
              ),
            ],
          ),
          IconButton(
            tooltip: 'Filter',
            icon: const Icon(Icons.filter_list),
            onPressed: () => RepoFilterSheet.show(context),
          ),
          Obx(
            () => IconButton(
              onPressed: () {
                _themeC.toggleTheme();
              },
              icon: _themeC.isDarkMode.value
                  ? Icon(Icons.dark_mode)
                  : Icon(Icons.brightness_6),
            ),
          ),
        ],
      ),
      body: Obx(() {
        final status = _c.rxRequestStatus.value;
        if (status == Status.LOADING) {
          return const LoadingWidget();
        } else if (status == Status.FAILED) {
          return ErrorWidgetView(
            errorMessage: _c.error.value,
            onRetry: () => _c.getReposApi(username),
          );
        } else {
          return Column(
            children: [
              UserProfileCard(user: _userC.user.value),
              SizedBox(height: 18),
              Expanded(child: RepoList()),
            ],
          );
        }
      }),
    );
  }
}
