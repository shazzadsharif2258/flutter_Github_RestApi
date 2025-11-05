class RepositoryEntity {
  final String? name;
  final String? description;
  final String? language;
  final int? stargazersCount;
  final int? forksCount;
  final DateTime? updatedAt;

  RepositoryEntity({
    this.name,
    this.description,
    this.language,
    this.stargazersCount,
    this.forksCount,
    this.updatedAt,
  });
}
