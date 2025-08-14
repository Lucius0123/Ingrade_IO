import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ingrade_io/Model/product.dart';
import 'package:ingrade_io/Utils/customText.dart';
import 'package:ingrade_io/appcolors/appcolors.dart';

class CourseCard extends StatelessWidget {
  final Product product;
  const CourseCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Column(
        mainAxisSize: MainAxisSize.min, // ✅ Prevents forced expansion
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              product.image,
              height: 120, // ✅ Adjusted height
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text:product.name,fontSize: 14.sp,fontWeight: FontWeight.bold,color: AppColors.secondary,maxLines: 1,overflow:TextOverflow.ellipsis , ),
                const SizedBox(height: 4),
                // Description
                CustomText(text:product.description,fontSize: 11.sp,fontWeight: FontWeight.normal,color: AppColors.secondary,maxLines: 2,overflow:TextOverflow.ellipsis , ),

                const SizedBox(height: 6),
                // Rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CustomText(text: product.rating.toString(),fontSize: 12.sp,fontWeight: FontWeight.bold,),
                        const SizedBox(width: 4),
                        Icon(Icons.star, size: 14, color: Colors.amber),
                        const SizedBox(width: 4),

                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.person, size: 14, color: AppColors.secondary),
                        const SizedBox(width: 4),
                        Text(
                          "(${product.reviewCount})",
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 6),
                // Price + Bestseller
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(text:product.price.toString(),fontSize: 14.sp,fontWeight: FontWeight.bold,color: AppColors.secondary, ),
                    if (product.isBestseller)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          "Bestseller",
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
