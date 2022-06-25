import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:plantetazone/models/userModel.dart';

class UserProfileModel extends UserModel {
  String? userName;
  String? userFirstName;
  String? userLastName;
  String? userProfileImage;
  String? userProfileImageURL;
  double? userRate;
  String? userDescription;
  File? userProfileImageFile;
  UserProfileModel(email, password, uid) : super(email, password, uid);
  UserProfileModel.byModel(UserModel user)
      : super(user.getEmail, '', user.getUid);
  set setUserName(String? value) {
    userName = value;
  }
 
  set setUserFirstName(String? value) {
    userFirstName = value;
  }

  set setUserLastName(String? value) {
    userLastName = value;
  }

  set setUserProfileImage(String? value) {
    userProfileImage = value;
  }

  set setUserProfileImageURL(String? value) {
    userProfileImageURL = value;
  }

  set setUserRate(double? value) {
    userRate = value;
  }

  set setUserDescription(String? value) {
    userDescription = value;
  }
  set setUserProfileImageFile(value) {
    userProfileImageFile = value;
  }
  get getUserName {
    return userName;
  }

  get getUserFirstName {
    return userFirstName;
  }

  get getUserLastName {
    return userLastName;
  }

  get getUserProfileImage {
    return userProfileImage;
  }

  get getUserProfileImageURL {
    return userProfileImageURL;
  }

  get getUserRate {
    return userRate;
  }

  get getUserDescription {
    return userDescription;
  }
  get getUserProfileImageFile {
    return userProfileImageFile;
  }

  Map<String, dynamic> toObject() {
    return {
      'userDescription' : userDescription ?? '',
      'userName' : userName ?? '',
      'userProfileImage' : userProfileImageURL ?? '',
      'userRate' : userRate ?? 0.0
    };

  }
}
