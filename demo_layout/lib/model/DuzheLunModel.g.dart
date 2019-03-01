// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DuzheLunModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DuzheLunModel _$DuzheLunModelFromJson(Map<String, dynamic> json) {
  return DuzheLunModel(
      json['status'] as String,
      (json['datas'] as List)
          ?.map((e) =>
              e == null ? null : Datas.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['msg'] as String,
      json['code'] as int);
}

Map<String, dynamic> _$DuzheLunModelToJson(DuzheLunModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'datas': instance.datas,
      'msg': instance.msg,
      'code': instance.code
    };

Datas _$DatasFromJson(Map<String, dynamic> json) {
  return Datas(
      json['id'] as String,
      json['pid'] as String,
      json['uid'] as String,
      json['post_id'] as String,
      json['content'] as String,
      json['create_time'] as String,
      json['update_time'] as String,
      json['status'] as String,
      json['ip'] as String,
      json['good'] as String,
      json['model'] as String,
      json['to_author_name'] as String,
      json['report'] as String,
      json['ignore'] as String,
      json['under_id'] as String,
      json['card_id'] as String,
      json['hot'] as String,
      json['nickname'] as String,
      json['avatar'] as String,
      json['title'] as String);
}

Map<String, dynamic> _$DatasToJson(Datas instance) => <String, dynamic>{
      'id': instance.id,
      'pid': instance.pid,
      'uid': instance.uid,
      'post_id': instance.postId,
      'content': instance.content,
      'create_time': instance.createTime,
      'update_time': instance.updateTime,
      'status': instance.status,
      'ip': instance.ip,
      'good': instance.good,
      'model': instance.model,
      'to_author_name': instance.toAuthorName,
      'report': instance.report,
      'ignore': instance.ignore,
      'under_id': instance.underId,
      'card_id': instance.cardId,
      'hot': instance.hot,
      'nickname': instance.nickname,
      'avatar': instance.avatar,
      'title': instance.title
    };
