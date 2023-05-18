import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Task extends Equatable {
  String id;
  String title;
  int period;
  int? counter;
  DateTime? dateTime;
  Task({
    required this.id,
    required this.title,
    required this.period,
    this.counter,
    this.dateTime,
  });

  Task copyWith({
    String? id,
    String? title,
    int? period,
    int? counter,
    DateTime? dateTime,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      period: period ?? this.period,
      counter: counter ?? this.counter,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'title': title});
    result.addAll({'period': period});
    if (counter != null) {
      result.addAll({'counter': counter});
    }
    if (dateTime != null) {
      result.addAll({'dateTime': dateTime!.millisecondsSinceEpoch});
    }

    return result;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      period: map['period']?.toInt() ?? 0,
      counter: map['counter']?.toInt(),
      dateTime: map['dateTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dateTime'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Task(id: $id, title: $title, period: $period, counter: $counter, dateTime: $dateTime)';
  }

  @override
  List<Object> get props {
    return [
      id,
      title,
      period,
    ];
  }
}
