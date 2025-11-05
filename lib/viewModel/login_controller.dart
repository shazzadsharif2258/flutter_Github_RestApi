import 'package:get/get.dart';
import 'package:github_restapi/data/app_exception.dart';

import 'package:github_restapi/data/response/status.dart';
import 'package:github_restapi/domain/repository/github_repository.dart';
import 'package:github_restapi/model/userModel/user_model.dart';
import 'package:github_restapi/resources/utils/utils.dart';
import 'package:github_restapi/routes/routes_names.dart';

class LoginController extends GetxController {
  final userRepo = GithubRepository();
  final rxRequesStatus = Status.LOADING.obs;
  final user = UserModel().obs;
  final error = ''.obs;
  RxBool loading = false.obs;

  void setRxReqestStatus(Status value) =>
      rxRequesStatus.value = value;
  void setError(String value) => error.value = value;
  void setUser(UserModel value) => user.value = value;

  void getUser(String username) {
    loading.value = true;
    setRxReqestStatus(Status.LOADING);
    userRepo
        .getUser(username)
        .then((value) {
          loading.value = false;
          setUser(value);
          setRxReqestStatus(Status.CONNECTED);
          Get.toNamed(
            RoutesNames.homeView,
            arguments: username,
          );
          Utils.toastMessage('Login Successfull');
        })
        .onError((error, _) {
          loading.value = false;
          if (error is UserNotFoundException) {
            _fail(
              'User not found. Please check the username.',
            );
          } else if (error is InternetException) {
            _fail(
              'No internet connection. Please check your connection.',
            );
          } else if (error is RequestTimeOut) {
            setError('Request timeout. Please try again.');
          } else {
            setError(
              'Something went wrong. Please try again.',
            );
          }
          setRxReqestStatus(Status.FAILED);
        });
  }

  void _fail(String message) {
    setError(message);
    setRxReqestStatus(Status.FAILED);
    Utils.errorSnack('Error', message);
  }
}
