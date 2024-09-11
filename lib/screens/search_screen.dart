import 'package:flutter/material.dart';
import '../widgets/article_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _searchResults = [];

  void _performSearch(String query) {
    // この部分は実際のデータベースやAPIと連携する必要があります
    // ここでは簡単なデモ用のデータを使用します
    setState(() {
      _searchResults = [
        {
          'title': 'Search Result 1: $query',
          'summary': 'This is a summary of the search result for $query.',
          'imageUrl': 'https://picsum.photos/seed/1/300/200',
        },
        {
          'title': 'Search Result 2: $query',
          'summary': 'This is another summary of the search result for $query.',
          'imageUrl': 'https://picsum.photos/seed/2/300/200',
        },
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search articles or notes...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onSubmitted: _performSearch,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final result = _searchResults[index];
                return ArticleCard(
                  title: result['title']!,
                  summary: result['summary']!,
                  imageUrl: result['imageUrl']!,
                  onTap: () {
                    // 検索結果の詳細画面に遷移する処理を実装
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
