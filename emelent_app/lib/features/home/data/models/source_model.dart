/// Source Model
///
/// Data model that extends SourceEntity.
/// Handles JSON serialization/deserialization for API communication.
library;

import '../../domain/entities/source_entity.dart';

/// Source data model with JSON serialization
class SourceModel extends SourceEntity {
  const SourceModel({
    required super.name,
    required super.url,
  });

  /// Creates a SourceModel from JSON map
  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      name: json['name']?.toString() ?? '',
      url: json['url']?.toString() ?? '',
    );
  }

  /// Converts the model to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }

  /// Creates a SourceModel from a SourceEntity
  factory SourceModel.fromEntity(SourceEntity entity) {
    return SourceModel(
      name: entity.name,
      url: entity.url,
    );
  }

  /// Converts this model to an entity
  SourceEntity toEntity() {
    return SourceEntity(
      name: name,
      url: url,
    );
  }

  /// Creates an empty SourceModel
  factory SourceModel.empty() {
    return SourceModel(
      name: '',
      url: '',
    );
  }

  /// Creates a copy with updated fields
  @override
  SourceModel copyWith({
    String? name,
    String? url,
  }) {
    return SourceModel(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }
}
