/// FeedPost Model
///
/// Data model that extends FeedPostEntity.
/// Handles JSON serialization/deserialization for API communication.
library;

import '../../domain/entities/feed_post_entity.dart';

/// FeedPost data model with JSON serialization
class FeedPostModel extends FeedPostEntity {
  const FeedPostModel({
    required super.id,
    required super.category,
    required super.headline,
    required super.body,
    required super.status,
    required super.credibilityScore,
    required super.isFlagged,
    required super.publishedAt,
    required super.author,
    required super.source,
    required super.metrics,
    required super.userState,
  });

  /// Creates a FeedPostModel from JSON map
  factory FeedPostModel.fromJson(Map<String, dynamic> json) {
    return FeedPostModel(
      id: json['id']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      headline: json['headline']?.toString() ?? '',
      body: json['body']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      credibilityScore: json['credibility_score'] as int? ?? 0,
      isFlagged: json['is_flagged'] as bool? ??
                json['isFlagged'] as bool? ??
                false,
      publishedAt: _parseDateTime(json['published_at'] ?? json['publishedAt']) ?? DateTime.now(),
      author: json['author'] != null ? AuthorModel.fromJson(json['author'] as Map<String, dynamic>) : AuthorModel.empty(),
      source: json['source'] != null ? SourceModel.fromJson(json['source'] as Map<String, dynamic>) : SourceModel.empty(),
      metrics: json['metrics'] != null ? MetricsModel.fromJson(json['metrics'] as Map<String, dynamic>) : MetricsModel.empty(),
      userState: json['user_state'] != null ? UserStateModel.fromJson(json['user_state'] as Map<String, dynamic>) : UserStateModel.empty(),
    );
  }

  /// Converts the model to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'headline': headline,
      'body': body,
      'status': status,
      'credibility_score': credibilityScore,
      'is_flagged': isFlagged,
      'published_at': publishedAt.toIso8601String(),
      'author': AuthorModel.fromEntity(author).toJson(),
      'source': SourceModel.fromEntity(source).toJson(),
      'metrics': MetricsModel.fromEntity(metrics).toJson(),
      'user_state': UserStateModel.fromEntity(userState).toJson(),
    };
  }

  /// Creates a FeedPostModel from a FeedPostEntity
  factory FeedPostModel.fromEntity(FeedPostEntity entity) {
    return FeedPostModel(
      id: entity.id,
      category: entity.category,
      headline: entity.headline,
      body: entity.body,
      status: entity.status,
      credibilityScore: entity.credibilityScore,
      isFlagged: entity.isFlagged,
      publishedAt: entity.publishedAt,
      author: entity.author,
      source: entity.source,
      metrics: entity.metrics,
      userState: entity.userState,
    );
  }

  /// Converts this model to an entity
  FeedPostEntity toEntity() {
    return FeedPostEntity(
      id: id,
      category: category,
      headline: headline,
      body: body,
      status: status,
      credibilityScore: credibilityScore,
      isFlagged: isFlagged,
      publishedAt: publishedAt,
      author: author,
      source: source,
      metrics: metrics,
      userState: userState,
    );
  }

  /// Creates an empty FeedPostModel
  factory FeedPostModel.empty() {
    return FeedPostModel(
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

  /// Creates a copy with updated fields
  @override
  FeedPostModel copyWith({
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
    return FeedPostModel(
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

  /// Helper to parse DateTime from various formats
  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    if (value is int) return DateTime.fromMillisecondsSinceEpoch(value);
    return null;
  }
}
