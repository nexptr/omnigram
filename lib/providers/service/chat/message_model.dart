import 'dart:convert';

import 'package:objectbox/objectbox.dart';
import 'package:omnigram/providers/openai/chat/enum.dart';

import '../../../models/value_serializer.dart';

import '../../../models/objectbox.g.dart';

enum MessageType { text, image, loading, error, vendor }

// enum MessageFromType { receive, send }

// Annotate a Dart class to create a box
@Entity()
class Message {
  static const loadingIdPrefix = 'loading__';
  static const errorIdPrefix = 'error__';

  @Id()
  int id;

  @Index()
  final int conversationId;

  @Transient()
  MessageType? type;
  @Transient()
  Role role;
  final String? serviceName;
  final String? serviceAvatar;
  String content;
  @Property(type: PropertyType.date)
  final DateTime? createAt;
  final String? responseData;

  // final Message? requestMessage;
  // final Message? quoteMessage;
  // final String? serviceId;

  int? get dbMessageType {
    // _ensureStableEnumValues();
    return type?.index;
  }

  set dbMessageType(int? value) {
    // _ensureStableEnumValues();
    if (value == null) {
      type = null;
    } else {
      // type = MessageType.values[value]; // throws a RangeError if not found

      // or if you want to handle unknown values gracefully:
      type = value >= 0 && value < MessageType.values.length
          ? MessageType.values[value]
          : MessageType.text;
    }
  }

  int? get dbMessageFromType {
    // _ensureStableEnumValues();
    return role.index;
  }

  set dbMessageFromType(int? value) {
    // _ensureStableEnumValues();
    if (value == null) {
      role = Role.system;
    } else {
      // type = MessageType.values[value]; // throws a RangeError if not found

      // or if you want to handle unknown values gracefully:
      role = value >= 0 && value < Role.values.length
          ? Role.values[value]
          : Role.system;
    }
  }

  String get loadingId => '$loadingIdPrefix$id';
  String get errorId => '$errorIdPrefix$id';

  Message({
    this.id = 0,
    this.type,
    this.role = Role.system,
    this.serviceName,
    this.serviceAvatar,
    this.content = '',
    this.createAt,
    // this.requestMessage,
    this.responseData,
    // this.quoteMessage,
    required this.conversationId,
    // this.serviceId,
  });

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) {
    const serializer = ValueSerializer();
    // final requestMessageJson = serializer.fromJson<String?>(
    //   json["request_message"],
    // );
    // final quoteMessage = serializer.fromJson<String?>(
    //   json["quote_message"],
    // );
    return Message(
      id: serializer.fromJson<int>(json['id']),
      type: MessageType.values[serializer.fromJson<int?>(json['type']) ?? 0],
      role: Role.values[serializer.fromJson<int?>(json['from_type']) ?? 0],
      serviceName: serializer.fromJson<String?>(json['service_name']),
      serviceAvatar: serializer.fromJson<String?>(json['service_avatar']),
      content: serializer.fromJson<String>(json['content']),
      createAt: serializer.fromJson<DateTime?>(json['create_at']),
      // requestMessage: requestMessageJson == null
      //     ? null
      //     : Message.fromRawJson(requestMessageJson),
      // quoteMessage:
      //     quoteMessage == null ? null : Message.fromRawJson(quoteMessage),
      responseData: serializer.fromJson<String?>(json["response_data"]),
      conversationId: serializer.fromJson<int>(json['conversation_id']),
    );
  }

  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    const serializer = ValueSerializer();
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'type': serializer.toJson<int?>(type?.index),
      'role': serializer.toJson<int?>(role.index),
      'service_name': serializer.toJson<String?>(serviceName),
      'service_avatar': serializer.toJson<String?>(serviceAvatar),
      'content': serializer.toJson<String?>(content),
      'create_at': serializer.toJson<DateTime?>(createAt),
      // 'request_message':
      //     serializer.toJson<String?>(requestMessage?.toRawJson()),
      // 'quote_message': serializer.toJson<String?>(quoteMessage?.toRawJson()),
      'response_data': serializer.toJson<String?>(responseData),
      'conversation_id': serializer.toJson<int?>(conversationId),
    };
  }

  Message copyWith({
    int? id,
    MessageType? type,
    Role? role,
    String? serviceName,
    String? serviceAvatar,
    String? content,
    DateTime? createAt,
    Message? requestMessage,
    Message? quoteMessage,
    String? responseData,
    int? conversationId,
    String? serviceId,
  }) =>
      Message(
        id: id ?? this.id,
        type: type ?? this.type,
        role: role ?? this.role,
        serviceName: serviceName ?? this.serviceName,
        serviceAvatar: serviceAvatar ?? this.serviceAvatar,
        content: content ?? this.content,
        createAt: createAt ?? this.createAt,
        // requestMessage: requestMessage ?? this.requestMessage,
        // quoteMessage: quoteMessage ?? this.quoteMessage,
        responseData: responseData ?? this.responseData,
        conversationId: conversationId ?? this.conversationId,
      );

  @override
  String toString() {
    return (StringBuffer('MessageMetadata(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('role: $role, ')
          ..write('serviceName: $serviceName, ')
          ..write('serviceAvatar: $serviceAvatar, ')
          ..write('content: $content, ')
          ..write('createAt: $createAt, ')
          // ..write('requestMessage: $requestMessage, ')
          // ..write('quoteMessage: $quoteMessage, ')
          ..write('data: $responseData, ')
          ..write('conversationId: $conversationId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
        id,
        type,
        role,
        serviceName,
        serviceAvatar,
        content,
        createAt,
        // requestMessage,
        // quoteMessage,
        responseData,
        conversationId,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          other.id == id &&
          other.type == type &&
          other.role == role &&
          other.serviceName == serviceName &&
          other.serviceAvatar == serviceAvatar &&
          other.content == content &&
          other.createAt == createAt &&
          // other.requestMessage == requestMessage &&
          // other.quoteMessage == quoteMessage &&
          other.responseData == responseData &&
          other.conversationId == conversationId);
}