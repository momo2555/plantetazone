import 'dart:developer';
import 'dart:io';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:plantetazone/components/postTile.dart';
import 'package:plantetazone/controler/cacheStorageController.dart';
import 'package:plantetazone/controler/userConnection.dart';
import 'package:plantetazone/models/postModel.dart';
import 'package:plantetazone/models/userModel.dart';
import 'package:path_provider/path_provider.dart';

class PostController {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  UserConnection userConnection = UserConnection();
  FirebaseStorage fireStorage = FirebaseStorage.instance;

  /*Future<UserProfileModel> get getUserProfile async {

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
  }*/
  void publishPost(PostModel newPost) async {
    UserModel user = await userConnection.UserConnected;
    newPost.setPostUserId = user.getUid;
    //create a new document for the new post (auto generated uid)
    DocumentReference ref = fireStore.collection('posts').doc();
    //uid of the post
    String uid = ref.id;
    //upload photos in the firestorage
    
    int i = 0;
    List<String?> storageImageNames = [];
    for (String img in newPost.getPostTempImagePaths) {
      File imgFile = File(img);
      String newPath = uid + '_'+i.toString();
      storageImageNames.add(newPath);
      Reference uploadRef = fireStorage.ref('postImages/' + uid + '/' + newPath); //in a unique folder
      uploadRef.putFile(imgFile);
      i++;
    }
    //add images storages names
    newPost.setPostStorageImageNames = storageImageNames;
    
    //add the new post in the doc
    ref.set(newPost.toObject());
  }



  Future<PostModel> getPostById(String uid) async {
    PostModel post = PostModel();
    DocumentReference postRef =
        fireStore.collection('posts').doc(uid);
    //get user data
    DocumentSnapshot postSnapshot = (await postRef.get());
    post = docToPostModel(postSnapshot);
    //yield post;
    post = await getImages(post);
    return post;

  }

  PostModel docToPostModel(DocumentSnapshot doc) {
    PostModel post = PostModel();
    post.setPostCategory = doc.get('postCategory');
    //post.setPostCurrentUserLike = postSnapshot.get('postCurrentUserLike');
    post.setPostDescription = doc.get('postDescription');
    post.setPostId = doc.id;
    post.setPostLikesNum = doc.get('postLikesNum');
    post.setPostPrice = doc.get('postPrice');
    post.setPostShippingFees = doc.get('postShippingFees');
    //post.setPostStorageImageNames = postSnapshot.get('postStorageImageNames') as List<String?>?;
    post.setPostTitle = doc.get('postTitle');
    post.setPostUserId = doc.get('postUserId');
    post.setPostWeight = doc.get('postWeight');
    post.setPostStorageImageNames =  doc.get('postStorageImageNames');
    return post;
  }

  Future<PostModel> getImages(PostModel post) async {
    try {
       List<File> imageFiles = [];
    //download images
    //get temp folder
    List<dynamic> imagesStoragePaths = post.getPostStorageImageNames;
    print(post.getPostStorageImageNames);
    for(var img in imagesStoragePaths) {
      CacheStorageController cloudDownloader = CacheStorageController();
      File fileImg = await cloudDownloader.downloadFromCloud('postImages/' + post.getPostId + '/', (img as String), LocalSaveMode.userDocuments);
      imageFiles.add(fileImg);
      post.setImageFiles = imageFiles;
    }
      
    return post;
    } catch (e) {
      return post;
    }
   
  }

  Stream<List<Future<PostModel>>> converDocs(QueryDocumentSnapshot<Map<String, dynamic>> snapshots) async* {
    List<PostModel> posts = [];
    
  } 
  Stream<List<PostTile>> getAllposts()  {
    return fireStore.collection('posts').limit(20).snapshots().map((event) => event.docs.map((e) => PostTile(post: docToPostModel(e))).toList() );
    
  }

  
}