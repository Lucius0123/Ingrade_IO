import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ingrade_io/Widgets/Course_Tile.dart';
import 'package:ingrade_io/screens/Home%20Screen/product_card.dart';
import 'package:ingrade_io/screens/Home%20Screen/section_header.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../Controller/Auth Controller.dart';
import '../../Controller/Mock_data_controller.dart';
import '../../Utils/SizeConfig.dart';
import '../../appcolors/appcolors.dart';
import '../../customappbar/bottomnavigationbar.dart';
import '../../customappbar/customappbar.dart';
import '../course_screen.dart';
import 'banner_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentIndex = 0;
  final AuthController authController = Get.find<AuthController>();
  final CourseController courseController = Get.find<CourseController>();
  int currentBannerIndex = 0;

  void onTabTapped(int index) {
    if (index == 1) {
      // Navigate to Courses screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Courses_Screen()),
      );
    } else {
      // You can manage other tabs similarly or stay on current screen
      setState(() {
        currentIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomCourseAppBar(
      ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 16),
              _buildBannerSlider(),
              const SizedBox(height: 16),
              _buildFeaturedProducts(),
              const SizedBox(height: 16),
              _buildCouseTile(),
              _buildCouseTile()
            ]
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(currentIndex: currentIndex, onTap: onTabTapped),
    );
  }
  Widget _buildBannerSlider() {
    return Column(
      children: [
    CarouselSlider.builder(
    itemCount: courseController.banners.length,
      options: CarouselOptions(
        height: SizeConfig.screenHeight * 0.25,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 4),
        enlargeCenterPage: true,
        viewportFraction: 0.9,
        onPageChanged: (index, reason) {
          setState(() {
            currentBannerIndex = index;
          });
        },
      ),
      itemBuilder: (context, index, realIndex) {
        final banner = courseController.banners[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(20), // <-- makes rounded corners
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.secondary.withOpacity(0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Image.asset(
              banner.image,
              fit: BoxFit.cover, // fills and crops without stretching
              width: double.infinity,
            ),
          ),
        );
      },
    ),
    const SizedBox(height: 12),
        AnimatedSmoothIndicator(
          activeIndex: currentBannerIndex,
          count: courseController.banners.length,
          effect: WormEffect(
            dotColor: Colors.grey.shade300,
            activeDotColor: AppColors.primary,
            dotHeight: 8,
            dotWidth: 8,
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedProducts() {
    return Column(
      children: [
        SectionHeader(
          title: 'Trending Courses',
          onViewAll: () {},
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 220.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: courseController.bestsellerProducts.length,
            itemBuilder: (context, index) {
              final product = courseController.bestsellerProducts[index];
              return Container(
                width: 190.h,
                margin: const EdgeInsets.only(right: 12),
                child: CourseCard(product: product),
              );
            },
          ),
        ),
      ],
    );
  }
Widget _buildCouseTile() {
  final product = courseController.bestsellerProducts[1];
    return Column(
      children: [
        SectionHeader(
          title: 'Free Courses',
          onViewAll: () {},),
        const SizedBox(height: 12),
        SizedBox(
          child: CourseTile( product: product,),// slightly increased to avoid overflow
        )
        ],);
}

}
