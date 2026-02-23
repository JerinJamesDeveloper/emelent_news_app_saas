/// Metrics Model
///
/// Data model that extends MetricsEntity.
/// Handles JSON serialization/deserialization for API communication.
library;

import '../../domain/entities/metrics_entity.dart';

/// Metrics data model with JSON serialization
class MetricsModel extends MetricsEntity {
  const MetricsModel({
    required super.views,
    required super.shares,
    required super.evaluations,
  });

  /// Creates a MetricsModel from JSON map
  factory MetricsModel.fromJson(Map<String, dynamic> json) {
    return MetricsModel(
      views: json['views'] as int? ?? 0,
      shares: json['shares'] as int? ?? 0,
      evaluations: json['evaluations'] != null ? EvaluationsModel.fromJson(json['evaluations'] as Map<String, dynamic>) : EvaluationsModel.empty(),
    );
  }

  /// Converts the model to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'views': views,
      'shares': shares,
      'evaluations': EvaluationsModel.fromEntity(evaluations).toJson(),
    };
  }

  /// Creates a MetricsModel from a MetricsEntity
  factory MetricsModel.fromEntity(MetricsEntity entity) {
    return MetricsModel(
      views: entity.views,
      shares: entity.shares,
      evaluations: entity.evaluations,
    );
  }

  /// Converts this model to an entity
  MetricsEntity toEntity() {
    return MetricsEntity(
      views: views,
      shares: shares,
      evaluations: evaluations,
    );
  }

  /// Creates an empty MetricsModel
  factory MetricsModel.empty() {
    return MetricsModel(
      views: 0,
      shares: 0,
      evaluations: EvaluationsEntity.empty(),
    );
  }

  /// Creates a copy with updated fields
  @override
  MetricsModel copyWith({
    int? views,
    int? shares,
    EvaluationsEntity? evaluations,
  }) {
    return MetricsModel(
      views: views ?? this.views,
      shares: shares ?? this.shares,
      evaluations: evaluations ?? this.evaluations,
    );
  }
}
