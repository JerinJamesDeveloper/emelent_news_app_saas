/// FeedPost Local Data Source
///
/// Handles local storage operations for feed_post data.
/// Uses LocalStorage for caching.
library;

import 'dart:convert';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/storage/local_storage.dart';
import '../models/feed_post_model.dart';

/// Storage key for feed_post cache
const String _feedPostCacheKey = 'cached_feed_posts';

/// Abstract interface for feed_post local data source
abstract class FeedPostLocalDataSource {
  /// Gets a cached feed_post by ID
  Future<FeedPostModel?> getFeedPost(String id);

  /// Gets all cached feed_posts
  Future<List<FeedPostModel>> getAllFeedPosts();

  /// Caches a feed_post
  Future<void> cacheFeedPost(FeedPostModel feedPost);

  /// Caches all feed_posts
  Future<void> cacheAllFeedPosts(List<FeedPostModel> feedPosts);

  /// Removes a cached feed_post
  Future<void> removeFeedPost(String id);
  
  /// Clears all cached feed_posts
  Future<void> clearCache();
}

/// Implementation of FeedPostLocalDataSource
class FeedPostLocalDataSourceImpl implements FeedPostLocalDataSource {
  final LocalStorage _storage;

  FeedPostLocalDataSourceImpl(this._storage);

  @override
  Future<FeedPostModel?> getFeedPost(String id) async {
    try {
      final all = await getAllFeedPosts();
      return all.where((item) => item.id == id).firstOrNull;
    } catch (e) {
      throw StorageException(message: 'Failed to get feed_post: $e');
    }
  }

  @override
  Future<List<FeedPostModel>> getAllFeedPosts() async {
    try {
      final jsonString = await _storage.getString(_feedPostCacheKey);
      if (jsonString == null) return [];

      final List<dynamic> jsonList = jsonDecode(jsonString);
      return jsonList
          .map((json) => FeedPostModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw StorageException(message: 'Failed to get feed_posts: $e');
    }
  }

  @override
  Future<void> cacheFeedPost(FeedPostModel feedPost) async {
    try {
      final all = await getAllFeedPosts();
      final index = all.indexWhere((item) => item.id == feedPost.id);
      
      if (index >= 0) {
        all[index] = feedPost;
      } else {
        all.add(feedPost);
      }

      await _saveAll(all);
    } catch (e) {
      throw StorageException(message: 'Failed to cache feed_post: $e');
    }
  }

  @override
  Future<void> cacheAllFeedPosts(List<FeedPostModel> feedPosts) async {
    try {
      await _saveAll(feedPosts);
    } catch (e) {
      throw StorageException(message: 'Failed to cache feed_posts: $e');
    }
  }

  @override
  Future<void> removeFeedPost(String id) async {
    try {
      final all = await getAllFeedPosts();
      all.removeWhere((item) => item.id == id);
      await _saveAll(all);
    } catch (e) {
      throw StorageException(message: 'Failed to remove feed_post: $e');
    }
  }

  @override
  Future<void> clearCache() async {
    try {
      await _storage.remove(_feedPostCacheKey);
    } catch (e) {
      throw StorageException(message: 'Failed to clear cache: $e');
    }
  }

  Future<void> _saveAll(List<FeedPostModel> items) async {
    final jsonList = items.map((item) => item.toJson()).toList();
    await _storage.setString(_feedPostCacheKey, jsonEncode(jsonList));
  }
}
