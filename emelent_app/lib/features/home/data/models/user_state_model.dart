/// UserState Model
///
/// Data model that extends UserStateEntity.
/// Handles JSON serialization/deserialization for API communication.
library;

import '../../domain/entities/user_state_entity.dart';

/// UserState data model with JSON serialization
class UserStateModel extends UserStateEntity {
  const UserStateModel({
    required super.bookmarked,
  });

  /// Creates a UserStateModel from JSON map
  factory UserStateModel.fromJson(Map<String, dynamic> json) {
    return UserStateModel(
      bookmarked: json['bookmarked'] as bool? ??
                json['bookmarked'] as bool? ??
                false,
    );
  }

  /// Converts the model to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'bookmarked': bookmarked,
    };
  }

  /// Creates a UserStateModel from a UserStateEntity
  factory UserStateModel.fromEntity(UserStateEntity entity) {
    return UserStateModel(
      bookmarked: entity.bookmarked,
    );
  }

  /// Converts this model to an entity
  UserStateEntity toEntity() {
    return UserStateEntity(
      bookmarked: bookmarked,
    );
  }

  /// Creates an empty UserStateModel
  factory UserStateModel.empty() {
    return UserStateModel(
      bookmarked: false,
    );
  }

  /// Creates a copy with updated fields
  @override
  UserStateModel copyWith({
    bool? bookmarked,
  }) {
    return UserStateModel(
      bookmarked: bookmarked ?? this.bookmarked,
    );
  }
}
