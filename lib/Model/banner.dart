import 'dart:ui';
class BannerModel {
  final String id;
  final String title;
  final String subtitle;
  final String image;
  final String actionText;
  final Color backgroundColor;
  final Color textColor;

  BannerModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.actionText,
    required this.backgroundColor,
    required this.textColor,
  });
}
