import 'package:flutter/material.dart';

class PremiumSearchBar extends StatelessWidget {
  final Function()? onTap;
  final Function(String)? onChanged;

  const PremiumSearchBar({Key? key, this.onTap, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Container(
        decoration: BoxDecoration(
          color: isDark ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            if (!isDark)
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                offset: Offset(0, 6),
              ),
          ],
        ),
        child: TextField(
          onTap: onTap,
          onChanged: onChanged,
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration(
            hintText: "Search courses, topics, etc.",
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.mic, color: Colors.grey),
                  onPressed: () {
                    // Add voice search logic
                  },
                ),
                // IconButton(
                //   icon: Icon(Icons.filter_alt_outlined, color: Colors.grey),
                //   onPressed: () {
                //     // Add filter logic
                //   },
                // ),
              ],
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }
}
