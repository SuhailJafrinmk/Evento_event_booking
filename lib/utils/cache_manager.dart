import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager {
  // Private constructor
  CustomCacheManager._privateConstructor();

  // Singleton instance
  static final CustomCacheManager _instance = CustomCacheManager._privateConstructor();

  // Factory method to return the singleton instance
  factory CustomCacheManager() {
    return _instance;
  }

  // CacheManager instance with custom configuration
  CacheManager get cacheManager {
    return CacheManager(
      Config(
        'customCacheKey',
        stalePeriod: Duration(days: 7), // The cache duration before an image is considered stale
        maxNrOfCacheObjects: 100, // Maximum number of cached objects // Maximum age for each cached object
      ),
    );
  }
}
