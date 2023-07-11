import 'package:aura_wallet_example/src/core/utils/dart_core_extension.dart';

class CheckResult {
  final bool isSuccess;
  final String? message;

  const CheckResult(
    this.isSuccess, {
    this.message,
  });

  CheckResult.success() : this(true);

  CheckResult.failure(
    String message,
  ) : this(
          false,
          message: message,
        );
}

typedef CheckFunction = CheckResult Function(String value);

abstract class Constraint<T> {
  final bool isValidOnChanged;
  final String errorMessage;

  CheckResult valid(String source);

  Constraint({
    this.isValidOnChanged = true,
    required this.errorMessage,
  });
}

class ConstraintManager {
  final bool isStopWhenFirstFailure;
  final bool isValidOnChanged;

  ConstraintManager({
    this.isStopWhenFirstFailure = false,
    this.isValidOnChanged = true,
  });

  final List<Constraint> _list = [];

  CheckResult checkAll(
    String source, {
    bool isJoinMessage = true,
  }) {
    String message = '';

    if (_list.isNullOrEmpty) return CheckResult.success();
    bool isSuccess = true;
    List<CheckResult> resultList = [];
    for (Constraint constraint in _list) {
      if (!constraint.isValidOnChanged) continue;

      CheckResult result = constraint.valid(source);
      if (!result.isSuccess) {
        isSuccess = false;
        resultList.add(result);
        if (isStopWhenFirstFailure == true) break;
      }
    }
    message =
        resultList.map((e) => e.message).join(isJoinMessage ? ', ' : '\n');
    return CheckResult(isSuccess, message: message);
  }

  ConstraintManager custom({
    required String errorMessage,
    bool? isValidOnChanged,
    bool idAdd = true,
    required bool Function(String) customValid,
  }) {
    if (!idAdd) return this;
    _list.add(CustomConstraint(
      customValid: customValid,
      isValidOnChanged: isValidOnChanged ?? this.isValidOnChanged,
      errorMessage: errorMessage,
    ));
    return this;
  }

  ConstraintManager isNumber({
    required String errorMessage,
    bool? isValidOnChanged,
    bool idAdd = true,
  }) {
    if (!idAdd) return this;
    _list.add(IsNumberConstraint(
      isValidOnChanged: isValidOnChanged ?? this.isValidOnChanged,
      errorMessage: errorMessage,
    ));
    return this;
  }

  ConstraintManager equal({
    required String value,
    required String errorMessage,
    bool? isValidOnChanged,
    bool idAdd = true,
  }) {
    if (!idAdd) return this;
    _list.add(EqualConstraint(
        value: value,
        isValidOnChanged: isValidOnChanged ?? this.isValidOnChanged,
        errorMessage: errorMessage));
    return this;
  }

  ConstraintManager notEqual({
    required String value,
    required String errorMessage,
    bool? isValidOnChanged,
    bool idAdd = true,
  }) {
    if (!idAdd) return this;
    _list.add(NotEqualConstraint(
      value: value,
      isValidOnChanged: isValidOnChanged ?? this.isValidOnChanged,
      errorMessage: errorMessage,
    ));
    return this;
  }

  ConstraintManager notEmpty({
    required String errorMessage,
    bool? isValidOnChanged,
    bool idAdd = true,
  }) {
    if (!idAdd) return this;
    _list.add(NotEmptyConstraint(
      isValidOnChanged: isValidOnChanged ?? this.isValidOnChanged,
      errorMessage: errorMessage,
    ));
    return this;
  }

  ConstraintManager maxLength({
    required int maxLength,
    required String errorMessage,
    bool? isValidOnChanged,
    bool idAdd = true,
  }) {
    if (!idAdd) return this;
    _list.add(MaxLengthConstraint(
      maxLength: maxLength,
      errorMessage: errorMessage,
      isValidOnChanged: isValidOnChanged ?? this.isValidOnChanged,
    ));
    return this;
  }

  ConstraintManager minLength({
    required int minLength,
    required String errorMessage,
    bool? isValidOnChanged,
    bool idAdd = true,
  }) {
    if (!idAdd) return this;
    _list.add(MinLengthConstraint(
      minLength: minLength,
      errorMessage: errorMessage,
      isValidOnChanged: isValidOnChanged ?? this.isValidOnChanged,
    ));
    return this;
  }

  ConstraintManager email({
    required String errorMessage,
    bool? isValidOnChanged,
    bool idAdd = true,
  }) {
    if (!idAdd) return this;
    _list.add(RegexpConstraint.email(
      errorMessage: errorMessage,
      isValidOnChanged: isValidOnChanged ?? this.isValidOnChanged,
    ));
    return this;
  }

  ConstraintManager phone({
    required String errorMessage,
    bool? isValidOnChanged,
    bool idAdd = true,
  }) {
    if (!idAdd) return this;
    _list.add(
      RegexpConstraint.phoneNumber(
        errorMessage: errorMessage,
        isValidOnChanged: isValidOnChanged ?? this.isValidOnChanged,
      ),
    );
    return this;
  }

  ConstraintManager password({
    required String errorMessage,
    bool? isValidOnChanged,
    bool idAdd = true,
  }) {
    if (!idAdd) return this;
    _list.add(RegexpConstraint.password(
      errorMessage: errorMessage,
      isValidOnChanged: isValidOnChanged ?? this.isValidOnChanged,
    ));
    return this;
  }

  List<Constraint> get constraints {
    return _list;
  }
}

class RegexpConstraint extends Constraint {
  final String? regex;

  static const String _emailPattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const String _passwordPattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
  static const String _phonePattern = r"^(?:[+0]9)?[0-9]{10,}$";

  RegexpConstraint({
    this.regex,
    required String errorMessage,
    required bool isValidOnChanged,
  }) : super(
          isValidOnChanged: isValidOnChanged,
          errorMessage: errorMessage,
        );

  @override
  CheckResult valid(String source) {
    if (regex.isEmptyOrNull) return CheckResult.success();

    final RegExp regExp = RegExp(regex!);

    return CheckResult(
      regExp.hasMatch(source),
      message: errorMessage,
    );
  }

  RegexpConstraint.email({
    required String errorMessage,
    required bool isValidOnChanged,
  }) : this(
          regex: _emailPattern,
          errorMessage: errorMessage,
          isValidOnChanged: isValidOnChanged,
        );

  RegexpConstraint.phoneNumber({
    required String errorMessage,
    required bool isValidOnChanged,
  }) : this(
          regex: _phonePattern,
          errorMessage: errorMessage,
          isValidOnChanged: isValidOnChanged,
        );

  RegexpConstraint.password({
    required String errorMessage,
    required bool isValidOnChanged,
  }) : this(
          regex: _passwordPattern,
          errorMessage: errorMessage,
          isValidOnChanged: isValidOnChanged,
        );
}

class IsNumberConstraint extends Constraint {
  @override
  CheckResult valid(String source) {
    final number = int.tryParse(source);
    return CheckResult(
      number != null,
      message: errorMessage,
    );
  }

  IsNumberConstraint({
    required bool isValidOnChanged,
    required String errorMessage,
  }) : super(
          isValidOnChanged: isValidOnChanged,
          errorMessage: errorMessage,
        );
}

class EqualConstraint extends Constraint {
  final String value;

  @override
  CheckResult valid(String source) {
    return CheckResult(
      source == value,
      message: errorMessage,
    );
  }

  EqualConstraint({
    required this.value,
    required bool isValidOnChanged,
    required String errorMessage,
  }) : super(
          isValidOnChanged: isValidOnChanged,
          errorMessage: errorMessage,
        );
}

class MinLengthConstraint extends Constraint {
  final int minLength;

  MinLengthConstraint({
    required this.minLength,
    required bool isValidOnChanged,
    required String errorMessage,
  }) : super(
          isValidOnChanged: isValidOnChanged,
          errorMessage: errorMessage,
        );

  @override
  CheckResult valid(String source) {
    return CheckResult(
      source.length >= minLength,
      message: errorMessage,
    );
  }
}

class MaxLengthConstraint extends Constraint {
  final int maxLength;

  @override
  CheckResult valid(String source) {
    return CheckResult(
      source.length <= maxLength,
      message: errorMessage,
    );
  }

  MaxLengthConstraint({
    required this.maxLength,
    required bool isValidOnChanged,
    required String errorMessage,
  }) : super(
          isValidOnChanged: isValidOnChanged,
          errorMessage: errorMessage,
        );
}

class NotEqualConstraint extends Constraint {
  final String value;

  NotEqualConstraint({
    required this.value,
    required bool isValidOnChanged,
    required String errorMessage,
  }) : super(
          isValidOnChanged: isValidOnChanged,
          errorMessage: errorMessage,
        );

  @override
  CheckResult valid(String source) {
    return CheckResult(
      value.compareTo(source) != 0,
      message: errorMessage,
    );
  }
}

class NotEmptyConstraint extends Constraint {
  @override
  CheckResult valid(String source) {
    return CheckResult(
      source.isNotNullOrEmpty,
      message: errorMessage,
    );
  }

  NotEmptyConstraint({
    bool isValidOnChanged = true,
    required String errorMessage,
  }) : super(
          isValidOnChanged: isValidOnChanged,
          errorMessage: errorMessage,
        );
}

class CustomConstraint extends Constraint {
  final bool Function(String source) customValid;

  @override
  CheckResult valid(String source) {
    return CheckResult(
      customValid(source),
      message: errorMessage,
    );
  }

  CustomConstraint({
    required this.customValid,
    bool isValidOnChanged = true,
    required String errorMessage,
  }) : super(
          isValidOnChanged: isValidOnChanged,
          errorMessage: errorMessage,
        );
}
