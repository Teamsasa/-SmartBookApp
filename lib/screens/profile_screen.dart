import 'package:flutter/material.dart';
import '../widgets/memo_card.dart';
import '../widgets/reading_heatmap_calendar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // この関数は実際のデータソースから読書データを取得するものに置き換えてください
  Map<DateTime, int> _getMockReadingData() {
    final now = DateTime.now();
    final Map<DateTime, int> mockData = {};
    for (int i = 0; i < 365; i++) {
      final date = now.subtract(Duration(days: i));
      mockData[date] = (i % 7 == 0)
          ? 5
          : (i % 3 == 0)
              ? 3
              : (i % 2 == 0)
                  ? 1
                  : 0;
    }
    return mockData;
  }

  @override
  Widget build(BuildContext context) {
    final readingData = _getMockReadingData();
    final maxReadingCount =
        readingData.values.reduce((max, value) => max > value ? max : value);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
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
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile_image.jpg'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Chapter',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '@username',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Profile description that will be displayed here. User\'s interests and background will be briefly introduced.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ReadingHeatmapCalendar(
                readingData: readingData,
                maxReadingCount: maxReadingCount,
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
                    itemCount: 4,
                    itemBuilder: (context, index) => MemoCard(
                      title: 'Note ${index + 1}',
                      content: 'This is the content of Note ${index + 1}.',
                      createdAt: DateTime.now().subtract(Duration(days: index)),
                    ),
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
