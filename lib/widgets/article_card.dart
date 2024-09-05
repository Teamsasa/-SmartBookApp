import 'package:flutter/material.dart';

class ArticleCard extends StatelessWidget {
  final VoidCallback onTap;

  const ArticleCard({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.grey[300],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'タイトル',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('本文'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
