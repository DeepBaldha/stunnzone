import 'package:flutter/material.dart';
import 'package:stunnzone/utilities/categ_list.dart';
import 'package:stunnzone/widgets/categ_widgets.dart';

class AccessoriesCategory extends StatelessWidget {
  const AccessoriesCategory ({Key? key}) : super(key: key);

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
                  const CategHeaderLabel(headerLabel: 'Accessories'),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.68,
                    child: GridView.count(
                      mainAxisSpacing: 40,
                      crossAxisSpacing: 15,
                      crossAxisCount: 3,
                      children: List.generate(accessories.length-1, (index) {
                        return SubcategModel(
                          assetName: 'images/accessories/accessories${index}.jpg',
                          mainCategName: 'Accessories',
                          subCategLabel: accessories[index+1],
                          subCategName: accessories[index+1],
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
            child: SliderBar(mainCategName: "Accessories"),
          ),
        ],
      ),
    );
  }
}

