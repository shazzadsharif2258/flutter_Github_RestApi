class UserEntity {
  final String? login;
  final String? avatarUrl;
  final String? name;
  final String? bio;
  final int? publicRepos;
  final int? followers;
  final int? following;

  UserEntity({
    this.login,
    this.avatarUrl,
    this.name,
    this.bio,
    this.publicRepos,
    this.followers,
    this.following,
  });
}
