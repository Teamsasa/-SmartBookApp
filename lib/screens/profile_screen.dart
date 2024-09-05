import 'package:flutter/material.dart';
import '../widgets/memo_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('プロフィール'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // プロフィール編集画面へ遷移
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile_image.jpg'),
              ),
              const SizedBox(height: 16),
              const Text(
                '章',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                '@username',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              const Text(
                'プロフィール説明がここに表示されます。ユーザーの興味や経歴などを簡潔に紹介します。',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 24),
              const Text(
                '最新のメモ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) => MemoCard(
                  title: 'メモ ${index + 1}',
                  content: 'これはメモ ${index + 1} の内容です。',
                  createdAt: DateTime.now().subtract(Duration(days: index)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
