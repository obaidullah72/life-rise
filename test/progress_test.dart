import 'package:flutter_test/flutter_test.dart';
import 'package:liferise/core/models/models.dart';

void main() {
  test('routine completion can be calculated from recorded values', () {
    final items = [
      RoutineActivity(id: '1', title: 'Read', time: '8:00 AM', category: 'Reading', completed: true),
      RoutineActivity(id: '2', title: 'Walk', time: '6:00 PM', category: 'Fitness', completed: false),
    ];
    final progress = items.where((e) => e.completed).length / items.length;
    expect(progress, 0.5);
  });
}
