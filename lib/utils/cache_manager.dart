import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager {
  CustomCacheManager._privateConstructor();


  static final CustomCacheManager _instance = CustomCacheManager._privateConstructor();

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
