import 'package:json_annotation/json_annotation.dart'; 
  
part 'DuzheLunModel.g.dart';


@JsonSerializable()
  class DuzheLunModel extends Object {

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'datas')
  List<Datas> datas;

  @JsonKey(name: 'msg')
  String msg;

  @JsonKey(name: 'code')
  int code;

  DuzheLunModel(this.status,this.datas,this.msg,this.code,);

  factory DuzheLunModel.fromJson(Map<String, dynamic> srcJson) => _$DuzheLunModelFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DuzheLunModelToJson(this);

}

  
@JsonSerializable()
  class Datas extends Object {

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'pid')
  String pid;

  @JsonKey(name: 'uid')
  String uid;

  @JsonKey(name: 'post_id')
  String postId;

  @JsonKey(name: 'content')
  String content;

  @JsonKey(name: 'create_time')
  String createTime;

  @JsonKey(name: 'update_time')
  String updateTime;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'ip')
  String ip;

  @JsonKey(name: 'good')
  String good;

  @JsonKey(name: 'model')
  String model;

  @JsonKey(name: 'to_author_name')
  String toAuthorName;

  @JsonKey(name: 'report')
  String report;

  @JsonKey(name: 'ignore')
  String ignore;

  @JsonKey(name: 'under_id')
  String underId;

  @JsonKey(name: 'card_id')
  String cardId;

  @JsonKey(name: 'hot')
  String hot;

  @JsonKey(name: 'nickname')
  String nickname;

  @JsonKey(name: 'avatar')
  String avatar;

  @JsonKey(name: 'title')
  String title;

  Datas(this.id,this.pid,this.uid,this.postId,this.content,this.createTime,this.updateTime,this.status,this.ip,this.good,this.model,this.toAuthorName,this.report,this.ignore,this.underId,this.cardId,this.hot,this.nickname,this.avatar,this.title,);

  factory Datas.fromJson(Map<String, dynamic> srcJson) => _$DatasFromJson(srcJson);

  Map<String, dynamic> toJson() => _$DatasToJson(this);

}

  
