import 'package:flutter/material.dart';
import 'package:stunnzone/utilities/categ_list.dart';
import 'package:stunnzone/widgets/categ_widgets.dart';

class WomenCategory extends StatelessWidget {
  const WomenCategory({Key? key}) : super(key: key);

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
                  const CategHeaderLabel(headerLabel: 'Women'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.68,
                    child: GridView.count(
                      mainAxisSpacing: 40,
                      crossAxisSpacing: 15,
                      crossAxisCount: 3,
                      children: List.generate(women.length, (index) {
                        return SubcategModel(
                          assetName: 'images/women/women$index.jpg',
                          mainCategName: 'Women',
                          subCategLabel: women[index],
                          subCategName: women[index],
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
            child: SliderBar(mainCategName: "women"),
          ),
        ],
      ),
    );
  }
}

