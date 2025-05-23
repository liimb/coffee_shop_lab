Future<T> fetchWithRetry<T>(
    Future<T> Function() fetch, {
      int attempts = 2,
      Duration delay = const Duration(seconds: 1),
    }) async {
  for (int i = 0; i < attempts; i++) {
    try {
      return await fetch();
    } catch (e) {
      if (i == attempts - 1) rethrow;
      await Future.delayed(delay);
    }
  }
  throw Exception('Unreachable');
}
