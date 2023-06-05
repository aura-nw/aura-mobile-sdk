extension StringE on String? {
  bool get isNull => this == null;

  bool get isNotNull => !isNull;

  bool get isNullOrEmpty {
    if (isNull) return true;
    if (this!.isEmpty) return true;

    return false;
  }

  bool get isNotNullOrEmpty => !isNullOrEmpty;
}
