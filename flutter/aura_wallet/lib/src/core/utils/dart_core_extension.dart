import 'dart:math';

extension StringExtensions on String? {
  bool get isEmptyOrNull {
    if (this == null) {
      return true;
    }
    if (this!.isEmpty) {
      return true;
    }
    return false;
  }

  bool get isNotNullOrEmpty => !isEmptyOrNull;

  String subStringOr(int start, int end) {
    if (isEmptyOrNull) return '';

    if (this!.length < end) return this!;

    return this!.substring(start, end);
  }

  String get addressView {
    if (isEmptyOrNull) return '';
    if (this!.length < 32) return this!;

    return '${this!.substring(0, 6)}....${this!.substring(this!.length - 5, this!.length)}';
  }
}

extension ListExtensions<T> on List<T>? {
  bool get isNullOrEmpty {
    if (this == null) return true;

    if (this!.isEmpty) return true;

    return false;
  }

  bool get isNotNullOrEmpty => !isNullOrEmpty;

  T? get firstOrNull {
    if (isNotNullOrEmpty) return this!.first;
    return null;
  }

  T? firstWhereOrNull(bool Function(T) test) {
    if (isNullOrEmpty) return null;

    for (final e in this!) {
      if (test(e)) {
        return e;
      }
    }
    return null;
  }

  bool isNotNull(int index) {
    if (isNullOrEmpty) return false;

    if (index < 0) return false;

    return true;
  }

  T? lastWhereOrNull(bool Function(T) test) {
    if (isNullOrEmpty) return null;

    List<T> list = List.empty(growable: true);

    for (final e in this!) {
      if (test(e)) {
        list.add(e);
      }
    }

    if (list.isNullOrEmpty) return null;

    return list.last;
  }

  bool constantIndex(int i) {
    if (isNullOrEmpty) return false;

    if (i < 0) return false;

    if (i > this!.length - 1) {
      return false;
    }

    return true;
  }
}

extension TruncateDoubles on double {
  double truncateToDecimalPlaces(int fractionalDigits) =>
      (this * pow(10, fractionalDigits)).truncate() / pow(10, fractionalDigits);
}
