import 'package:flutter/material.dart';
import 'articles_screen.dart';
import '../widgets/memo_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              child: Text('username'),
            ),
            const Text('章'),
            const Text('最新のメモ'),
            Expanded(
              child: ListView(
                children: List.generate(
                  4,
                  (index) => const MemoCard(),
                ),
              ),
            ),
            ElevatedButton(
              child: const Text('新着記事一覧'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ArticlesScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
