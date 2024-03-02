import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
enum Category {
  @HiveField(0)
  priority,
  @HiveField(1)
  daily
}

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  late String id;
  @HiveField(1)
  String title;
  @HiveField(2)
  DateTime startDate;
  @HiveField(3)
  DateTime endDate;
  @HiveField(4)
  bool isChecked;
  @HiveField(5)
  String description;
  @HiveField(6)
  Category category;

  Task(
      {required this.title,
      required this.startDate,
      required this.endDate,
      required this.isChecked,
      required this.description,
      required this.category}) {
    id = const Uuid().v4().toString();
  }

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
        title: json['title'],
        startDate: DateTime.parse(json['startDate']),
        endDate: DateTime.parse(json['endDate']),
        isChecked: json['isChecked'],
        description: json['description'],
        category: Category.values.byName(json['category']));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'isChecked': isChecked,
      'description': description,
      'category': category.name
    };
  }
}
