import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stunnzone/main_screens/visit_store.dart';
import 'package:stunnzone/widgets/appbar_widgets.dart';

class StoresScreen extends StatelessWidget {
  const StoresScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const AppBarTItle(title: 'Stores'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('suppliers').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
                itemCount: snapshot.data!.docs.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 25,
                    crossAxisSpacing: 25,
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VisitStore(
                                  suppId: snapshot.data!.docs[index]['sid'])));
                    },
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            SizedBox(
                              height: 120,
                              width: 120,
                              child: Image.asset('images/inapp/store.png'),
                            ),
                            Positioned(
                                bottom: 14,
                                left: 5,
                                right: 5,
                                child: SizedBox(
                                  height: 50,
                                  width: 130,
                                  child: Image.network(
                                    snapshot.data!.docs[index]['storeLogo'],
                                    fit: BoxFit.cover,
                                  ),
                                ))
                          ],
                        ),
                        Text(
                          snapshot.data!.docs[index]['storeName'].toLowerCase(),
                          style: const TextStyle(
                              fontSize: 24, fontFamily: 'AkayaTelivigala'),
                        ),
                      ],
                    ),
                  );
                });
          }
          return const Center(
            child: Text('No Store found'),
          );
        },
      ),
    );
  }
}
