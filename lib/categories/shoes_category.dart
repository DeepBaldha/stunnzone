import 'package:flutter/material.dart';
import 'package:stunnzone/utilities/categ_list.dart';
import 'package:stunnzone/widgets/categ_widgets.dart';

class ShoesCategory extends StatelessWidget {
  const ShoesCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.75,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CategHeaderLabel(headerLabel: 'Shoes'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.68,
                    child: GridView.count(
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 10,
                      crossAxisCount: 3,
                      children: List.generate(shoes.length-1, (index) {
                        return SubcategModel(
                          assetName: 'images/shoes/shoes$index.jpg',
                          mainCategName: 'shoes',
                          subCategLabel: shoes[index+1],
                          subCategName: shoes[index+1],
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            bottom: 0,
            right: 0,
            child: SliderBar(mainCategName: "shoes"),
          ),
        ],
      ),
    );
  }
}

