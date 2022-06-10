import 'package:flutter/foundation.dart';
import 'package:marvel_universe_path/app/blueprints/api_response.dart';
import 'package:marvel_universe_path/models/character_data_container.dart';

class ComicsDataContainer extends ApiResponse {
  late List<ComicData> data;

  ComicsDataContainer.fromMap(Map<String, dynamic> map) : super.fromMap(map) {
    final List<ComicData> data = map['data']['results'] != null
        ? List<ComicData>.from(map['data']['results']
            ?.map((x) => ComicData.fromMap(x as Map<String, dynamic>)))
        : [];
    this.data = data;
  }

  ComicsDataContainer.withError(String error) : super.withError(error);

  @override
  Map<String, dynamic> toMap() {
    return {};
  }
}

class ComicData {
  final int id;
  final String title;
  final String description;
  final List<ComicDates>? dates;
  final ImageData thumbnail;

  ComicData({
    required this.id,
    required this.title,
    required this.description,
    this.dates,
    required this.thumbnail,
  });

  factory ComicData.fromMap(Map<String, dynamic> map) {
    return ComicData(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      dates: map['dates'] != null
          ? List<ComicDates>.from(map['dates']
              ?.map((x) => ComicDates.fromMap(x as Map<String, dynamic>)))
          : null,
      thumbnail: ImageData.fromMap(map['thumbnail']),
    );
  }

  ComicData copyWith({
    int? id,
    String? title,
    String? description,
    List<ComicDates>? dates,
    ImageData? thumbnail,
  }) {
    return ComicData(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dates: dates ?? this.dates,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ComicData &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        listEquals(other.dates, dates) &&
        other.thumbnail == thumbnail;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        description.hashCode ^
        dates.hashCode ^
        thumbnail.hashCode;
  }
}

class ComicDates {
  final String type;
  final DateTime date;

  ComicDates({
    required this.type,
    required this.date,
  });

  factory ComicDates.fromMap(Map<String, dynamic> map) {
    return ComicDates(
      type: map['type'] ?? '',
      date: DateTime.parse(map['date']),
    );
  }

  ComicDates copyWith({
    String? type,
    DateTime? date,
  }) {
    return ComicDates(
      type: type ?? this.type,
      date: date ?? this.date,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ComicDates && other.type == type && other.date == date;
  }

  @override
  int get hashCode => type.hashCode ^ date.hashCode;
}
