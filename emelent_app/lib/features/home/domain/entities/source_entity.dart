/// Source Entity
///
/// Core business entity representing a source in the system.
/// Pure Dart class with no external dependencies.
library;

import 'package:equatable/equatable.dart';

/// Source entity representing the core source data
class SourceEntity extends Equatable {
  /// Name
  final String name;

  /// Url
  final String url;

  const SourceEntity({
    required this.name,
    required this.url,
  });

  /// Creates a copy with updated fields
  SourceEntity copyWith({
    String? name,
    String? url,
  }) {
    return SourceEntity(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  /// Creates an empty Source
  factory SourceEntity.empty() {
    return SourceEntity(
      name: '',
      url: '',
    );
  }

  /// Checks if this is an empty entity
  bool get isEmpty => name.isEmpty;

  /// Checks if this is not empty
  bool get isNotEmpty => name.isNotEmpty;

  @override
  List<Object?> get props => [
        name,
        url,
      ];

  @override
  String toString() {
    return 'SourceEntity(name: $name, url: $url)';
  }
}
