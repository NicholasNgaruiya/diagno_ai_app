import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:restaurant_frontend/utils/device/device_utility.dart';

import '../../utils/constants/colors.dart';

class HorizontalScrollableList extends StatefulWidget {
  const HorizontalScrollableList({Key? key}) : super(key: key);

  @override
  _HorizontalScrollableListState createState() => _HorizontalScrollableListState();
}

class _HorizontalScrollableListState extends State<HorizontalScrollableList> {
  int _currentPage = 0;

  final List<String> _bannerImages = [
    'assets/images/banners/symptoms_image.png',
    // 'assets/images/banners/diagnosis_image2.png',
    // 'assets/images/banners/bot_ai.avif',
    'assets/images/banners/robot_image.avif',

    'assets/images/banners/diagnosis_image1.avif',
    // 'assets/images/banners/ai_image.png',
  ];
  final List<String> _featureTitles = [
    'Symptom Entry',
    'Accurate Diagnosis',
    'Personalized Treatment',
  ];

  final List<String> _featureDescriptions = [
    'Easily enter symptoms and receive tailored recommendations quickly and efficiently using our intuitive interface.',
    'Get accurate diagnosis by entering symptoms. Our AI-powered system ensures precise results.',
    'Receive personalized treatment recommendations based on diagnosis, powered by advanced AI algorithms.',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 14, bottom: 5),
          child: Text(
            'What we do',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 4,
          ),
        ),
        CarouselSlider.builder(
          itemCount: _bannerImages.length,
          itemBuilder: (context, index, realIndex) {
            return TRoundedImage(
              imagePath: _bannerImages[index],
              description: _featureDescriptions[index],
              title: _featureTitles[index],
            );
          },
          options: CarouselOptions(
            viewportFraction: 0.8,
            height: 200,
            enableInfiniteScroll: true,
            enlargeCenterPage: true,
            enlargeFactor: 0.2,
            autoPlay: true,
            autoPlayCurve: Curves.decelerate,
            autoPlayAnimationDuration: const Duration(seconds: 1),
            autoPlayInterval: const Duration(seconds: 6),
            onPageChanged: (index, reason) {
              setState(() {
                _currentPage = index;
              });
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildIndicatorCircles(_bannerImages.length),
        ),
      ],
    );
  }

  List<Widget> _buildIndicatorCircles(int count) {
    return List.generate(
      count,
      (index) => AnimatedContainer(
        curve: Curves.linear,
        duration: const Duration(milliseconds: 400),
        margin: const EdgeInsets.only(right: 5),
        height: 5,
        width: index == _currentPage ? 25 : 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: index == _currentPage ? TColors.primaryColor.withOpacity(0.6) : Colors.grey,
        ),
      ),
    );
  }
}

class TRoundedImage extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final VoidCallback? onPressed;

  const TRoundedImage({
    Key? key,
    required this.imagePath,
    required this.description,
    this.onPressed,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        children: [
          Container(
            width: TDeviceUtils.getScreenWidth(context) * 0.8,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blue.withOpacity(0.1)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 10,
            child: Container(
              // color: Colors.green,
              width: TDeviceUtils.getScreenWidth(context) * 0.7,
              padding: const EdgeInsets.all(8),
              child: Text(
                title,
                style: TextStyle(
                  color: TColors.primaryColor.withOpacity(0.7),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 4,
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 10,
            child: Container(
              decoration: BoxDecoration(
                color: TColors.primaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
              width: TDeviceUtils.getScreenWidth(context) * 0.7,
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.all(8),
              child: Text(
                description,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
