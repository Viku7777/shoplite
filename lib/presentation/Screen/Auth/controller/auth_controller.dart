// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shoplite/data/local_data_source/local_data_source.dart';
import 'package:shoplite/domain/models/auth_models/user_model.dart';
import 'package:shoplite/domain/repositories/auth_repo/auth_repo.dart';
import 'package:shoplite/presentation/Screen/Auth/view/login_view.dart';
import 'package:shoplite/presentation/Screen/Home/controller/fav_item_controller.dart';
import 'package:shoplite/presentation/Screen/Home/view/home_screen_view.dart';
import 'package:shoplite/utils/di_injections.dart';
import 'package:shoplite/utils/extensions/app_extensions.dart';
import 'package:shoplite/utils/toasts/app_toast.dart';

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});

Box<UserModel> get userBox => Hive.box<UserModel>(LocalDataSource.authBox);

Future<void> logoutFuncation(BuildContext context) async {
  userBox.clear();
  cartBox.clear();
  favItemBox.clear();
  context.removeUntilNextScreen(LoginView(box: userBox));
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier()
    : super(AuthState(UserModel("", false, DateTime.now()), false));

  Future<void> login({
    required BuildContext context,
    required String username,
    required String password,
    required Box<UserModel> box,
  }) async {
    if (username.isEmpty || password.isEmpty) {
      AppToast.simpleToast(
        context: context,
        message: "Please enter all the values",
      );
      return;
    }
    state = state.copyWith(loading: true);
    await sI<AuthRepo>()
        .login(username: username, password: password)
        .then((e) async {
          await box.clear();
          await box.add(UserModel(e, true, DateTime.now()));
          context.removeUntilNextScreen(HomeScreenView());
          state = state.copyWith(loading: false);
        })
        .catchError((e) {
          AppToast.simpleToast(context: context, message: e.toString());
          state = state.copyWith(loading: false);
        });
  }
}

class AuthState {
  UserModel userModel;
  bool isloading;
  AuthState(this.userModel, this.isloading);

  copyWith({UserModel? user, bool? loading}) {
    return AuthState(user ?? userModel, loading ?? isloading);
  }
}
