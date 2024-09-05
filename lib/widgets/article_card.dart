import 'package:flutter/material.dart';

class ArticleCard extends StatelessWidget {
  final VoidCallback onTap;

  const ArticleCard({super.key, required this.onTap});

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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
