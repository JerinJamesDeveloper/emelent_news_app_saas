/// FeedPost Entity
///
/// Core business entity representing a feedpost in the system.
/// Pure Dart class with no external dependencies.
library;

import 'package:equatable/equatable.dart';

import 'author_entity.dart';
import 'metrics_entity.dart';
import 'source_entity.dart';
import 'user_state_entity.dart';

/// FeedPost entity representing the core feedpost data
class FeedPostEntity extends Equatable {
  /// Id
  final String id;

  /// Category
  final String category;

  /// Headline
  final String headline;

  /// Body
  final String body;

  /// Status
  final String status;

  /// Credibility score
  final int credibilityScore;

  /// Is flagged
  final bool isFlagged;

  /// Published at
  final DateTime publishedAt;

  /// Author
  final AuthorEntity author;

  /// Source
  final SourceEntity source;

  /// Metrics
  final MetricsEntity metrics;

  /// User state
  final UserStateEntity userState;

  const FeedPostEntity({
    required this.id,
    required this.category,
    required this.headline,
    required this.body,
    required this.status,
    required this.credibilityScore,
    required this.isFlagged,
    required this.publishedAt,
    required this.author,
    required this.source,
    required this.metrics,
    required this.userState,
  });

  /// Creates a copy with updated fields
  FeedPostEntity copyWith({
    String? id,
    String? category,
    String? headline,
    String? body,
    String? status,
    int? credibilityScore,
    bool? isFlagged,
    DateTime? publishedAt,
    AuthorEntity? author,
    SourceEntity? source,
    MetricsEntity? metrics,
    UserStateEntity? userState,
  }) {
    return FeedPostEntity(
      id: id ?? this.id,
      category: category ?? this.category,
      headline: headline ?? this.headline,
      body: body ?? this.body,
      status: status ?? this.status,
      credibilityScore: credibilityScore ?? this.credibilityScore,
      isFlagged: isFlagged ?? this.isFlagged,
      publishedAt: publishedAt ?? this.publishedAt,
      author: author ?? this.author,
      source: source ?? this.source,
      metrics: metrics ?? this.metrics,
      userState: userState ?? this.userState,
    );
  }

  /// Creates an empty FeedPost
  factory FeedPostEntity.empty() {
    return FeedPostEntity(
      id: '',
      category: '',
      headline: '',
      body: '',
      status: '',
      credibilityScore: 0,
      isFlagged: false,
      publishedAt: DateTime.now(),
      author: AuthorEntity.empty(),
      source: SourceEntity.empty(),
      metrics: MetricsEntity.empty(),
      userState: UserStateEntity.empty(),
    );
  }

  /// Checks if this is an empty entity
  bool get isEmpty => id.isEmpty;

  /// Checks if this is not empty
  bool get isNotEmpty => id.isNotEmpty;

  @override
  List<Object?> get props => [
        id,
        category,
        headline,
        body,
        status,
        credibilityScore,
        isFlagged,
        publishedAt,
        author,
        source,
        metrics,
        userState,
      ];

  @override
  String toString() {
    return 'FeedPostEntity(id: $id, category: $category, headline: $headline)';
  }
}
