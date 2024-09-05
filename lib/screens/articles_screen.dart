import 'package:flutter/material.dart';
import '../widgets/article_card.dart';
import '../screens/webview_screen.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新着記事一覧'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // 記事のフィルター機能を実装
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'あなたへのおすすめ',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: 10, // 仮の記事数
              itemBuilder: (context, index) {
                return ArticleCard(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebViewScreen(
                          url: 'https://example.com/article/$index',
                          title: '記事 ${index + 1}',
                        ),
                      ),
                    );
                  },
                  title: '記事タイトル ${index + 1}',
                  summary: '記事の要約がここに表示されます。これは記事 ${index + 1} の概要です。',
                  imageUrl: 'https://picsum.photos/seed/$index/300/200',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
