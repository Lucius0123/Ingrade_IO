import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Model/banner.dart';
import '../Model/product.dart';

class CourseController extends GetxController {
  var banners = <BannerModel>[].obs;
  var products = <Product>[].obs;
  var featuredProducts = <Product>[].obs;
  var bestsellerProducts = <Product>[].obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    loadMockData();
  }

  void loadMockData(){

    // Mock banners
    banners.value = [
      BannerModel(
        id: '1',
        title: 'Big Billion Days',
        subtitle: 'Up to 80% OFF',
        image: 'assets/mock_images/1.jpg',
        actionText: 'Shop Now',
        backgroundColor: const Color(0xFF1976D2),
        textColor: Colors.white,
      ),
      BannerModel(
        id: '2',
        title: 'Fashion Sale',
        subtitle: 'Trending Styles',
        image: 'assets/mock_images/2.jpg',
        actionText: 'Explore',
        backgroundColor: const Color(0xFFE91E63),
        textColor: Colors.white,
      ),
      BannerModel(
        id: '3',
        title: 'Electronics Deal',
        subtitle: 'Latest Gadgets',
        image: 'assets/mock_images/3.jpg',
        actionText: 'Buy Now',
        backgroundColor: const Color(0xFF9C27B0),
        textColor: Colors.white,
      ),
      BannerModel(
        id: '4',
        title: 'Electronics Deal',
        subtitle: 'Latest Gadgets',
        image: 'assets/mock_images/4.jpg',
        actionText: 'Buy Now',
        backgroundColor: const Color(0xFF9C27B0),
        textColor: Colors.white,
      ),
      BannerModel(
        id: '5',
        title: 'Electronics Deal',
        subtitle: 'Latest Gadgets',
        image: 'assets/mock_images/5.jpg',
        actionText: 'Buy Now',
        backgroundColor: const Color(0xFF9C27B0),
        textColor: Colors.white,
      ),
    ];

    products.value = [
      // Electronics
      Product(
        id: '1',
        name: 'Learn C++ from Beginner',
        image: 'assets/mock_images/1.jpg',
        price: 1199.99,
        category: 'Electronics',
        subCategory: 'Smartphones',
        rating: 4.8,
        reviewCount: 2847,
        description: 'Latest iPhone with A17 Pro chip and titanium design',
        features: ['A17 Pro Chip', '48MP Camera', '5G Ready', 'Face ID'],
        isBestseller: true,
      ),
      Product(
        id: '2',
        name: 'Learn DSA in C++',
        image: 'assets/mock_images/2.jpg',
        price: 999.99,
        category: 'Electronics',
        subCategory: 'Laptops',
        rating: 4.7,
        reviewCount: 1523,
        description: 'Supercharged by M2 chip for incredible performance',
        features: ['M2 Chip', '13.6" Display', '18hr Battery', 'Touch ID'],
        isNewArrival: true,

      ),

      // Fashion
      Product(
        id: '3',
        name: 'Learn ML with Python',
        image:'assets/mock_images/3.jpg',

        price: 29.99,
        category: 'Fashion',
        subCategory: 'Men\'s Clothing',
        rating: 4.5,
        reviewCount: 892,
        description: 'Comfortable premium cotton t-shirt for everyday wear',
        features: ['100% Cotton', 'Machine Washable', 'Regular Fit', 'Breathable'],
      ),
      Product(
        id: '4',
        name: 'Learn Data Handling with Excel and also dealing with data',

        image: 'assets/mock_images/5.jpg',

        price: 199.99,
        category: 'Fashion',
        subCategory: 'Women\'s Accessories',
        rating: 4.6,
        reviewCount: 456,
        description: 'Elegant designer handbag perfect for any occasion',
        features: ['Genuine Leather', 'Multiple Compartments', 'Adjustable Strap', 'Designer Brand'],
        isBestseller: true,

      ),

      // Home & Living
      Product(
        id: '5',
        name: 'Learn Data Analysis with python',
        image: 'assets/mock_images/5.jpg',
        price: 699.99,
        category: 'Home & Living',
        subCategory: 'Electronics',
        rating: 4.4,
        reviewCount: 1234,
        description: '4K Ultra HD Smart TV with HDR and built-in streaming',
        features: ['4K Ultra HD', 'Smart TV', 'HDR Support', 'Voice Control'],
      ),

      // Beauty
      Product(
        id: '6',
        name: '',
        image: 'assets/mock_images/6.jpg',
        price: 89.99,
        category: 'Beauty',
        subCategory: 'Skincare',
        rating: 4.7,
        reviewCount: 678,
        description: 'Complete skincare routine with premium ingredients',
        features: ['Anti-Aging', 'Hydrating', 'Dermatologist Tested', 'Natural Ingredients'],
        isNewArrival: true,
      ),

      // Sports
      Product(
        id: '7',
        name: 'Running Shoes',
        image: 'assets/mock_images/7.jpg',
        price: 129.99,
        category: 'Sports',
        subCategory: 'Footwear',
        rating: 4.6,
        reviewCount: 1567,
        description: 'Professional running shoes with advanced cushioning',
        features: ['Boost Technology', 'Breathable Mesh', 'Lightweight', 'Durable Sole'],
        isBestseller: true,
      ),

      // Books
      Product(
        id: '8',
        name: 'Bestselling Novel Collection',
        image: 'assets/mock_images/8.jpg',
        price: 24.99,
        category: 'Books',
        subCategory: 'Fiction',
        rating: 4.8,
        reviewCount: 234,
        description: 'Collection of award-winning novels from top authors',
        features: ['Hardcover', 'Award Winners', 'Classic Literature', 'Gift Edition'],
      ),
    ];
    bestsellerProducts.value = products.where((p) => p.isBestseller).toList();
    isLoading.value = false;
  }
}