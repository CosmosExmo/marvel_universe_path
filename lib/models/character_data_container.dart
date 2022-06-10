
import 'package:marvel_universe_path/app/blueprints/api_response.dart';

class CharacterDataContainer extends ApiResponse {
  late List<Character> data;

  CharacterDataContainer.fromMap(Map<String, dynamic> map)
      : super.fromMap(map) {
    final List<Character> data = map['data'] != null
        ? List<Character>.from(map['data']
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
  final Image? thumbnail;

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
      modified: map['modified'] != null ? DateTime.fromMillisecondsSinceEpoch(map['modified']) : null,
      resourceURI: map['resourceURI'],
      urls: map['urls'] != null ? List<Url>.from(map['urls']?.map((x) => Url.fromMap(x))) : null,
      thumbnail: map['thumbnail'] != null ? Image.fromMap(map['thumbnail']) : null,
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

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'url': url,
    };
  }

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
  
    return other is Url &&
      other.type == type &&
      other.url == url;
  }

  @override
  int get hashCode => type.hashCode ^ url.hashCode;
}

class Image {
  final String path;
  final String extension;
  
  Image({
    required this.path,
    required this.extension,
  });

  Map<String, dynamic> toMap() {
    return {
      'path': path,
      'extension': extension,
    };
  }

  factory Image.fromMap(Map<String, dynamic> map) {
    return Image(
      path: map['path'] ?? '',
      extension: map['extension'] ?? '',
    );
  }

  Image copyWith({
    String? path,
    String? extension,
  }) {
    return Image(
      path: path ?? this.path,
      extension: extension ?? this.extension,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Image &&
      other.path == path &&
      other.extension == extension;
  }

  @override
  int get hashCode => path.hashCode ^ extension.hashCode;
}
