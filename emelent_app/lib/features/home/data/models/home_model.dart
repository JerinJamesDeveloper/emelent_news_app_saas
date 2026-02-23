/// Home Model
///
/// Data model that extends HomeEntity.
/// Handles JSON serialization/deserialization for API communication.
library;

import '../../domain/entities/home_entity.dart';

/// Home data model with JSON serialization
class HomeModel extends HomeEntity {
  const HomeModel({
    required super.id,
    required super.name,
    required super.isActive,
    required super.feedPost,
  });

  /// Creates a HomeModel from JSON map
  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      isActive: json['is_active']?.toString() ?? '',
      feedPost: json['feed_post'] != null ? FeedPostModel.fromJson(json['feed_post'] as Map<String, dynamic>) : FeedPostModel.empty(),
    );
  }

  /// Converts the model to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'is_active': isActive,
      'feed_post': FeedPostModel.fromEntity(feedPost).toJson(),
    };
  }

  /// Creates a HomeModel from a HomeEntity
  factory HomeModel.fromEntity(HomeEntity entity) {
    return HomeModel(
      id: entity.id,
      name: entity.name,
      isActive: entity.isActive,
      feedPost: entity.feedPost,
    );
  }

  /// Converts this model to an entity
  HomeEntity toEntity() {
    return HomeEntity(
      id: id,
      name: name,
      isActive: isActive,
      feedPost: feedPost,
    );
  }

  /// Creates an empty HomeModel
  factory HomeModel.empty() {
    return HomeModel(
      id: '',
      name: '',
      isActive: '',
      feedPost: FeedPostEntity.empty(),
    );
  }

  /// Creates a copy with updated fields
  @override
  HomeModel copyWith({
    String? id,
    String? name,
    String? isActive,
    FeedPostEntity? feedPost,
  }) {
    return HomeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      feedPost: feedPost ?? this.feedPost,
    );
  }
}
