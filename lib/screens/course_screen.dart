import 'package:flutter/material.dart';
import '../appcolors/appcolors.dart';
import '../customappbar/bottomnavigationbar.dart';
import '../customappbar/customsearchappbar.dart';
import '../customappbar/themecontroler.dart';


class Courses_Screen extends StatefulWidget {
  const Courses_Screen({super.key});

  @override
  State<Courses_Screen> createState() => _Courses_ScreenState();
}

class _Courses_ScreenState extends State<Courses_Screen> {
  // int selectedIndex = 2;
  //
  // void onTabTapped(int index) {
  //   setState(() {
  //     selectedIndex = index;
  //   });
  // }
  //
  // final List<Widget> screens = [
  //   Center(child: Text("Home Screen")),
  //   Center(child: Text("Courses Screen")),
  //   Center(child: Text("Explore Screen")),
  //   Center(child: Text("Profile Screen")),
  // ];


  int currentIndex = 1;

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
        currentIndex = 1;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent, // transparent so gradient shows
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Icon(Icons.shopping_cart_rounded , color: Colors.white),
          )
        ],
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: RichText(
            text: TextSpan(
              text: "in",
              style: TextStyle(
                color: AppColors.secondary,
                fontSize: 30,
                fontWeight: FontWeight.w900,
              ),
              children: [
                TextSpan(
                  text: "Grade",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                )
              ],
            ),
          ),
        ),

        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: ThemeController.isDarkMode
                ? const LinearGradient(
              colors: [Colors.black, Color(0xFF1C1C1C)], // dark mode
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
                :  LinearGradient(
              colors: [AppColors.primary.withOpacity(0.5),AppColors.secondary.withOpacity(0.9)], // light mode
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),

      ),


      body: Column(
        children: [
          PremiumSearchBar(
            onChanged: (value) {
              print("Search: $value");
            },
          ),
          // Your content here
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: currentIndex, onTap: onTabTapped),
    );

  }
}
