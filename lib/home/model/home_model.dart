import 'package:vexana/vexana.dart';

class ReqProfile extends INetworkModel<ReqProfile> {
  int? id;
  String? name;
  String? username;
  String? email;
  String? expiryTime;

  bool isExpiry() {
    if (expiryTime == null) return false;
    final _currentData = DateTime.parse(expiryTime!);
    return DateTime.now().isAfter(_currentData);
  }

  ReqProfile({this.id, this.name, this.username, this.email});

  @override
  ReqProfile fromJson(Map<String, dynamic> json) {
    return ReqProfile.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['expryTime'] = expiryTime;

    return data;
  }

  ReqProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    expiryTime = json['expryTime'];
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReqProfile &&
        other.id == id &&
        other.name == name &&
        other.username == username &&
        other.email == email;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ username.hashCode ^ email.hashCode ^ expiryTime.hashCode;
  }
}
