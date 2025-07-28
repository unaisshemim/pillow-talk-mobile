mixin PInfinityScroll<T> {
  final List<T> items = [];
  int _offset = 0;
  int _limit = 10;
  bool _hasMore = true;
  bool _isLoading = false;

  int get offset => _offset;
  int get limit => _limit;
  bool get hasMore => _hasMore;
  bool get isLoading => _isLoading;

  // Configurable limit
  void setLimit(int limit) {
    _limit = limit;
  }

  // Mark loading started
  void startLoading() {
    _isLoading = true;
  }

  // Mark loading finished
  void finishLoading() {
    _isLoading = false;
  }

  // Check if we should load more
  bool shouldLoadMore() {
    return !_isLoading && _hasMore;
  }

  // Process loaded items
  void processLoadedItems(List<T> loadedItems) {
    items.addAll(loadedItems);
    _offset += loadedItems.length;
  }

  // Reset pagination state
  void resetPagination() {
    items.clear();
    _offset = 0;
    _hasMore = true;
    _isLoading = false;
  }

  // Remove an item by condition
  T? getItem(bool Function(T) condition) {
    final index = items.indexWhere(condition);
    if (index != -1) {
      return items[index];
    }
    return null;
  }

  // Remove an item by condition
  void removeItem(bool Function(T) condition) {
    items.removeWhere(condition);
  }

  // Update an item by condition
  void updateItem(bool Function(T) condition, T updatedItem) {
    final index = items.indexWhere(condition);
    if (index != -1) {
      items[index] = updatedItem;
    }
  }

  // Update multiple items by condition
  void updateItems(bool Function(T) condition, T Function(T) updater) {
    for (int i = 0; i < items.length; i++) {
      if (condition(items[i])) {
        items[i] = updater(items[i]);
      }
    }
  }

  // Replace all items that match a condition
  void replaceItems(bool Function(T) condition, List<T> newItems) {
    items.removeWhere(condition);
    items.addAll(newItems);
  }

  // Completely replace the list with new items
  void setItems(List<T> newItems) {
    items.clear();
    items.addAll(newItems);
  }

  set hasMore(bool value) {
    _hasMore = value;
  }
}
