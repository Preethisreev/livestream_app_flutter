/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'ModelProvider.dart';
import 'package:amplify_core/amplify_core.dart' as amplify_core;
import 'package:collection/collection.dart';


/** This is an auto generated class representing the Comments type in your schema. */
class Comments extends amplify_core.Model {
  static const classType = const _CommentsModelType();
  final String id;
  final String? _userName;
  final String? _comment;
  final String? _userIdentity;
  final List<Users>? _Uid;
  final Users? _username;
  final amplify_core.TemporalDateTime? _createdAt;
  final amplify_core.TemporalDateTime? _updatedAt;
  final String? _commentsUsernameId;

  @override
  getInstanceType() => classType;
  
  @Deprecated('[getId] is being deprecated in favor of custom primary key feature. Use getter [modelIdentifier] to get model identifier.')
  @override
  String getId() => id;
  
  CommentsModelIdentifier get modelIdentifier {
      return CommentsModelIdentifier(
        id: id
      );
  }
  
  String get userName {
    try {
      return _userName!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get comment {
    return _comment;
  }
  
  String get userIdentity {
    try {
      return _userIdentity!;
    } catch(e) {
      throw amplify_core.AmplifyCodeGenModelException(
          amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            amplify_core.AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  List<Users>? get Uid {
    return _Uid;
  }
  
  Users? get username {
    return _username;
  }
  
  amplify_core.TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  amplify_core.TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  String? get commentsUsernameId {
    return _commentsUsernameId;
  }
  
  const Comments._internal({required this.id, required userName, comment, required userIdentity, Uid, username, createdAt, updatedAt, commentsUsernameId}): _userName = userName, _comment = comment, _userIdentity = userIdentity, _Uid = Uid, _username = username, _createdAt = createdAt, _updatedAt = updatedAt, _commentsUsernameId = commentsUsernameId;
  
  factory Comments({String? id, required String userName, String? comment, required String userIdentity, List<Users>? Uid, Users? username, String? commentsUsernameId}) {
    return Comments._internal(
      id: id == null ? amplify_core.UUID.getUUID() : id,
      userName: userName,
      comment: comment,
      userIdentity: userIdentity,
      Uid: Uid != null ? List<Users>.unmodifiable(Uid) : Uid,
      username: username,
      commentsUsernameId: commentsUsernameId);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Comments &&
      id == other.id &&
      _userName == other._userName &&
      _comment == other._comment &&
      _userIdentity == other._userIdentity &&
      DeepCollectionEquality().equals(_Uid, other._Uid) &&
      _username == other._username &&
      _commentsUsernameId == other._commentsUsernameId;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("Comments {");
    buffer.write("id=" + "$id" + ", ");
    buffer.write("userName=" + "$_userName" + ", ");
    buffer.write("comment=" + "$_comment" + ", ");
    buffer.write("userIdentity=" + "$_userIdentity" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null") + ", ");
    buffer.write("commentsUsernameId=" + "$_commentsUsernameId");
    buffer.write("}");
    
    return buffer.toString();
  }
  
  Comments copyWith({String? userName, String? comment, String? userIdentity, List<Users>? Uid, Users? username, String? commentsUsernameId}) {
    return Comments._internal(
      id: id,
      userName: userName ?? this.userName,
      comment: comment ?? this.comment,
      userIdentity: userIdentity ?? this.userIdentity,
      Uid: Uid ?? this.Uid,
      username: username ?? this.username,
      commentsUsernameId: commentsUsernameId ?? this.commentsUsernameId);
  }
  
  Comments copyWithModelFieldValues({
    ModelFieldValue<String>? userName,
    ModelFieldValue<String?>? comment,
    ModelFieldValue<String>? userIdentity,
    ModelFieldValue<List<Users>?>? Uid,
    ModelFieldValue<Users?>? username,
    ModelFieldValue<String?>? commentsUsernameId
  }) {
    return Comments._internal(
      id: id,
      userName: userName == null ? this.userName : userName.value,
      comment: comment == null ? this.comment : comment.value,
      userIdentity: userIdentity == null ? this.userIdentity : userIdentity.value,
      Uid: Uid == null ? this.Uid : Uid.value,
      username: username == null ? this.username : username.value,
      commentsUsernameId: commentsUsernameId == null ? this.commentsUsernameId : commentsUsernameId.value
    );
  }
  
  Comments.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _userName = json['userName'],
      _comment = json['comment'],
      _userIdentity = json['userIdentity'],
      _Uid = json['Uid'] is List
        ? (json['Uid'] as List)
          .where((e) => e?['serializedData'] != null)
          .map((e) => Users.fromJson(new Map<String, dynamic>.from(e['serializedData'])))
          .toList()
        : null,
      _username = json['username']?['serializedData'] != null
        ? Users.fromJson(new Map<String, dynamic>.from(json['username']['serializedData']))
        : null,
      _createdAt = json['createdAt'] != null ? amplify_core.TemporalDateTime.fromString(json['createdAt']) : null,
      _updatedAt = json['updatedAt'] != null ? amplify_core.TemporalDateTime.fromString(json['updatedAt']) : null,
      _commentsUsernameId = json['commentsUsernameId'];
  
  Map<String, dynamic> toJson() => {
    'id': id, 'userName': _userName, 'comment': _comment, 'userIdentity': _userIdentity, 'Uid': _Uid?.map((Users? e) => e?.toJson()).toList(), 'username': _username?.toJson(), 'createdAt': _createdAt?.format(), 'updatedAt': _updatedAt?.format(), 'commentsUsernameId': _commentsUsernameId
  };
  
  Map<String, Object?> toMap() => {
    'id': id,
    'userName': _userName,
    'comment': _comment,
    'userIdentity': _userIdentity,
    'Uid': _Uid,
    'username': _username,
    'createdAt': _createdAt,
    'updatedAt': _updatedAt,
    'commentsUsernameId': _commentsUsernameId
  };

  static final amplify_core.QueryModelIdentifier<CommentsModelIdentifier> MODEL_IDENTIFIER = amplify_core.QueryModelIdentifier<CommentsModelIdentifier>();
  static final ID = amplify_core.QueryField(fieldName: "id");
  static final COMMENT = amplify_core.QueryField(fieldName: "comment");
  static final USERIDENTITY = amplify_core.QueryField(fieldName: "userIdentity");
  static final UID = amplify_core.QueryField(
    fieldName: "Uid",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Users'));
  static final USERNAME = amplify_core.QueryField(
    fieldName: "username",
    fieldType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.model, ofModelName: 'Users'));
  static final COMMENTSUSERNAMEID = amplify_core.QueryField(fieldName: "commentsUsernameId");
  static var schema = amplify_core.Model.defineSchema(define: (amplify_core.ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "Comments";
    modelSchemaDefinition.pluralName = "Comments";
    
    modelSchemaDefinition.authRules = [
      amplify_core.AuthRule(
        authStrategy: amplify_core.AuthStrategy.PUBLIC,
        operations: const [
          amplify_core.ModelOperation.CREATE,
          amplify_core.ModelOperation.UPDATE,
          amplify_core.ModelOperation.DELETE,
          amplify_core.ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Comments.USERNAME,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Comments.COMMENT,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Comments.USERIDENTITY,
      isRequired: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasMany(
      key: Comments.UID,
      isRequired: false,
      ofModelName: 'Users',
      associatedKey: Users.COMMENTSID
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.hasOne(
      key: Comments.USERNAME,
      isRequired: false,
      ofModelName: 'Users',
      associatedKey: Users.ID
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'createdAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(amplify_core.ModelFieldDefinition.field(
      key: Comments.COMMENTSUSERNAMEID,
      isRequired: false,
      ofType: amplify_core.ModelFieldType(amplify_core.ModelFieldTypeEnum.string)
    ));
  });
}

class _CommentsModelType extends amplify_core.ModelType<Comments> {
  const _CommentsModelType();
  
  @override
  Comments fromJson(Map<String, dynamic> jsonData) {
    return Comments.fromJson(jsonData);
  }
  
  @override
  String modelName() {
    return 'Comments';
  }
}

/**
 * This is an auto generated class representing the model identifier
 * of [Comments] in your schema.
 */
class CommentsModelIdentifier implements amplify_core.ModelIdentifier<Comments> {
  final String id;

  /** Create an instance of CommentsModelIdentifier using [id] the primary key. */
  const CommentsModelIdentifier({
    required this.id});
  
  @override
  Map<String, dynamic> serializeAsMap() => (<String, dynamic>{
    'id': id
  });
  
  @override
  List<Map<String, dynamic>> serializeAsList() => serializeAsMap()
    .entries
    .map((entry) => (<String, dynamic>{ entry.key: entry.value }))
    .toList();
  
  @override
  String serializeAsString() => serializeAsMap().values.join('#');
  
  @override
  String toString() => 'CommentsModelIdentifier(id: $id)';
  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    
    return other is CommentsModelIdentifier &&
      id == other.id;
  }
  
  @override
  int get hashCode =>
    id.hashCode;
}