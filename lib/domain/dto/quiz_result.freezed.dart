// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quiz_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$QuizResult {
  List<Question> get questionList => throw _privateConstructorUsedError;
  double get totalCorrect => throw _privateConstructorUsedError;
  List<int> get takenQuestions => throw _privateConstructorUsedError;
  List<bool> get answerIsCorrectList => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $QuizResultCopyWith<QuizResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QuizResultCopyWith<$Res> {
  factory $QuizResultCopyWith(
          QuizResult value, $Res Function(QuizResult) then) =
      _$QuizResultCopyWithImpl<$Res, QuizResult>;
  @useResult
  $Res call(
      {List<Question> questionList,
      double totalCorrect,
      List<int> takenQuestions,
      List<bool> answerIsCorrectList});
}

/// @nodoc
class _$QuizResultCopyWithImpl<$Res, $Val extends QuizResult>
    implements $QuizResultCopyWith<$Res> {
  _$QuizResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionList = null,
    Object? totalCorrect = null,
    Object? takenQuestions = null,
    Object? answerIsCorrectList = null,
  }) {
    return _then(_value.copyWith(
      questionList: null == questionList
          ? _value.questionList
          : questionList // ignore: cast_nullable_to_non_nullable
              as List<Question>,
      totalCorrect: null == totalCorrect
          ? _value.totalCorrect
          : totalCorrect // ignore: cast_nullable_to_non_nullable
              as double,
      takenQuestions: null == takenQuestions
          ? _value.takenQuestions
          : takenQuestions // ignore: cast_nullable_to_non_nullable
              as List<int>,
      answerIsCorrectList: null == answerIsCorrectList
          ? _value.answerIsCorrectList
          : answerIsCorrectList // ignore: cast_nullable_to_non_nullable
              as List<bool>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_QuizResultCopyWith<$Res>
    implements $QuizResultCopyWith<$Res> {
  factory _$$_QuizResultCopyWith(
          _$_QuizResult value, $Res Function(_$_QuizResult) then) =
      __$$_QuizResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Question> questionList,
      double totalCorrect,
      List<int> takenQuestions,
      List<bool> answerIsCorrectList});
}

/// @nodoc
class __$$_QuizResultCopyWithImpl<$Res>
    extends _$QuizResultCopyWithImpl<$Res, _$_QuizResult>
    implements _$$_QuizResultCopyWith<$Res> {
  __$$_QuizResultCopyWithImpl(
      _$_QuizResult _value, $Res Function(_$_QuizResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? questionList = null,
    Object? totalCorrect = null,
    Object? takenQuestions = null,
    Object? answerIsCorrectList = null,
  }) {
    return _then(_$_QuizResult(
      questionList: null == questionList
          ? _value._questionList
          : questionList // ignore: cast_nullable_to_non_nullable
              as List<Question>,
      totalCorrect: null == totalCorrect
          ? _value.totalCorrect
          : totalCorrect // ignore: cast_nullable_to_non_nullable
              as double,
      takenQuestions: null == takenQuestions
          ? _value._takenQuestions
          : takenQuestions // ignore: cast_nullable_to_non_nullable
              as List<int>,
      answerIsCorrectList: null == answerIsCorrectList
          ? _value._answerIsCorrectList
          : answerIsCorrectList // ignore: cast_nullable_to_non_nullable
              as List<bool>,
    ));
  }
}

/// @nodoc

class _$_QuizResult implements _QuizResult {
  const _$_QuizResult(
      {required final List<Question> questionList,
      required this.totalCorrect,
      required final List<int> takenQuestions,
      required final List<bool> answerIsCorrectList})
      : _questionList = questionList,
        _takenQuestions = takenQuestions,
        _answerIsCorrectList = answerIsCorrectList;

  final List<Question> _questionList;
  @override
  List<Question> get questionList {
    if (_questionList is EqualUnmodifiableListView) return _questionList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_questionList);
  }

  @override
  final double totalCorrect;
  final List<int> _takenQuestions;
  @override
  List<int> get takenQuestions {
    if (_takenQuestions is EqualUnmodifiableListView) return _takenQuestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_takenQuestions);
  }

  final List<bool> _answerIsCorrectList;
  @override
  List<bool> get answerIsCorrectList {
    if (_answerIsCorrectList is EqualUnmodifiableListView)
      return _answerIsCorrectList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answerIsCorrectList);
  }

  @override
  String toString() {
    return 'QuizResult(questionList: $questionList, totalCorrect: $totalCorrect, takenQuestions: $takenQuestions, answerIsCorrectList: $answerIsCorrectList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_QuizResult &&
            const DeepCollectionEquality()
                .equals(other._questionList, _questionList) &&
            (identical(other.totalCorrect, totalCorrect) ||
                other.totalCorrect == totalCorrect) &&
            const DeepCollectionEquality()
                .equals(other._takenQuestions, _takenQuestions) &&
            const DeepCollectionEquality()
                .equals(other._answerIsCorrectList, _answerIsCorrectList));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_questionList),
      totalCorrect,
      const DeepCollectionEquality().hash(_takenQuestions),
      const DeepCollectionEquality().hash(_answerIsCorrectList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_QuizResultCopyWith<_$_QuizResult> get copyWith =>
      __$$_QuizResultCopyWithImpl<_$_QuizResult>(this, _$identity);
}

abstract class _QuizResult implements QuizResult {
  const factory _QuizResult(
      {required final List<Question> questionList,
      required final double totalCorrect,
      required final List<int> takenQuestions,
      required final List<bool> answerIsCorrectList}) = _$_QuizResult;

  @override
  List<Question> get questionList;
  @override
  double get totalCorrect;
  @override
  List<int> get takenQuestions;
  @override
  List<bool> get answerIsCorrectList;
  @override
  @JsonKey(ignore: true)
  _$$_QuizResultCopyWith<_$_QuizResult> get copyWith =>
      throw _privateConstructorUsedError;
}
