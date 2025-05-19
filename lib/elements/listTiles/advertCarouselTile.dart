import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart' as slider;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class DashBoardAdvert extends StatefulWidget {
  const DashBoardAdvert({super.key, required this.imageList});

  final List<dynamic> imageList;

  @override
  State<DashBoardAdvert> createState() => _DashBoardAdvertState();
}

class _DashBoardAdvertState extends State<DashBoardAdvert> {
  int _currentView = 0;
  final slider.CarouselSliderController _carouselController = slider.CarouselSliderController();


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      width: double.infinity,
      child: Card(
        elevation: 0,
        child: CarouselSlider(
          options: CarouselOptions(
              padEnds: false,
              viewportFraction: 1,
              enlargeCenterPage: true,
              autoPlay: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentView = index;
                });
              },
              autoPlayInterval: const Duration(seconds: 8)),
          carouselController: _carouselController,
          items: widget.imageList
              .map((item) =>
              CachedNetworkImage(
                imageUrl: item,
                httpHeaders: const {
                  'Accept' : 'application/octet-stream'
                },
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(), // Show a loader while waiting
                ),
                errorWidget: (context, url, error){
                  debugPrint(error.toString());
                  //todo: you can also return a default image
                  return Image.asset('assets/images/adverts/ad_4.png');
                }, // Show an error icon if loading fails
                fit: BoxFit.fill,
                width: double.infinity,
              ),)
              .toList(),
        ),
      ),
    );
  }
}
