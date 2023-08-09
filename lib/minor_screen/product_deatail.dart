import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';
import 'package:stunnzone/main_screens/cart.dart';
import 'package:stunnzone/main_screens/visit_store.dart';
import 'package:stunnzone/minor_screen/full_screen_view.dart';
import 'package:stunnzone/models/product_model.dart';
import 'package:stunnzone/providers/cart_provider.dart';
import 'package:stunnzone/providers/wish_provider.dart';
import 'package:stunnzone/widgets/appbar_widgets.dart';
import 'package:stunnzone/widgets/snackbar.dart';
import 'package:stunnzone/widgets/yellow_button.dart';
import 'package:collection/collection.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic proList;

  const ProductDetailScreen({Key? key, required this.proList})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  late final Stream<QuerySnapshot> _productStream = FirebaseFirestore.instance
      .collection('products')
      .where('maincateg', isEqualTo: widget.proList['maincateg'])
      .where('subcateg', isEqualTo: widget.proList['subcateg'])
      .snapshots();
  late List<dynamic> imageList = widget.proList['proimages'];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Material(
      child: SafeArea(
        child: ScaffoldMessenger(
          key: _scaffoldKey,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FullScreenView(
                                    imagesList: imageList,
                                  )));
                    },
                    child: Stack(
                      children: [
                        SizedBox(
                          height: height * 0.45,
                          child: Swiper(
                              pagination: const SwiperPagination(
                                  builder: SwiperPagination.fraction),
                              itemBuilder: (context, index) {
                                return Image(
                                    image: NetworkImage(
                                  imageList[index],
                                ));
                              },
                              itemCount: imageList.length),
                        ),
                        Positioned(
                            left: 15,
                            top: 20,
                            child: CircleAvatar(
                              backgroundColor: Colors.yellow,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.black,
                                ),
                              ),
                            )),
                        Positioned(
                            right: 15,
                            top: 20,
                            child: CircleAvatar(
                              backgroundColor: Colors.yellow,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.share,
                                  color: Colors.black,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                  Text(
                    widget.proList['proname'],
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'USD  ',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            widget.proList['price'].toStringAsFixed(2),
                            style: const TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<Wish>().getWishItems.firstWhereOrNull(
                                      (product) =>
                                          product.documentId ==
                                          widget.proList['proid']) !=
                                  null
                              ? MyMessageHandler.showSnackBar(
                                  _scaffoldKey, 'This item is already in wishlist')
                              : context.read<Wish>().addWishItem(
                                    widget.proList['proname'],
                                    widget.proList['price'],
                                    1,
                                    widget.proList['instock'],
                                    widget.proList['proimages'],
                                    widget.proList['proid'],
                                    widget.proList['sid'],
                                  );
                        },
                        icon: const Icon(Icons.favorite_border_outlined,
                            size: 30),
                        color: Colors.red,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (widget.proList['instock'].toString()) +
                              (' pices available in stock'),
                          style: const TextStyle(
                              fontSize: 16, color: Colors.blueGrey),
                        ),
                        const ProDeatailHeader(label: '   Item Description   '),
                        Text(
                          widget.proList['prodesc'],
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.blueGrey.shade800),
                        ),
                        const ProDeatailHeader(label: '   Similar Items   '),
                        SizedBox(
                          child: StreamBuilder<QuerySnapshot>(
                            stream: _productStream,
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return const Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (snapshot.data!.docs.isEmpty) {
                                return const Center(
                                  child: Text(
                                    'This category \n\n has no items yet!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 26,
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Acme',
                                        letterSpacing: 1.5),
                                  ),
                                );
                              }

                              return Container(
                                color: Colors.grey.shade200,
                                child: SingleChildScrollView(
                                  child: Container(
                                    color: Colors.grey.shade200,
                                    child: StaggeredGridView.countBuilder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.docs.length,
                                      crossAxisCount: 2,
                                      itemBuilder: (context, index) {
                                        return ProductModel(
                                          product: snapshot.data!.docs[index],
                                        );
                                      },
                                      staggeredTileBuilder: (context) =>
                                          const StaggeredTile.fit(1),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomSheet: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VisitStore(
                                        suppId: widget.proList['sid'])));
                          },
                          icon: const Icon(Icons.shop)),
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CartScreen(
                                          back: AppBarBackButton(),
                                        )));
                          },
                          icon: const Icon(Icons.shopping_cart)),
                    ],
                  ),
                  YellowButton(
                      width: 0.55,
                      onPressed: () {
                        context.read<Cart>().getItems.firstWhereOrNull(
                                    (product) =>
                                        product.documentId ==
                                        widget.proList['proid']) !=
                                null
                            ? MyMessageHandler.showSnackBar(
                                _scaffoldKey, 'This item is already in cart')
                            : context.read<Cart>().addItem(
                                  widget.proList['proname'],
                                  widget.proList['price'],
                                  1,
                                  widget.proList['instock'],
                                  widget.proList['proimages'],
                                  widget.proList['proid'],
                                  widget.proList['sid'],
                                );
                      },
                      label: 'ADD TO CART'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ProDeatailHeader extends StatelessWidget {
  final String label;

  const ProDeatailHeader({
    super.key,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 60,
            width: 50,
            child: Divider(
              color: Colors.yellow.shade900,
              thickness: 1,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 24,
              color: Colors.yellow.shade900,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
