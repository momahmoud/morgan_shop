import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:morgan_shop/model/facebook_model.dart';
import 'package:morgan_shop/routes/routes.dart';
import 'package:morgan_shop/utils/themes.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FacebookAuth facebookAuth = FacebookAuth.instance;
  bool isVisible = false;
  bool isChecked = false;
  bool isLoading = false;
  bool isLogin = false;
  var currentUserName = ''.obs;
  var email = ''.obs;
  var userPhoto = ''.obs;

  User? get userData => _auth.currentUser;

  @override
  void onInit() {
    currentUserName.value = (userData != null ? userData!.displayName : "")!;
    email.value = (userData != null ? userData!.email : "")!;
    userPhoto.value = (userData != null ? userData!.photoURL : "")!;
    super.onInit();
  }

  void toggleVisibility() {
    isVisible = !isVisible;
    update();
  }

  void toggleChecked() {
    isChecked = !isChecked;
    update();
  }

  Future<void> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      isLoading = true;
      await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((_) {
        currentUserName.value = name;
        _auth.currentUser!.updateDisplayName(name);
        showSnackBarMessage('', 'Registered Successfully');
        isLoading = false;
        Get.offNamed(Routes.mainScreen);
      });
    } on FirebaseAuthException catch (e) {
      isLoading = false;
      if (e.code == 'weak-password') {
        showSnackBarMessage('', 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showSnackBarMessage('', 'The account already exists for that email.');
      } else {
        showSnackBarMessage('', "${e.message}");
      }
    } catch (error) {
      isLoading = false;
      showSnackBarMessage('', '$error');
    }
    update();
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      isLoading = true;
      await _auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((_) {
        currentUserName.value = _auth.currentUser!.displayName!;
        showSnackBarMessage('', 'login Successfully');
        isLoading = false;
        Get.offNamed(Routes.mainScreen);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBarMessage('', 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnackBarMessage('', 'Wrong password provided for that user.');
      } else {
        showSnackBarMessage('', "${e.message}");
      }
    } catch (error) {
      isLoading = false;
      showSnackBarMessage('', '$error');
    }
    update();
  }

  Future<void> resetPassword({
    required String email,
  }) async {
    try {
      isLoading = true;
      await _auth
          .sendPasswordResetEmail(
        email: email,
      )
          .then((_) {
        isLoading = false;
        Get.back();
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBarMessage('', 'No user found for that email.');
      } else {
        showSnackBarMessage('', "${e.message}");
      }
    } catch (error) {
      isLoading = false;
      showSnackBarMessage('', '$error');
    }
    update();
  }

  Future<void> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser!.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      // Once signed in, return the UserCredential
      await _auth.signInWithCredential(credential).then((value) {
        currentUserName.value = googleUser.displayName!;
        userPhoto.value = googleUser.photoUrl!;
        email.value = googleUser.email;
        showSnackBarMessage('', 'login Successfully');
        Get.offNamed(Routes.mainScreen);
      });
      update();
    } catch (error) {
      showSnackBarMessage('', '$error');
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await facebookAuth.login();

      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      await _auth.signInWithCredential(facebookAuthCredential).then((_) async {
        final userData = await facebookAuth.getUserData();
        FacebookModel facebookModel = FacebookModel.fromJson(userData);
        currentUserName.value = facebookModel.name!;
        userPhoto.value = facebookModel.facebookPhotoModel!.url!;
        email.value = facebookModel.email!;

        showSnackBarMessage('', 'login Successfully');
      });
      update();
      update();
    } catch (error) {
      showSnackBarMessage('', 'login error, try again');
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut().then((_) {
        currentUserName.value = '';
        userPhoto.value = '';
        showSnackBarMessage('', 'logOut Successfully');
        Get.offNamed(Routes.welcomeScreen);
      });
      update();
    } catch (error) {
      showSnackBarMessage('', '$error');
    }
  }

  authStateChanges() {
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        isLogin = true;
      } else {
        isLogin = false;
      }
      update();
    });
  }

  SnackbarController showSnackBarMessage(
    String title,
    String message,
  ) {
    return Get.snackbar(
      message,
      title,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Get.isDarkMode ? mainColor : pinkClr,
      colorText: Get.isDarkMode ? Colors.black : Colors.white,
      duration: const Duration(seconds: 2),
      padding: const EdgeInsets.only(left: 8, right: 8, top: 10),
    );
  }
}
