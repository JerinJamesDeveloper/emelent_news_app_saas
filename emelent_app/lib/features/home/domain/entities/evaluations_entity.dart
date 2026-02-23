/// Evaluations Entity
///
/// Core business entity representing a evaluations in the system.
/// Pure Dart class with no external dependencies.
library;

import 'package:equatable/equatable.dart';

/// Evaluations entity representing the core evaluations data
class EvaluationsEntity extends Equatable {
  /// Credible
  final int credible;

  /// Context
  final int context;

  /// Disputed
  final int disputed;

  const EvaluationsEntity({
    required this.credible,
    required this.context,
    required this.disputed,
  });

  /// Creates a copy with updated fields
  EvaluationsEntity copyWith({
    int? credible,
    int? context,
    int? disputed,
  }) {
    return EvaluationsEntity(
      credible: credible ?? this.credible,
      context: context ?? this.context,
      disputed: disputed ?? this.disputed,
    );
  }

  /// Creates an empty Evaluations
  factory EvaluationsEntity.empty() {
    return EvaluationsEntity(
      credible: 0,
      context: 0,
      disputed: 0,
    );
  }

  /// Checks if this is an empty entity
  bool get isEmpty => credible == 0;

  /// Checks if this is not empty
  bool get isNotEmpty => credible != 0;

  @override
  List<Object?> get props => [
        credible,
        context,
        disputed,
      ];

  @override
  String toString() {
    return 'EvaluationsEntity(credible: $credible, context: $context, disputed: $disputed)';
  }
}
