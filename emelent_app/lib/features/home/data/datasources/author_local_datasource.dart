/// Author Local Data Source
///
/// Handles local storage operations for author data.
/// Uses LocalStorage for caching.
library;

import 'dart:convert';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/storage/local_storage.dart';
import '../models/author_model.dart';

/// Storage key for author cache
const String _authorCacheKey = 'cached_authors';

/// Abstract interface for author local data source
abstract class AuthorLocalDataSource {
  /// Gets a cached author by ID
  Future<AuthorModel?> getAuthor(String id);

  /// Gets all cached authors
  Future<List<AuthorModel>> getAllAuthors();

  /// Caches a author
  Future<void> cacheAuthor(AuthorModel author);

  /// Caches all authors
  Future<void> cacheAllAuthors(List<AuthorModel> authors);

  /// Removes a cached author
  Future<void> removeAuthor(String id);
  
  /// Clears all cached authors
  Future<void> clearCache();
}

/// Implementation of AuthorLocalDataSource
class AuthorLocalDataSourceImpl implements AuthorLocalDataSource {
  final LocalStorage _storage;

  AuthorLocalDataSourceImpl(this._storage);

  @override
  Future<AuthorModel?> getAuthor(String id) async {
    try {
      final all = await getAllAuthors();
      return all.where((item) => item.id == id).firstOrNull;
    } catch (e) {
      throw StorageException(message: 'Failed to get author: $e');
    }
  }

  @override
  Future<List<AuthorModel>> getAllAuthors() async {
    try {
      final jsonString = await _storage.getString(_authorCacheKey);
      if (jsonString == null) return [];

      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((json) => AuthorModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw StorageException(message: 'Failed to get authors: $e');
    }
  }

  @override
  Future<void> cacheAuthor(AuthorModel author) async {
    try {
      final all = await getAllAuthors();
      final index = all.indexWhere((item) => item.id == author.id);
      
      if (index >= 0) {
        all[index] = author;
      } else {
        all.add(author);
      }

      await _saveAll(all);
    } catch (e) {
      throw StorageException(message: 'Failed to cache author: $e');
    }
  }

  @override
  Future<void> cacheAllAuthors(List<AuthorModel> authors) async {
    try {
      await _saveAll(authors);
    } catch (e) {
      throw StorageException(message: 'Failed to cache authors: $e');
    }
  }

  @override
  Future<void> removeAuthor(String id) async {
    try {
      final all = await getAllAuthors();
      all.removeWhere((item) => item.id == id);
      await _saveAll(all);
    } catch (e) {
      throw StorageException(message: 'Failed to remove author: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await _storage.remove(_authorCacheKey);
    } catch (e) {
      throw StorageException(message: 'Failed to clear cache: $e');
    }
  }

  Future<void> _saveAll(List<AuthorModel> items) async {
    final jsonList = items.map((item) => item.toJson()).toList();
    await _storage.setString(_authorCacheKey, jsonEncode(jsonList));
  }
}
