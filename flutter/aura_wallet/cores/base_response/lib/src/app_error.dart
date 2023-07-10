class AppError {
  final int code;
  final String ?message;

  const AppError({
    required this.code,
    this.message,
  });
}