/// Metrics Entity
///
/// Core business entity representing a metrics in the system.
/// Pure Dart class with no external dependencies.
library;

import 'package:equatable/equatable.dart';

import 'evaluations_entity.dart';

/// Metrics entity representing the core metrics data
class MetricsEntity extends Equatable {
  /// Views
  final int views;

  /// Shares
  final int shares;

  /// Evaluations
  final EvaluationsEntity evaluations;

  const MetricsEntity({
    required this.views,
    required this.shares,
    required this.evaluations,
  });

  /// Creates a copy with updated fields
  MetricsEntity copyWith({
    int? views,
    int? shares,
    EvaluationsEntity? evaluations,
  }) {
    return MetricsEntity(
      views: views ?? this.views,
      shares: shares ?? this.shares,
      evaluations: evaluations ?? this.evaluations,
    );
  }

  /// Creates an empty Metrics
  factory MetricsEntity.empty() {
    return MetricsEntity(
      views: 0,
      shares: 0,
      evaluations: EvaluationsEntity.empty(),
    );
  }

  /// Checks if this is an empty entity
  bool get isEmpty => views == 0;

  /// Checks if this is not empty
  bool get isNotEmpty => views != 0;

  @override
  List<Object?> get props => [
        views,
        shares,
        evaluations,
      ];

  @override
  String toString() {
    return 'MetricsEntity(views: $views, shares: $shares, evaluations: $evaluations)';
  }
}
