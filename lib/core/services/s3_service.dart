import 'dart:io';

import 'package:path/path.dart';
import 'package:simple_s3/simple_s3.dart';
import 'package:uuid/uuid.dart';

class S3Service {
  final SimpleS3 _simpleS3 = SimpleS3();
  final bucketName = "gdsc-ksu-bucket";
  final poolID = "us-east-1:a1886d46-8df6-490c-8504-062e487fb313";
  final region = AWSRegions.usEast1;
  final uuid = const Uuid();
  Future<Map<String, String>> uploadFile(File file,
      {String? s3FolderPath}) async {
    final filename = uuid.v4() + basename(file.path);
    String result = await _simpleS3.uploadFile(file, bucketName, poolID, region,
        accessControl: S3AccessControl.unknown,
        s3FolderPath: s3FolderPath ?? "",
        fileName: filename);
    print(result);
    final url = s3FolderPath != null
        ? "https://$bucketName.s3.amazonaws.com/$s3FolderPath/$filename"
        : "https://$bucketName.s3.amazonaws.com/$filename";
    print(url);
    return {"url": url, "filePath": "$s3FolderPath/$filename"};
  }

  Future<bool> deleteFile(String filePath, {String? s3FolderPath}) async {
    bool result = await SimpleS3.delete(filePath, bucketName, poolID, region);
    print(result);
    return result;
  }
}
