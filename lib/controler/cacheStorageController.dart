import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path_provider/path_provider.dart';



enum LocalSaveMode {
  cache,
  userDocuments
}
/**
 * This class allows to download files from the cloud and manage the cache
 * Avoid downloading the file if it's already in the cache. You can also choose if
 * you want to save data in the cache or in the user document folder
 */
class CacheStorageController {
  FirebaseStorage fireStorage = FirebaseStorage.instance;
  
  Future<File> downloadFromCloud(String folderPath, String fileName, LocalSaveMode mode) async {
    Reference downloadRef = fireStorage.ref(folderPath + fileName);
    //by default the directory is the cache
    Directory tempDir =await getTemporaryDirectory();
    if (mode == LocalSaveMode.userDocuments) {
      tempDir = await getApplicationDocumentsDirectory();
    }
    
    String tempPathFilePath = "${tempDir.path}/$folderPath$fileName"; 
    //check if the path exists
    if(!Directory("${tempDir.path}/$folderPath").existsSync()) {
      //create the directory
      Directory("${tempDir.path}/$folderPath").createSync(recursive: true);
    }
    File file = File(tempPathFilePath);
    //check if the file exists (if it exists do not download it again)
    if(file.existsSync()) {
      //return the existing file
      return file;
    }else{
      //download the file from the cloud
      final downloadTask = await downloadRef.writeToFile(file);
      if( downloadTask.state == TaskState.success) {
        print("succes file dowloaded");
        return file;
      }else {
        print("failed file dowloaded");
        throw Exception("Une erreur lors du téléchargement de l'image s'est produite ! ");
      }
    }
  }
}