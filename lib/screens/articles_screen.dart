import 'package:flutter/material.dart';
import '../widgets/article_card.dart';
import '../screens/webview_screen.dart';
import '../api/api_client.dart';
import '../models/article.dart';

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({super.key});

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  final ApiClient _apiClient = ApiClient();
  List<Article> _latestArticles = [];
  List<Article> _recommendedArticles = [];

  @override
  void initState() {
    super.initState();
    _fetchArticles();
  }

  Future<void> _fetchArticles() async {
    try {
      final latest = await _apiClient.getLatestArticles();
      final recommended = await _apiClient.getRecommendedArticles();
      setState(() {
        _latestArticles = latest;
        _recommendedArticles = recommended;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('記事の取得に失敗しました: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Articles'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // 記事のフィルター機能を実装
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _fetchArticles,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Latest Articles',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: _latestArticles.length,
                  itemBuilder: (context, index) {
                    final article = _latestArticles[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: SizedBox(
                        width: 160,
                        child: ArticleCard(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WebViewScreen(
                                  url: article.url,
                                  title: article.title,
                                ),
                              ),
                            );
                          },
                          title: article.title,
                          summary: '${article.author} - ${article.source}',
                          imageUrl:
                              'https://picsum.photos/seed/${article.id}/300/200',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Recommended Articles',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 0.75,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final article = _recommendedArticles[index];
                    return ArticleCard(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WebViewScreen(
                              url: article.url,
                              title: article.title,
                            ),
                          ),
                        );
                      },
                      title: article.title,
                      summary: '${article.author} - ${article.source}',
                      imageUrl:
                          'https://picsum.photos/seed/${article.id}/300/200',
                    );
                  },
                  childCount: _recommendedArticles.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
