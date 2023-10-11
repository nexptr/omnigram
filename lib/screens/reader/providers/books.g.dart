// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookNavImpl _$$BookNavImplFromJson(Map<String, dynamic> json) =>
    _$BookNavImpl(
      recent: (json['recent'] as List<dynamic>?)
          ?.map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList(),
      random: (json['random'] as List<dynamic>?)
          ?.map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList(),
      reading: (json['reading'] as List<dynamic>?)
          ?.map((e) => Book.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$BookNavImplToJson(_$BookNavImpl instance) =>
    <String, dynamic>{
      'recent': instance.recent,
      'random': instance.random,
      'reading': instance.reading,
    };

_$BookSearchImpl _$$BookSearchImplFromJson(Map<String, dynamic> json) =>
    _$BookSearchImpl(
      search: json['search'] as String?,
      author: json['author'] as String?,
      publisher: json['publisher'] as String?,
      tags: json['tags'] as String?,
    );

Map<String, dynamic> _$$BookSearchImplToJson(_$BookSearchImpl instance) =>
    <String, dynamic>{
      'search': instance.search,
      'author': instance.author,
      'publisher': instance.publisher,
      'tags': instance.tags,
    };

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$booksHash() => r'4cbe9a2a0318c9ae7a0e6b8a4196474792727924';

/// See also [Books].
@ProviderFor(Books)
final booksProvider = AutoDisposeAsyncNotifierProvider<Books, BookNav>.internal(
  Books.new,
  name: r'booksProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$booksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Books = AutoDisposeAsyncNotifier<BookNav>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member