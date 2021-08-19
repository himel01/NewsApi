import 'package:news_api/models/model_news_api.dart';
import 'package:http/http.dart' as http;

class NewsApiService {
  final String companyNews =
      "https://newsapi.org/v2/everything?q=Apple&from=2021-08-04&sortBy=popularity&apiKey=";
  final String countryNews =
      "https://newsapi.org/v2/top-headlines?country=us&apiKey=";
  final String specificNews =
      "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=";
  final String apiKey = "4b851add8ba24e5cbf6e1bfeb5bd1236";

  Future<ModelNewsApi> fetchNews(http.Client client) async {
    final response = await http.get(
      Uri.parse(companyNews + apiKey),
    );
    if (response.statusCode == 200) {
      return ModelNewsApi.fromJson(response.body);
    } else {
      throw Exception('Failed to load album');
    }
  }
}
