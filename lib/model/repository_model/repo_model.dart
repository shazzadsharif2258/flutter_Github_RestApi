// ignore_for_file: public_member_api_docs, sort_constructors_first
class RepoModel {
  final int id;
  final String name;
  final String fullName;
  final String htmlUrl;
  final String? description;
  final int stargazersCount;
  final int watchersCount;
  final String? language;
  final int forksCount;
  final int openIssuesCount;
  final String defaultBranch;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Owner owner;
  final String? homepage;
  final int? size;

  RepoModel({
    required this.id,
    required this.name,
    required this.fullName,
    required this.htmlUrl,
    required this.description,
    required this.stargazersCount,
    required this.watchersCount,
    required this.language,
    required this.forksCount,
    required this.openIssuesCount,
    required this.defaultBranch,
    required this.createdAt,
    required this.updatedAt,
    required this.owner,
    this.homepage,
    this.size,
  });

  factory RepoModel.fromJson(Map<String, dynamic> json) {
    return RepoModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      fullName: json['full_name'] ?? '',
      htmlUrl: json['html_url'] ?? '',
      description: json['description'],
      stargazersCount: json['stargazers_count'] ?? 0,
      watchersCount: json['watchers_count'] ?? 0,
      language: json['language'],
      forksCount: json['forks_count'] ?? 0,
      openIssuesCount: json['open_issues_count'] ?? 0,
      defaultBranch: json['default_branch'] ?? '',
      homepage: json['homepage'],
      size: json['size'],
      createdAt:
          DateTime.tryParse(json['created_at'] ?? '') ??
          DateTime(1970),
      updatedAt:
          DateTime.tryParse(json['updated_at'] ?? '') ??
          DateTime(1970),
      owner: Owner.fromJson(json['owner'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'full_name': fullName,
      'html_url': htmlUrl,
      'description': description,
      'stargazers_count': stargazersCount,
      'watchers_count': watchersCount,
      'language': language,
      'forks_count': forksCount,
      'open_issues_count': openIssuesCount,
      'default_branch': defaultBranch,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'owner': owner.toJson(),
    };
  }
}

class Owner {
  final String login;
  final int id;
  final String avatarUrl;
  final String htmlUrl;

  Owner({
    required this.login,
    required this.id,
    required this.avatarUrl,
    required this.htmlUrl,
  });

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(
      login: json['login'] ?? '',
      id: json['id'] ?? 0,
      avatarUrl: json['avatar_url'] ?? '',
      htmlUrl: json['html_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'id': id,
      'avatar_url': avatarUrl,
      'html_url': htmlUrl,
    };
  }
}
