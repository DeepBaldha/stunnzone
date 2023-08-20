import 'package:flutter/material.dart';
import 'package:stunnzone/categories/accessories_category.dart';
import 'package:stunnzone/categories/bags_category.dart';
import 'package:stunnzone/categories/beauty_category.dart';
import 'package:stunnzone/categories/electronics_category.dart';
import 'package:stunnzone/categories/home_garden_category.dart';
import 'package:stunnzone/categories/kids_category.dart';
import 'package:stunnzone/categories/men_category.dart';
import 'package:stunnzone/categories/shoes_category.dart';
import 'package:stunnzone/categories/women_category.dart';
import 'package:stunnzone/widgets/fake_search.dart';

List<ItemsData> items = [
  ItemsData(label: "men"),
  ItemsData(label: "women"),
  ItemsData(label: "shoes"),
  ItemsData(label: "bags"),
  ItemsData(label: "electronics"),
  ItemsData(label: "accessories"),
  ItemsData(label: "home & garden"),
  ItemsData(label: "kids"),
  ItemsData(label: "beauty"),
];

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    for (var element in items) {
      element.isSelected = false;
    }
    setState(() {
      items[0].isSelected = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        title: const FakeSearch(),
      ),
      body: Stack(
        children: [
          Positioned(bottom: 0, left: 0, child: SideNavigator(size)),
          Positioned(bottom: 0, right: 0, child: CatagView(size)),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget SideNavigator(Size size) {
    return SizedBox(
      height: size.height * 0.8,
      width: size.width * 0.2,
      child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                _pageController.animateToPage(
                  index,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.bounceIn,
                );
                /*for(var element in items){
                  element.isSelected = false;
                }
                setState(() {
                  items[index].isSelected = true;
                });*/
              },
              child: Container(
                color: items[index].isSelected == true
                    ? Colors.white
                    : Colors.grey.shade400,
                height: 80,
                child: Center(
                  child: Text(items[index].label),
                ),
              ),
            );
          }),
    );
  }

  // ignore: non_constant_identifier_names
  Widget CatagView(Size size) {
    return Container(
      height: size.height * 0.8,
      width: size.width * 0.8,
      color: Colors.white,
      child: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          for (var element in items) {
            element.isSelected = false;
          }
          setState(() {
            items[value].isSelected = true;
          });
        },
        scrollDirection: Axis.vertical,
        children: const [
          MenCategory(),
          WomenCategory(),
          ShoesCategory(),
          BagsCategory(),
          ElectronicsCategory(),
          AccessoriesCategory(),
          HomeGardenCategory(),
          KidsCategory(),
          BeautyCategory(),
        ],
      ),
    );
  }
}

class ItemsData {
  String label;
  bool isSelected;

  ItemsData({required this.label, this.isSelected = false});
}
