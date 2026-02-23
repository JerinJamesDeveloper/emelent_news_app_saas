/// Home Entity
///
/// Core business entity representing a home in the system.
/// Pure Dart class with no external dependencies.
library;

import 'package:equatable/equatable.dart';

import 'feed_post_entity.dart';

/// Home entity representing the core home data
class HomeEntity extends Equatable {
  /// Id
  final String id;

  /// Name
  final String name;

  /// Is active
  final String isActive;

  /// Feed post
  final FeedPostEntity feedPost;

  const HomeEntity({
    required this.id,
    required this.name,
    required this.isActive,
    required this.feedPost,
  });

  /// Creates a copy with updated fields
  HomeEntity copyWith({
    String? id,
    String? name,
    String? isActive,
    FeedPostEntity? feedPost,
  }) {
    return HomeEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      feedPost: feedPost ?? this.feedPost,
    );
  }

  /// Creates an empty Home
  factory HomeEntity.empty() {
    return HomeEntity(
      id: '',
      name: '',
      isActive: '',
      feedPost: FeedPostEntity.empty(),
    );
  }

  /// Checks if this is an empty entity
  bool get isEmpty => id.isEmpty;

  /// Checks if this is not empty
  bool get isNotEmpty => id.isNotEmpty;

  @override
  List<Object?> get props => [
        id,
        name,
        isActive,
        feedPost,
      ];

  @override
  String toString() {
    return 'HomeEntity(id: $id, name: $name, isActive: $isActive)';
  }
}
