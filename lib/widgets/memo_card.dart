import 'package:flutter/material.dart';

class MemoCard extends StatelessWidget {
  const MemoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: ListTile(
        title: Text('メモタイトル'),
        subtitle: Text('メモの内容...'),
      ),
    );
  }
}
