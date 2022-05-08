import 'package:MotivationApps/models/category_model.dart';

class NotificationModel {
  final String id;
  final String userId;
  final String categoryId;
  final DateTime timeSend;
  final CategoryModel category;
  final String text;
  NotificationModel(
      {required this.id,
      required this.text,
      required this.category,
      required this.userId,
      required this.categoryId,
      required this.timeSend});
}
