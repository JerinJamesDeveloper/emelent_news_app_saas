/// Source Local Data Source
///
/// Handles local storage operations for source data.
/// Uses LocalStorage for caching.
library;

import 'dart:convert';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/storage/local_storage.dart';
import '../models/source_model.dart';

/// Storage key for source cache
const String _sourceCacheKey = 'cached_sources';

/// Abstract interface for source local data source
abstract class SourceLocalDataSource {
  /// Gets a cached source by ID
  Future<SourceModel?> getSource(String id);

  /// Gets all cached sources
  Future<List<SourceModel>> getAllSources();

  /// Caches a source
  Future<void> cacheSource(SourceModel source);

  /// Caches all sources
  Future<void> cacheAllSources(List<SourceModel> sources);

  /// Removes a cached source
  Future<void> removeSource(String id);
  
  /// Clears all cached sources
  Future<void> clearCache();
}

/// Implementation of SourceLocalDataSource
class SourceLocalDataSourceImpl implements SourceLocalDataSource {
  final LocalStorage _storage;

  SourceLocalDataSourceImpl(this._storage);

  @override
  Future<SourceModel?> getSource(String id) async {
    try {
      final all = await getAllSources();
      return all.where((item) => item.id == id).firstOrNull;
    } catch (e) {
      throw StorageException(message: 'Failed to get source: $e');
    }
  }

  @override
  Future<List<SourceModel>> getAllSources() async {
    try {
      final jsonString = await _storage.getString(_sourceCacheKey);
      if (jsonString == null) return [];

      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((json) => SourceModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw StorageException(message: 'Failed to get sources: $e');
    }
  }

  @override
  Future<void> cacheSource(SourceModel source) async {
    try {
      final all = await getAllSources();
      final index = all.indexWhere((item) => item.id == source.id);
      
      if (index >= 0) {
        all[index] = source;
      } else {
        all.add(source);
      }

      await _saveAll(all);
    } catch (e) {
      throw StorageException(message: 'Failed to cache source: $e');
    }
  }

  @override
  Future<void> cacheAllSources(List<SourceModel> sources) async {
    try {
      await _saveAll(sources);
    } catch (e) {
      throw StorageException(message: 'Failed to cache sources: $e');
    }
  }

  @override
  Future<void> removeSource(String id) async {
    try {
      final all = await getAllSources();
      all.removeWhere((item) => item.id == id);
      await _saveAll(all);
    } catch (e) {
      throw StorageException(message: 'Failed to remove source: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await _storage.remove(_sourceCacheKey);
    } catch (e) {
      throw StorageException(message: 'Failed to clear cache: $e');
    }
  }

  Future<void> _saveAll(List<SourceModel> items) async {
    final jsonList = items.map((item) => item.toJson()).toList();
    await _storage.setString(_sourceCacheKey, jsonEncode(jsonList));
  }
}
