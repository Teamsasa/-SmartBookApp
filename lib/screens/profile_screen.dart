import 'package:flutter/material.dart';
import '../widgets/memo_card.dart';
import '../widgets/reading_heatmap_calendar.dart';
import '../api/api_client.dart';
import '../models/memo.dart';
import '../models/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ApiClient _apiClient = ApiClient();
  User? _user;
  List<Memo> _latestMemos = [];

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    _fetchLatestMemos();
  }

  Future<void> _fetchUserData() async {
    try {
      // ユーザー情報を取得するAPIエンドポイントがない場合、
      // サインイン時にユーザー情報を保存し、それを使用する必要があります。
      // ここでは、仮のユーザー情報を使用します。
      setState(() {
        _user = User(
          id: '1',
          name: 'テストユーザー',
          email: 'test@example.com',
          password: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ユーザー情報の取得に失敗しました: $e')),
      );
    }
  }

  Future<void> _fetchLatestMemos() async {
    try {
      final memos = await _apiClient.getMemoList();
      if (mounted) {
        setState(() {
          _latestMemos = memos;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('メモの取得に失敗しました: $e')),
        );
      }
    }
  }

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile_image.jpg'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _user?.name ?? 'ユーザー名',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _user?.email ?? 'email@example.com',
                    style: const TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: ReadingHeatmapCalendar(
                readingData: {}, // 読書データを取得するAPIがない場合、空のマップを使用
                maxReadingCount: 5,
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Latest Notes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _latestMemos.length,
                    itemBuilder: (context, index) {
                      final memo = _latestMemos[index];
                      return MemoCard(
                        title: 'Note ${index + 1}',
                        content: memo.content,
                        createdAt: memo.createdAt,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
