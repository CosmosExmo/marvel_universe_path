import 'package:marvel_universe_path/app/blueprints/api_response.dart';

class CharacterDataContainer extends ApiResponse {
  late List<Character> data;

  CharacterDataContainer.fromMap(Map<String, dynamic> map)
      : super.fromMap(map) {
    final List<Character> data = map['data']['results'] != null
        ? List<Character>.from(map['data']['results']
            ?.map((x) => Character.fromMap(x as Map<String, dynamic>)))
        : [];
    this.data = data;
  }

  CharacterDataContainer.withError(String error) : super.withError(error);

  @override
  Map<String, dynamic> toMap() {
    return {};
  }
}

class Character {
  final int id;
  final String name;
  final String? description;
  final DateTime? modified;
  final String? resourceURI;
  final List<Url>? urls;
  final ImageData? thumbnail;

  Character({
    required this.id,
    required this.name,
    this.description,
    this.modified,
    this.resourceURI,
    this.urls,
    this.thumbnail,
  });

  factory Character.fromMap(Map<String, dynamic> map) {
    return Character(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'],
      modified:
          map['modified'] != null ? DateTime.tryParse(map['modified']) : null,
      resourceURI: map['resourceURI'],
      urls: map['urls'] != null
          ? List<Url>.from(map['urls']?.map((x) => Url.fromMap(x)))
          : null,
      thumbnail:
          map['thumbnail'] != null ? ImageData.fromMap(map['thumbnail']) : null,
    );
  }
}

class Url {
  final String type;
  final String url;

  Url({
    required this.type,
    required this.url,
  });

  factory Url.fromMap(Map<String, dynamic> map) {
    return Url(
      type: map['type'] ?? '',
      url: map['url'] ?? '',
    );
  }

  Url copyWith({
    String? type,
    String? url,
  }) {
    return Url(
      type: type ?? this.type,
      url: url ?? this.url,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Url && other.type == type && other.url == url;
  }

  @override
  int get hashCode => type.hashCode ^ url.hashCode;
}

class ImageData {
  final String path;
  final String extension;

  ImageData({
    required this.path,
    required this.extension,
  });

  factory ImageData.fromMap(Map<String, dynamic> map) {
    return ImageData(
      path: map['path'] ?? '',
      extension: map['extension'] ?? '',
    );
  }

  ImageData copyWith({
    String? path,
    String? extension,
  }) {
    return ImageData(
      path: path ?? this.path,
      extension: extension ?? this.extension,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ImageData &&
        other.path == path &&
        other.extension == extension;
  }

  @override
  int get hashCode => path.hashCode ^ extension.hashCode;
}
