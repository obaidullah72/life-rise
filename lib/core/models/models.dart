class RoutineActivity {
  RoutineActivity({required this.id, required this.title, required this.time, required this.category, this.completed = false, this.notes});
  final String id;
  final String title;
  final String time;
  final String category;
  bool completed;
  String? notes;

  Map<String, dynamic> toJson() => {'id': id, 'title': title, 'time': time, 'category': category, 'completed': completed, 'notes': notes};
  factory RoutineActivity.fromJson(Map<String, dynamic> j) => RoutineActivity(id: j['id'], title: j['title'], time: j['time'], category: j['category'], completed: j['completed'] ?? false, notes: j['notes']);
}

class HabitItem {
  HabitItem({required this.id, required this.title, required this.isPositive, this.replacement, this.todayCount = 0});
  final String id;
  final String title;
  final bool isPositive;
  String? replacement;
  int todayCount;

  Map<String, dynamic> toJson() => {'id': id, 'title': title, 'isPositive': isPositive, 'replacement': replacement, 'todayCount': todayCount};
  factory HabitItem.fromJson(Map<String, dynamic> j) => HabitItem(id: j['id'], title: j['title'], isPositive: j['isPositive'], replacement: j['replacement'], todayCount: j['todayCount'] ?? 0);
}

class ReadingBook {
  ReadingBook({required this.id, required this.title, required this.author, this.pagesRead = 0, this.totalPages = 250});
  final String id;
  final String title;
  final String author;
  int pagesRead;
  int totalPages;

  Map<String, dynamic> toJson() => {'id': id, 'title': title, 'author': author, 'pagesRead': pagesRead, 'totalPages': totalPages};
  factory ReadingBook.fromJson(Map<String, dynamic> j) => ReadingBook(id: j['id'], title: j['title'], author: j['author'], pagesRead: j['pagesRead'] ?? 0, totalPages: j['totalPages'] ?? 250);
}
