import 'package:flutter/material.dart';
import 'package:stunnzone/galleries/men_gallery.dart';
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
          elevation: 0,
          backgroundColor: Colors.white,
          title: const FakeSearch(),
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.yellow,
            indicatorWeight: 8,
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
            Center(child: Text("shoes screen")),
            Center(child: Text("bags screen")),
            Center(child: Text("electronics screen")),
            Center(child: Text("accessories screen")),
            Center(child: Text("home & garden screen")),
            Center(child: Text("kids screen")),
            Center(child: Text("beauty screen")),
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
