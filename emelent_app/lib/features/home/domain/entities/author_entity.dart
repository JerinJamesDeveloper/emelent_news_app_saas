/// Author Entity
///
/// Core business entity representing a author in the system.
/// Pure Dart class with no external dependencies.
library;

import 'package:equatable/equatable.dart';

/// Author entity representing the core author data
class AuthorEntity extends Equatable {
  /// Id
  final String id;

  /// Username
  final String username;

  /// Handle
  final String handle;

  /// Verified
  final bool verified;

  const AuthorEntity({
    required this.id,
    required this.username,
    required this.handle,
    required this.verified,
  });

  /// Creates a copy with updated fields
  AuthorEntity copyWith({
    String? id,
    String? username,
    String? handle,
    bool? verified,
  }) {
    return AuthorEntity(
      id: id ?? this.id,
      username: username ?? this.username,
      handle: handle ?? this.handle,
      verified: verified ?? this.verified,
    );
  }

  /// Creates an empty Author
  factory AuthorEntity.empty() {
    return AuthorEntity(
      id: '',
      username: '',
      handle: '',
      verified: false,
    );
  }

  /// Checks if this is an empty entity
  bool get isEmpty => id.isEmpty;

  /// Checks if this is not empty
  bool get isNotEmpty => id.isNotEmpty;

  @override
  List<Object?> get props => [
        id,
        username,
        handle,
        verified,
      ];

  @override
  String toString() {
    return 'AuthorEntity(id: $id, username: $username, handle: $handle)';
  }
}
