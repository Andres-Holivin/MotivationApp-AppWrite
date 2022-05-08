import 'dart:typed_data';

class UserSchedulerModel {
  final String id;
  final String userId;
  final String categoryTitle;
  final String categoryId;
  final String schedulerType;
  final bool status;
  final Uint8List categoryIcon;
  UserSchedulerModel({
    required this.id,
    required this.userId,
    required this.categoryTitle,
    required this.schedulerType,
    required this.categoryId,
    required this.status,
    required this.categoryIcon,
  });
}
