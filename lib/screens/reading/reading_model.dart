class ReadingRecord {
  final String name;
  final String type;
  final String status;
  final double score;
  final DateTime createdTime;

  const ReadingRecord({
    required this.name,
    required this.type,
    required this.status,
    required this.score,
    required this.createdTime,
  });

  factory ReadingRecord.fromMap(Map<String, dynamic> map) {
    final properties = map['properties'] as Map<String, dynamic>;
    final nameList = (properties['Name']?['title'] ?? []) as List;
    // final dateStr = properties['Created']?['created'];
    return ReadingRecord(
      name: nameList.isNotEmpty ? nameList[0]['plain_text'] : '?',
      type: properties['Type']?['select']?['name'] ?? 'Any',
      status: properties['Status']?['select']?['name'] ?? 'Any',
      // score: (properties['Price']?['number'] ?? 0).toDouble(),
      score: 9.0,
      createdTime: DateTime.parse(map['created_time']),
    );
  }
}
