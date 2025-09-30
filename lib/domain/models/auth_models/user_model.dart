import 'package:hive_flutter/hive_flutter.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String token;

  @HiveField(1)
  bool isLogin;

  @HiveField(2)
  DateTime lastLoginTime;

  UserModel(this.token, this.isLogin, this.lastLoginTime);

  UserModel copywith({String? token, bool? isLogin, DateTime? lastLoginTime}) {
    return UserModel(
      token ?? this.token,
      isLogin ?? this.isLogin,
      lastLoginTime ?? this.lastLoginTime,
    );
  }

  bool isLoggedIn() => isLogin;
}
