import 'dart:convert';

import 'package:flutter/foundation.dart';

class DocumentModel {
  final String userId;
  final DateTime createdAt;
  final String title;
  final List content;
  final String id;
  DocumentModel({
    required this.userId,
    required this.createdAt,
    required this.title,
    required this.content,
    required this.id,
  });

  DocumentModel copyWith({
    String? userId,
    DateTime? createdAt,
    String? title,
    List? content,
    String? id,
  }) {
    return DocumentModel(
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      title: title ?? this.title,
      content: content ?? this.content,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userId': userId});
    result.addAll({'createdAt': createdAt.millisecondsSinceEpoch});
    result.addAll({'title': title});
    result.addAll({'content': content});
    result.addAll({'id': id});

    return result;
  }

  factory DocumentModel.fromMap(Map<String, dynamic> map) {
    return DocumentModel(
      userId: map['userId'] ?? '',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      title: map['title'] ?? '',
      content: List.from(map['content']),
      id: map['_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DocumentModel.fromJson(String source) =>
      DocumentModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DocumentModel(userId: $userId, createdAt: $createdAt, title: $title, content: $content, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DocumentModel &&
        other.userId == userId &&
        other.createdAt == createdAt &&
        other.title == title &&
        listEquals(other.content, content) &&
        other.id == id;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        createdAt.hashCode ^
        title.hashCode ^
        content.hashCode ^
        id.hashCode;
  }
}
