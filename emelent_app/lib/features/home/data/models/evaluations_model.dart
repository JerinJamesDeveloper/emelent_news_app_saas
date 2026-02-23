/// Evaluations Model
///
/// Data model that extends EvaluationsEntity.
/// Handles JSON serialization/deserialization for API communication.
library;

import '../../domain/entities/evaluations_entity.dart';

/// Evaluations data model with JSON serialization
class EvaluationsModel extends EvaluationsEntity {
  const EvaluationsModel({
    required super.credible,
    required super.context,
    required super.disputed,
  });

  /// Creates a EvaluationsModel from JSON map
  factory EvaluationsModel.fromJson(Map<String, dynamic> json) {
    return EvaluationsModel(
      credible: json['credible'] as int? ?? 0,
      context: json['context'] as int? ?? 0,
      disputed: json['disputed'] as int? ?? 0,
    );
  }

  /// Converts the model to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'credible': credible,
      'context': context,
      'disputed': disputed,
    };
  }

  /// Creates a EvaluationsModel from a EvaluationsEntity
  factory EvaluationsModel.fromEntity(EvaluationsEntity entity) {
    return EvaluationsModel(
      credible: entity.credible,
      context: entity.context,
      disputed: entity.disputed,
    );
  }

  /// Converts this model to an entity
  EvaluationsEntity toEntity() {
    return EvaluationsEntity(
      credible: credible,
      context: context,
      disputed: disputed,
    );
  }

  /// Creates an empty EvaluationsModel
  factory EvaluationsModel.empty() {
    return EvaluationsModel(
      credible: 0,
      context: 0,
      disputed: 0,
    );
  }

  /// Creates a copy with updated fields
  @override
  EvaluationsModel copyWith({
    int? credible,
    int? context,
    int? disputed,
  }) {
    return EvaluationsModel(
      credible: credible ?? this.credible,
      context: context ?? this.context,
      disputed: disputed ?? this.disputed,
    );
  }
}
