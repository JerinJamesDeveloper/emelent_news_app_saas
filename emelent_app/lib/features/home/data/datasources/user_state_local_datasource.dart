/// UserState Local Data Source
///
/// Handles local storage operations for user_state data.
/// Uses LocalStorage for caching.
library;

import 'dart:convert';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/storage/local_storage.dart';
import '../models/user_state_model.dart';

/// Storage key for user_state cache
const String _userStateCacheKey = 'cached_user_states';

/// Abstract interface for user_state local data source
abstract class UserStateLocalDataSource {
  /// Gets a cached user_state by ID
  Future<UserStateModel?> getUserState(String id);

  /// Gets all cached user_states
  Future<List<UserStateModel>> getAllUserStates();

  /// Caches a user_state
  Future<void> cacheUserState(UserStateModel userState);

  /// Caches all user_states
  Future<void> cacheAllUserStates(List<UserStateModel> userStates);

  /// Removes a cached user_state
  Future<void> removeUserState(String id);
  
  /// Clears all cached user_states
  Future<void> clearCache();
}

/// Implementation of UserStateLocalDataSource
class UserStateLocalDataSourceImpl implements UserStateLocalDataSource {
  final LocalStorage _storage;

  UserStateLocalDataSourceImpl(this._storage);

  @override
  Future<UserStateModel?> getUserState(String id) async {
    try {
      final all = await getAllUserStates();
      return all.where((item) => item.id == id).firstOrNull;
    } catch (e) {
      throw StorageException(message: 'Failed to get user_state: $e');
    }
  }

  @override
  Future<List<UserStateModel>> getAllUserStates() async {
    try {
      final jsonString = await _storage.getString(_userStateCacheKey);
      if (jsonString == null) return [];

      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((json) => UserStateModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw StorageException(message: 'Failed to get user_states: $e');
    }
  }

  @override
  Future<void> cacheUserState(UserStateModel userState) async {
    try {
      final all = await getAllUserStates();
      final index = all.indexWhere((item) => item.id == userState.id);
      
      if (index >= 0) {
        all[index] = userState;
      } else {
        all.add(userState);
      }

      await _saveAll(all);
    } catch (e) {
      throw StorageException(message: 'Failed to cache user_state: $e');
    }
  }

  @override
  Future<void> cacheAllUserStates(List<UserStateModel> userStates) async {
    try {
      await _saveAll(userStates);
    } catch (e) {
      throw StorageException(message: 'Failed to cache user_states: $e');
    }
  }

  @override
  Future<void> removeUserState(String id) async {
    try {
      final all = await getAllUserStates();
      all.removeWhere((item) => item.id == id);
      await _saveAll(all);
    } catch (e) {
      throw StorageException(message: 'Failed to remove user_state: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await _storage.remove(_userStateCacheKey);
    } catch (e) {
      throw StorageException(message: 'Failed to clear cache: $e');
    }
  }

  Future<void> _saveAll(List<UserStateModel> items) async {
    final jsonList = items.map((item) => item.toJson()).toList();
    await _storage.setString(_userStateCacheKey, jsonEncode(jsonList));
  }
}
