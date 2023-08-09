import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stunnzone/customer_screens/customer_orders.dart';
import 'package:stunnzone/customer_screens/wishlist.dart';

class ProfileScreen extends StatefulWidget {
  final String documentId;

  const ProfileScreen({Key? key, required this.documentId}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  CollectionReference customers =
      FirebaseFirestore.instance.collection('customers');
  CollectionReference anonymous =
      FirebaseFirestore.instance.collection('anonymous');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseAuth.instance.currentUser!.isAnonymous
            ? anonymous.doc(widget.documentId).get()
            : customers.doc(widget.documentId).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }

          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Scaffold(
              backgroundColor: Colors.grey.shade300,
              body: Stack(
                children: [
                  Container(
                    height: 230,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Colors.yellow, Colors.brown])),
                  ),
                  CustomScrollView(
                    slivers: [
                      SliverAppBar(
                          pinned: true,
                          centerTitle: true,
                          elevation: 0,
                          backgroundColor: Colors.white,
                          expandedHeight: 140,
                          flexibleSpace: LayoutBuilder(
                            builder: (context, constraints) {
                              return FlexibleSpaceBar(
                                title: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 200),
                                  opacity:
                                      constraints.biggest.height <= 120 ? 1 : 0,
                                  child: const Text(
                                    'Account',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                background: Container(
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(colors: [
                                    Colors.yellow,
                                    Colors.brown
                                  ])),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 30),
                                    child: Row(
                                      children: [
                                        data['profileimage'] == null
                                            ? const CircleAvatar(
                                                radius: 50,
                                                backgroundImage: AssetImage(
                                                    'images/inapp/guest.jpg'),
                                              )
                                            : CircleAvatar(
                                                radius: 50,
                                                backgroundImage: NetworkImage(
                                                    data['profileimage']),
                                              ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 25),
                                          child: Text(
                                            data['name'] == ''
                                                ? 'guest'.toUpperCase()
                                                : data['name'].toUpperCase(),
                                            style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Container(
                              height: 80,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(30),
                                        topLeft: Radius.circular(30),
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacementNamed(context,
                                            '/customer_home/cart_screen');
                                      },
                                      child: SizedBox(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: const Center(
                                          child: Text(
                                            'Cart',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.yellow,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    color: Colors.yellow,
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const CustomerOrder()));
                                      },
                                      child: SizedBox(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: const Center(
                                          child: Text(
                                            'Orders',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const WishlistScreen()));
                                      },
                                      child: SizedBox(
                                        height: 40,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        child: const Center(
                                          child: Text(
                                            'Wishlist',
                                            style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.yellow,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              color: Colors.grey.shade300,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 150,
                                    child: Image.asset('images/inapp/logo.jpg'),
                                  ),
                                  const ProfileHeaderLabel(
                                    headerLabel: '  Account Info.  ',
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      height: 260,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Column(
                                        children: [
                                          RepeatedListTile(
                                              icon: Icons.email,
                                              subTitle: data['email'] == ''
                                                  ? 'example@email.com'
                                                  : data['email'],
                                              title: 'Email Address'),
                                          YellowDivider(),
                                          RepeatedListTile(
                                              icon: Icons.phone,
                                              subTitle: data['phone'] == ''
                                                  ? 'example: +11111'
                                                  : data['phone'],
                                              title: 'Phone No.'),
                                          YellowDivider(),
                                          RepeatedListTile(
                                              icon: Icons.location_pin,
                                              subTitle: data['address'] == ''
                                                  ? 'example : New Gersy - usa'
                                                  : data['address'],
                                              title: 'Address'),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const ProfileHeaderLabel(
                                      headerLabel: '  Account Settings  '),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      height: 260,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Column(
                                        children: [
                                          RepeatedListTile(
                                            title: 'Edit Profile',
                                            icon: Icons.edit,
                                            onPressed: () {},
                                          ),
                                          const YellowDivider(),
                                          RepeatedListTile(
                                            title: 'Change Password',
                                            icon: Icons.lock,
                                            onPressed: () {},
                                          ),
                                          const YellowDivider(),
                                          RepeatedListTile(
                                            title: 'Logout',
                                            icon: Icons.logout,
                                            onPressed: () {
                                              Navigator.pushReplacementNamed(
                                                  context, '/welcome_screen');
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
            ),
          );
        });
  }
}

class YellowDivider extends StatelessWidget {
  const YellowDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Divider(
        color: Colors.yellow,
        thickness: 1,
      ),
    );
  }
}

class RepeatedListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final Function()? onPressed;

  const RepeatedListTile({
    required this.title,
    this.subTitle = '',
    required this.icon,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subTitle),
        leading: Icon(icon),
      ),
    );
  }
}

class ProfileHeaderLabel extends StatelessWidget {
  final String headerLabel;

  const ProfileHeaderLabel({
    required this.headerLabel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
            width: 50,
            child: Divider(
              color: Colors.grey,
              thickness: 1,
            ),
          ),
          Text(
            headerLabel,
            style: const TextStyle(
                fontSize: 24, color: Colors.grey, fontWeight: FontWeight.w600),
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
