/// Metrics Local Data Source
///
/// Handles local storage operations for metrics data.
/// Uses LocalStorage for caching.
library;

import 'dart:convert';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/storage/local_storage.dart';
import '../models/metrics_model.dart';

/// Storage key for metrics cache
const String _metricsCacheKey = 'cached_metricss';

/// Abstract interface for metrics local data source
abstract class MetricsLocalDataSource {
  /// Gets a cached metrics by ID
  Future<MetricsModel?> getMetrics(String id);

  /// Gets all cached metricss
  Future<List<MetricsModel>> getAllMetricss();

  /// Caches a metrics
  Future<void> cacheMetrics(MetricsModel metrics);

  /// Caches all metricss
  Future<void> cacheAllMetricss(List<MetricsModel> metricss);

  /// Removes a cached metrics
  Future<void> removeMetrics(String id);
  
  /// Clears all cached metricss
  Future<void> clearCache();
}

/// Implementation of MetricsLocalDataSource
class MetricsLocalDataSourceImpl implements MetricsLocalDataSource {
  final LocalStorage _storage;

  MetricsLocalDataSourceImpl(this._storage);

  @override
  Future<MetricsModel?> getMetrics(String id) async {
    try {
      final all = await getAllMetricss();
      return all.where((item) => item.id == id).firstOrNull;
    } catch (e) {
      throw StorageException(message: 'Failed to get metrics: $e');
    }
  }

  @override
  Future<List<MetricsModel>> getAllMetricss() async {
    try {
      final jsonString = await _storage.getString(_metricsCacheKey);
      if (jsonString == null) return [];

      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((json) => MetricsModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw StorageException(message: 'Failed to get metricss: $e');
    }
  }

  @override
  Future<void> cacheMetrics(MetricsModel metrics) async {
    try {
      final all = await getAllMetricss();
      final index = all.indexWhere((item) => item.id == metrics.id);
      
      if (index >= 0) {
        all[index] = metrics;
      } else {
        all.add(metrics);
      }

      await _saveAll(all);
    } catch (e) {
      throw StorageException(message: 'Failed to cache metrics: $e');
    }
  }

  @override
  Future<void> cacheAllMetricss(List<MetricsModel> metricss) async {
    try {
      await _saveAll(metricss);
    } catch (e) {
      throw StorageException(message: 'Failed to cache metricss: $e');
    }
  }

  @override
  Future<void> removeMetrics(String id) async {
    try {
      final all = await getAllMetricss();
      all.removeWhere((item) => item.id == id);
      await _saveAll(all);
    } catch (e) {
      throw StorageException(message: 'Failed to remove metrics: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await _storage.remove(_metricsCacheKey);
    } catch (e) {
      throw StorageException(message: 'Failed to clear cache: $e');
    }
  }

  Future<void> _saveAll(List<MetricsModel> items) async {
    final jsonList = items.map((item) => item.toJson()).toList();
    await _storage.setString(_metricsCacheKey, jsonEncode(jsonList));
  }
}
