import 'dart:typed_data';

class CategoryModel {
  final String categoryId;
  final Uint8List file;
  final String title;
  final String bucketId;
  final Uint8List icon;
  final List<dynamic> text;
  CategoryModel({
    required this.text,
    required this.categoryId,
    required this.file,
    required this.title,
    required this.bucketId,
    required this.icon,
  });
}
