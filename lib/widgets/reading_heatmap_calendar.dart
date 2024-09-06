import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReadingHeatmapCalendar extends StatelessWidget {
  final Map<DateTime, int> readingData;
  final int maxReadingCount;

  const ReadingHeatmapCalendar({
    super.key,
    required this.readingData,
    required this.maxReadingCount,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final startDate = DateTime(now.year - 1, now.month, now.day);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '読書活動',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMonthLabels(startDate),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDayLabels(),
                  SizedBox(
                    width: 53 * 14.0, // 53週分の幅
                    child: _buildHeatmapGrid(startDate),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        _buildLegend(),
      ],
    );
  }

  Widget _buildMonthLabels(DateTime startDate) {
    return Row(
      children: [
        const SizedBox(width: 30), // 曜日ラベルの幅分のスペース
        ...List.generate(12, (index) {
          final month = startDate.add(Duration(days: index * 30));
          return SizedBox(
            width: 4 * 14.0, // 4週間分の幅
            child: Text(
              DateFormat('MMM').format(month),
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          );
        }),
      ],
    );
  }

  Widget _buildDayLabels() {
    const days = ['Mon', '', 'Wed', '', 'Fri', '', ''];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: days
          .map((day) => SizedBox(
                height: 14.0,
                width: 30,
                child: Text(
                  day,
                  style: const TextStyle(fontSize: 10),
                  textAlign: TextAlign.right,
                ),
              ))
          .toList(),
    );
  }

  Widget _buildHeatmapGrid(DateTime startDate) {
    return Column(
      children: List.generate(7, (row) {
        return Row(
          children: List.generate(53, (col) {
            final date = startDate.add(Duration(days: col * 7 + row));
            final readingCount = readingData[date] ?? 0;
            return Padding(
              padding: const EdgeInsets.all(1),
              child: _buildDayCell(readingCount, date),
            );
          }),
        );
      }),
    );
  }

  Widget _buildDayCell(int readingCount, DateTime date) {
    return Tooltip(
      message: '${DateFormat('yyyy-MM-dd').format(date)}: $readingCount',
      child: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: _getColor(readingCount, maxReadingCount),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text('Less', style: TextStyle(fontSize: 12)),
        const SizedBox(width: 4),
        ...List.generate(
          5,
          (index) => Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              color: _getColor(index * maxReadingCount ~/ 4, maxReadingCount),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        const SizedBox(width: 4),
        const Text('More', style: TextStyle(fontSize: 12)),
      ],
    );
  }

  Color _getColor(int readingCount, int maxCount) {
    if (readingCount == 0) return Colors.grey[800]!;
    final intensity = readingCount / maxCount;
    return Color.lerp(Colors.purple[900]!, Colors.purple[200]!, intensity)!;
  }
}
