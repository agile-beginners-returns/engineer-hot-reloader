import 'package:freezed_annotation/freezed_annotation.dart';
part 'test_model.g.dart';

@JsonSerializable()
class Tests {
  final List<Tests> tests;
  Tests({required this.tests});

  factory Tests.fromJson(Map<String, dynamic> json) => _$TestsFromJson(json);

  Map<String, dynamic> toJson() => _$TestsToJson(this);
}
@JsonSerializable()
class Test {
  final String? question;
  final Map<String, String>?  choices;
  final String? answer;
  final String? otherMeanings;
  final String? example;
  final String? content;

  Test({
    this.question,
    this.choices,
    this.answer,
    this.otherMeanings,
    this.example,
    this.content,
  });

  factory Test.fromJson(Map<String, dynamic> json) =>
      _$TestFromJson(json);
  Map<String, dynamic> toJson() => _$TestToJson(this);
}

