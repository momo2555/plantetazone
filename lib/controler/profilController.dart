import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plantetazone/controler/userConnection.dart';
import 'package:plantetazone/models/userModel.dart';
import 'package:plantetazone/models/userProfileModel.dart';


class ProfileController {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  UserConnection userConnection = UserConnection();
  FirebaseStorage fireStorage = FirebaseStorage.instance;

  Future<UserProfileModel> get getUserProfile async {

    UserModel user = await userConnection.UserConnected;
    UserProfileModel userProfile = UserProfileModel.byModel(user);
    //get the user reference 
    DocumentReference profileDataRef =
        fireStore.collection('users').doc(userProfile.getUid);
    //get user data
    DocumentSnapshot profileData = (await profileDataRef.get());
    userProfile.setUserName = profileData.get('userName');
    userProfile.setUserDescription = profileData.get('userDescription');
    userProfile.setUserRate = profileData.get('userRate');
    userProfile.setUserProfileImage = profileData.get('userProfileImage');
    //get the link of the profile image
    
    Reference imgRef = fireStorage.ref('userImages/'+userProfile.getUserProfileImage);
    userProfile.setUserProfileImageURL = await imgRef.getDownloadURL();
    
    return userProfile;
  }

  Future<UserProfileModel> getUserProfileById(String userId) async {
    //get the user Id
    UserModel user = UserModel('', '', userId);
    
    UserProfileModel userProfile = UserProfileModel.byModel(user);
    //get the user reference 
    DocumentReference profileDataRef =
        fireStore.collection('users').doc(userProfile.getUid);
    //get user data
    DocumentSnapshot profileData = (await profileDataRef.get());
    userProfile.setUserName = profileData.get('userName');
    userProfile.setUserDescription = profileData.get('userDescription');
    userProfile.setUserRate = profileData.get('userRate');
    userProfile.setUserProfileImage = profileData.get('userProfileImage');
    //get the link of the profile image
    
    Reference imgRef = fireStorage.ref('userImages/'+userProfile.getUserProfileImage);
    userProfile.setUserProfileImageURL = await imgRef.getDownloadURL();
    
    return userProfile;
  }

  Future<UserProfileModel> createProfile(UserModel user) async {
     UserProfileModel userProfile = UserProfileModel.byModel(user);
     //create the new doc
     DocumentReference profileDataRef =
        fireStore.collection('users').doc(user.getUid);
      profileDataRef.set(userProfile.toObject());
      return userProfile;
  }

  Future<void> saveUserProfile(UserProfileModel userProfile) async {
    //upload image
    if(userProfile.getUserProfileImageFile!=null) {
      Reference uploadRef = fireStorage.ref('userImages/' + userProfile.getUid); //in a unique folder
        uploadRef.putFile(userProfile.getUserProfileImageFile);
      userProfile.setUserProfileImageURL = userProfile.getUid;
    }
    //enregistrement dans la data base
    DocumentReference profileDataRef =
        fireStore.collection('users').doc(userProfile.getUid);
      profileDataRef.set(userProfile.toObject());
  }
}