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
    'assets/images/banners/banner_image1.jpg',
    'assets/images/banners/banner_image1.jpg',
    'assets/images/banners/banner_image1.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 14, bottom: 5),
          child: Text(
            'About Us',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 4,
          ),
        ),
        CarouselSlider.builder(
          itemCount: _bannerImages.length,
          itemBuilder: (context, index, realIndex) {
            return TRoundedImage(
              imagePath: _bannerImages[index],
              description: 'Get the most accurate medical information',
              title: 'Levaraging AI',
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
          color: index == _currentPage ? TColors.primaryColor : Colors.grey,
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
            decoration: BoxDecoration(
              color: Colors.blue[200],
              borderRadius: BorderRadius.circular(10),
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
                style: const TextStyle(
                  color: Colors.black,
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
              // color: Colors.green,
              width: TDeviceUtils.getScreenWidth(context) * 0.7,
              padding: const EdgeInsets.all(8),
              child: Text(
                description,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
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
