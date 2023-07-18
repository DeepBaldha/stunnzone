import 'package:flutter/material.dart';
import 'package:stunnzone/minor_screen/subcateg_products.dart';

class SliderBar extends StatelessWidget {
  final String mainCategName;

  const SliderBar({
    super.key,
    required this.mainCategName,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.05,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.brown.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50),
          ),
          child: RotatedBox(
            quarterTurns: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                mainCategName == 'beauty'
                    ? const Text('')
                    : const Text(" << ", style: style),
                Text(mainCategName.toUpperCase(), style: style),
                mainCategName == 'men'
                    ? const Text('')
                    : const Text(" >> ", style: style),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const style = TextStyle(
  fontWeight: FontWeight.w600,
  fontSize: 16,
  color: Colors.brown,
  letterSpacing: 10,
);

class SubcategModel extends StatelessWidget {
  final String mainCategName;
  final String subCategName;
  final String assetName;
  final String subCategLabel;

  const SubcategModel(
      {super.key,
      required this.assetName,
      required this.mainCategName,
      required this.subCategLabel,
      required this.subCategName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubCategProducts(
              maincategName: mainCategName,
              subcategName: subCategName,
            ),
          ),
        );
      },
      child: Column(
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: Image(
              image: AssetImage(assetName),
            ),
          ),
          Expanded(
            child: Text(
              subCategLabel,

              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class CategHeaderLabel extends StatelessWidget {
  final String headerLabel;

  const CategHeaderLabel({super.key, required this.headerLabel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        headerLabel,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}
