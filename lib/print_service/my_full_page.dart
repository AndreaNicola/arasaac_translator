class MyFullPage<T> {
  final int maxRows;
  final int maxColumns;
  final List<List<T?>> _page = [];
  int _lastRow = 0;
  int _lastColumn = 0;

  int get lastRow => _lastRow;

  int get lastColumn => _lastColumn;

  List<T?> get page => _page.fold([], (previousValue, element) => previousValue..addAll(element));

  void add(T item) {
    if (_lastColumn == maxColumns) {
      _lastRow++;
      _lastColumn = 0;
    }
    if (_lastRow == maxRows) {
      throw Exception("Page is full");
    }
    _page[_lastRow][_lastColumn] = item;
    _lastColumn++;
  }

  void newLine() {
    if (_lastRow == maxRows) {
      throw Exception("Page is full");
    }
    _lastRow++;
    _lastColumn = 0;
  }

  MyFullPage({required this.maxRows, required this.maxColumns}) {
    for (var i = 0; i < maxRows; i++) {
      _page.add(List<T?>.filled(maxColumns, null));
    }
  }

}
