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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 新着記事を横スライドで表示
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '新着記事一覧',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(
              height: 200, // 高さを調整
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: 10, // 仮の記事数
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: ArticleCard(
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
                      title: '新着記事 ${index + 1}',
                      summary: '新着記事の要約',
                      imageUrl: 'https://picsum.photos/seed/$index/300/200',
                    ),
                  );
                },
              ),
            ),

            // あなたへのおすすめを2列で表示
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'あなたへのおすすめ',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(), // 親のスクロールに統一
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2列表示
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 1.0, // カードの比率を調整
              ),
              itemCount: 6, // 仮のおすすめ記事数
              itemBuilder: (context, index) {
                return ArticleCard(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WebViewScreen(
                          url: 'https://example.com/recommendation/$index',
                          title: 'おすすめ記事 ${index + 1}',
                        ),
                      ),
                    );
                  },
                  title: 'おすすめ記事 ${index + 1}',
                  summary: 'おすすめ記事の要約',
                  imageUrl: 'https://picsum.photos/seed/recommendation_$index/300/200',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
