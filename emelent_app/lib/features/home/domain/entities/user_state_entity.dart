/// UserState Entity
///
/// Core business entity representing a userstate in the system.
/// Pure Dart class with no external dependencies.
library;

import 'package:equatable/equatable.dart';

/// UserState entity representing the core userstate data
class UserStateEntity extends Equatable {
  /// Bookmarked
  final bool bookmarked;

  const UserStateEntity({
    required this.bookmarked,
  });

  /// Creates a copy with updated fields
  UserStateEntity copyWith({
    bool? bookmarked,
  }) {
    return UserStateEntity(
      bookmarked: bookmarked ?? this.bookmarked,
    );
  }

  /// Creates an empty UserState
  factory UserStateEntity.empty() {
    return UserStateEntity(
      bookmarked: false,
    );
  }

  /// Checks if this is an empty entity
  bool get isEmpty => false;

  /// Checks if this is not empty
  bool get isNotEmpty => bookmarked;

  @override
  List<Object?> get props => [
        bookmarked,
      ];

  @override
  String toString() {
    return 'UserStateEntity(bookmarked: $bookmarked)';
  }
}
