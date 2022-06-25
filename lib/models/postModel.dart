import 'dart:core';
import 'dart:io';

import 'package:flutter/material.dart';

class PostModel {
  String? postId;
  String? postTitle;
  String? postDescription;
  String? postCategory;
  double? postPrice;
  double? postWeight;
  double? postShippingFees;
  List<File>? postImageFiles;
  List<String?>? postTempImagePaths;
  late List<dynamic> postStorageImageNames;
  //user which create the post
  String? postUserId;
  int? postLikesNum;
  //bool? postCurrentUserLike;
  
  PostModel() : super();

  static final List<String> postCategories = ["Plantes d'intérieur","plante à variégations","jeunes arbres",  "Plantes d'extérieur", "Graines", "Plantes rares", 
                                   "Cactée et succulantes", "Plantes fleuries", "plantes XXL"];
  static get getCategories {
    return postCategories;
  }
  ///
  ///get all post categories
  static List<DropdownMenuItem<String>> get getPostCategories{
    List<DropdownMenuItem<String>> menuItems = [];
      for (String category in postCategories) {
        menuItems.add(DropdownMenuItem(child: Text(category),value: category));
      }
    return menuItems;
  }

  //setters
  set setPostId(value) {
    postId = value;
  }
  set setPostTitle(value) {
    postTitle = value;
  }
  set setPostDescription(value) {
    postDescription = value;
  }
  set setPostCategory(value) {
    postCategory = value;
  }
  set setPostPrice(value) {
    postPrice = value;
  }
  set setPostWeight(value) {
    postWeight = value;
  }
  set setPostShippingFees(value) {
    postShippingFees = value;
  }
  set setPostUserId(value) {
    postUserId= value;
  }
  set setPostLikesNum(value) {
    postLikesNum = value;
  }
  set setImageFiles(value) {
    postImageFiles = value;
  }
  set setPostTempImagePaths(value) {
    postTempImagePaths = value;
  }
  set setPostStorageImageNames(value) {
    postStorageImageNames = value;
  }



  get getPostId{
    return postId;
  }
  get getPostTitle {
    return postTitle ;
  }
  String? get getPostDescription{
    return postDescription;
  }
  get getPostCategory{
    return postCategory;
  }
  get getPostPrice{
    return postPrice;
  }
  get getPostWeight {
    return postWeight;
  }
  get getPostShippingFees {
    return postShippingFees;
  }
  get getPostUserId{
    return postUserId;
  }
  get getPostLikesNum {
    return postLikesNum;
  }
  List<File>? get  getImageFiles {
    return postImageFiles;
  }
  get getPostTempImagePaths {
      return postTempImagePaths;
  }
  get getPostStorageImageNames {
        return postStorageImageNames;
  }



  dynamic toObject() {
    return {
      'postTitle' : postTitle,
      'postDescription' : postDescription,
      'postCategory' : postCategory,
      'postPrice' : postPrice,
      'postWeight' : postWeight,
      'postShippingFees' : postShippingFees ?? 0, //TODO calculate the fees with the weight of the post
      'postUserId' : postUserId,
      'postLikesNum' : postLikesNum ?? 0,
      //'postCurrentUserLike' : postCurrentUserLike ?? false,
      'postStorageImageNames' : postStorageImageNames,
    };

  }
}