class AppUrls {
  static const String baseUrl = 'https://api.github.com';

  static String getUserUrl(String username) {
    return '$baseUrl/users/$username';
  }

  static String getUserReposUrl(String username) {
    return '$baseUrl/users/$username/repos';
  }
}
