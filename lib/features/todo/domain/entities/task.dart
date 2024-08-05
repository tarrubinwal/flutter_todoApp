import 'package:hive/hive.dart';

import 'package:equatable/equatable.dart';
part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String title;

  @HiveField(1)
  bool isCompleted;

  Task({required this.title, this.isCompleted = false});

  @override
  List<Object?> get props => [title, isCompleted];
}
