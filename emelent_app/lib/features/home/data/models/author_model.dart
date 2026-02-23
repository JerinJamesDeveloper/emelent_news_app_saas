/// Author Model
///
/// Data model that extends AuthorEntity.
/// Handles JSON serialization/deserialization for API communication.
library;

import '../../domain/entities/author_entity.dart';

/// Author data model with JSON serialization
class AuthorModel extends AuthorEntity {
  const AuthorModel({
    required super.id,
    required super.username,
    required super.handle,
    required super.verified,
  });

  /// Creates a AuthorModel from JSON map
  factory AuthorModel.fromJson(Map<String, dynamic> json) {
    return AuthorModel(
      id: json['id']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      handle: json['handle']?.toString() ?? '',
      verified: json['verified'] as bool? ??
                json['verified'] as bool? ??
                false,
    );
  }

  /// Converts the model to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'handle': handle,
      'verified': verified,
    };
  }

  /// Creates a AuthorModel from a AuthorEntity
  factory AuthorModel.fromEntity(AuthorEntity entity) {
    return AuthorModel(
      id: entity.id,
      username: entity.username,
      handle: entity.handle,
      verified: entity.verified,
    );
  }

  /// Converts this model to an entity
  AuthorEntity toEntity() {
    return AuthorEntity(
      id: id,
      username: username,
      handle: handle,
      verified: verified,
    );
  }

  /// Creates an empty AuthorModel
  factory AuthorModel.empty() {
    return AuthorModel(
      id: '',
      username: '',
      handle: '',
      verified: false,
    );
  }

  /// Creates a copy with updated fields
  @override
  AuthorModel copyWith({
    String? id,
    String? username,
    String? handle,
    bool? verified,
  }) {
    return AuthorModel(
      id: id ?? this.id,
      username: username ?? this.username,
      handle: handle ?? this.handle,
      verified: verified ?? this.verified,
    );
  }
}
