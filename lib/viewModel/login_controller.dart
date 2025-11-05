import 'package:get/get.dart';

import 'package:github_restapi/data/response/status.dart';
import 'package:github_restapi/domain/repository/github_repository.dart';
import 'package:github_restapi/model/userModel/user_model.dart';
import 'package:github_restapi/resources/utils/utils.dart';

class LoginController extends GetxController {
  final userRepo = GithubRepository();
  final rxRequesStatus = Status.LOADING.obs;
  final user = UserModel().obs;
  final error = ''.obs;

  void setRxReqestStatus(Status value) =>
      rxRequesStatus.value = value;
  void setError(String value) => error.value = value;
  void setUser(UserModel value) => user.value = value;

  void getUser(String username) {
    setRxReqestStatus(Status.LOADING);
    userRepo
        .getUser(username)
        .then((value) {
          setUser(value);
          setRxReqestStatus(Status.CONNECTED);
          Utils.toastMessage('Login Successfull');
          print(value.following);
        })
        .onError((error, _) {
          setError(error.toString());
          setRxReqestStatus(Status.FAILED);
          Utils.errorSnack('Error', 'User not Found');
        });
  }
}
