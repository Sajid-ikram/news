class AppUrls {
  static const String baseUrl = "https://newsapi.org/v2/";
  static const String topHeadlinesEndpoint = "${baseUrl}top-headlines";


  static String topHeadlinesUrl({required String apiKey, String country = 'us', String category = 'business'}) {
    return "$topHeadlinesEndpoint?country=$country&category=$category&apiKey=$apiKey";
  }
}