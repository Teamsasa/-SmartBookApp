import 'package:flutter/material.dart';
import '../widgets/article_card.dart';
import 'webview_screen.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('新着記事一覧'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // マイページアイコン表示のロジック
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const Text('あなたへのおすすめ'),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return ArticleCard(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WebViewScreen()),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
