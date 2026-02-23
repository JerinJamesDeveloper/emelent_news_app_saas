/// Evaluations Local Data Source
///
/// Handles local storage operations for evaluations data.
/// Uses LocalStorage for caching.
library;

import 'dart:convert';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/storage/local_storage.dart';
import '../models/evaluations_model.dart';

/// Storage key for evaluations cache
const String _evaluationsCacheKey = 'cached_evaluationss';

/// Abstract interface for evaluations local data source
abstract class EvaluationsLocalDataSource {
  /// Gets a cached evaluations by ID
  Future<EvaluationsModel?> getEvaluations(String id);

  /// Gets all cached evaluationss
  Future<List<EvaluationsModel>> getAllEvaluationss();

  /// Caches a evaluations
  Future<void> cacheEvaluations(EvaluationsModel evaluations);

  /// Caches all evaluationss
  Future<void> cacheAllEvaluationss(List<EvaluationsModel> evaluationss);

  /// Removes a cached evaluations
  Future<void> removeEvaluations(String id);
  
  /// Clears all cached evaluationss
  Future<void> clearCache();
}

/// Implementation of EvaluationsLocalDataSource
class EvaluationsLocalDataSourceImpl implements EvaluationsLocalDataSource {
  final LocalStorage _storage;

  EvaluationsLocalDataSourceImpl(this._storage);

  @override
  Future<EvaluationsModel?> getEvaluations(String id) async {
    try {
      final all = await getAllEvaluationss();
      return all.where((item) => item.id == id).firstOrNull;
    } catch (e) {
      throw StorageException(message: 'Failed to get evaluations: $e');
    }
  }

  @override
  Future<List<EvaluationsModel>> getAllEvaluationss() async {
    try {
      final jsonString = await _storage.getString(_evaluationsCacheKey);
      if (jsonString == null) return [];

      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((json) => EvaluationsModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw StorageException(message: 'Failed to get evaluationss: $e');
    }
  }

  @override
  Future<void> cacheEvaluations(EvaluationsModel evaluations) async {
    try {
      final all = await getAllEvaluationss();
      final index = all.indexWhere((item) => item.id == evaluations.id);
      
      if (index >= 0) {
        all[index] = evaluations;
      } else {
        all.add(evaluations);
      }

      await _saveAll(all);
    } catch (e) {
      throw StorageException(message: 'Failed to cache evaluations: $e');
    }
  }

  @override
  Future<void> cacheAllEvaluationss(List<EvaluationsModel> evaluationss) async {
    try {
      await _saveAll(evaluationss);
    } catch (e) {
      throw StorageException(message: 'Failed to cache evaluationss: $e');
    }
  }

  @override
  Future<void> removeEvaluations(String id) async {
    try {
      final all = await getAllEvaluationss();
      all.removeWhere((item) => item.id == id);
      await _saveAll(all);
    } catch (e) {
      throw StorageException(message: 'Failed to remove evaluations: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await _storage.remove(_evaluationsCacheKey);
    } catch (e) {
      throw StorageException(message: 'Failed to clear cache: $e');
    }
  }

  Future<void> _saveAll(List<EvaluationsModel> items) async {
    final jsonList = items.map((item) => item.toJson()).toList();
    await _storage.setString(_evaluationsCacheKey, jsonEncode(jsonList));
  }
}
