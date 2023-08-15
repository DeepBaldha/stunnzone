import 'package:flutter/material.dart';
import 'package:stunnzone/galleries/accessories_gallery.dart';
import 'package:stunnzone/galleries/bags_gallery.dart';
import 'package:stunnzone/galleries/beauty_gallery.dart';
import 'package:stunnzone/galleries/electronics_gallery.dart';
import 'package:stunnzone/galleries/home_garden_gallery.dart';
import 'package:stunnzone/galleries/kids_gallery.dart';
import 'package:stunnzone/galleries/men_gallery.dart';
import 'package:stunnzone/galleries/shoes_gallery.dart';
import 'package:stunnzone/galleries/women_gallerry.dart';
import 'package:stunnzone/widgets/fake_search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          title: const FakeSearch(),
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.yellow,
            indicatorWeight: 6,
            tabs: [
              RepeatedTab(label: "Men"),
              RepeatedTab(label: "Women"),
              RepeatedTab(label: "Shoes"),
              RepeatedTab(label: "Bags"),
              RepeatedTab(label: "Electronics"),
              RepeatedTab(label: "Accessories"),
              RepeatedTab(label: "Home & Garden"),
              RepeatedTab(label: "Kids"),
              RepeatedTab(label: "Beauty"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            MenGalleryScreen(),
            WomenGalleryScreen(),
            ShoesGalleryScreen(),
            BagsGalleryScreen(),
            ElectronicsGalleryScreen(),
            AccessoriesGalleryScreen(),
            HomeGardenGalleryScreen(),
            KidsGalleryScreen(),
            BeautyGalleryScreen(),
          ],
        ),
      ),
    );
  }
}

class RepeatedTab extends StatelessWidget {
  final String label;

  const RepeatedTab({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        label,
        style: TextStyle(color: Colors.grey.shade600),
      ),
    );
  }
}
