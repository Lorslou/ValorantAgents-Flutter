class CloudFavoritesException implements Exception {
  const CloudFavoritesException();
}

class CouldNotAddFavoriteException extends CloudFavoritesException {}

class CouldNotRemoveFavoriteException extends CloudFavoritesException {}
