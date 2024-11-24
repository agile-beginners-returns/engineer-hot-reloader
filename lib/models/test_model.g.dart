// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tests _$TestsFromJson(Map<String, dynamic> json) => Tests(
      tests: (json['tests'] as List<dynamic>)
          .map((e) => Tests.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TestsToJson(Tests instance) => <String, dynamic>{
      'tests': instance.tests,
    };

Test _$TestFromJson(Map<String, dynamic> json) => Test(
      question: json['question'] as String?,
      choices: (json['choices'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      answer: json['answer'] as String?,
      otherMeanings: json['otherMeanings'] as String?,
      example: json['example'] as String?,
      content: json['content'] as String?,
    );

Map<String, dynamic> _$TestToJson(Test instance) => <String, dynamic>{
      'question': instance.question,
      'choices': instance.choices,
      'answer': instance.answer,
      'otherMeanings': instance.otherMeanings,
      'example': instance.example,
      'content': instance.content,
    };
