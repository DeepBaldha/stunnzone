import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stunnzone/widgets/yellow_button.dart';

class CustomerOrderModel extends StatefulWidget {
  const CustomerOrderModel({
    super.key,
    required this.order,
  });

  final QueryDocumentSnapshot<Object?> order;

  @override
  State<CustomerOrderModel> createState() => _CustomerOrderModelState();
}

class _CustomerOrderModelState extends State<CustomerOrderModel> {
  double rate = 3;
  late String comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.yellow)),
        child: ExpansionTile(
          title: Container(
            constraints: const BoxConstraints(maxHeight: 80),
            width: double.infinity,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.network(widget.order['orderimage']),
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        widget.order['ordername'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ('\$ ') +
                                  (widget.order['orderprice']
                                      .toStringAsFixed(2)),
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              'X ${widget.order['orderqty'].toStringAsFixed(2)}',
                              style: const TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('see More..'),
              Text(widget.order['deliverystatus'])
            ],
          ),
          children: [
            Container(
              //height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: widget.order['deliverystatus'] == 'delivered'
                      ? Colors.brown.withOpacity(0.4)
                      : Colors.yellow.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${widget.order['custname']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Phone no: : ${widget.order['phone']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Email Address: ${widget.order['email']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Address: ${widget.order['address']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Payment Status: ',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '${widget.order['paymentstatus']}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.purple),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Delivery Status: ',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '${widget.order['deliverystatus']}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.green),
                        ),
                      ],
                    ),
                    widget.order['deliverystatus'] == 'shipping'
                        ? Text(
                            ('Estimated Delivery date: ') +
                                (DateFormat('yyyy-MM-dd').format(
                                        widget.order['deliverydate'].toDate()))
                                    .toString(),
                            style: const TextStyle(fontSize: 16),
                          )
                        : const Text(''),
                    widget.order['deliverystatus'] == 'delivered' &&
                            widget.order['orderreview'] == false
                        ? TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => Material(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 180),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                RatingBar.builder(
                                                    minRating: 3,
                                                    allowHalfRating: true,
                                                    initialRating: 3,
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        ),
                                                    onRatingUpdate: (rating) {
                                                      rate = rating;
                                                    }),
                                                TextField(
                                                  decoration: InputDecoration(
                                                      hintText:
                                                          'Enter your review',
                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  15)),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 1),
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  15)),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .amber,
                                                                  width: 2),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15))),
                                                  onChanged: (value) {
                                                    comment = value;
                                                  },
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      YellowButton(
                                                          width: 0.3,
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          label: 'Cancel'),
                                                      const SizedBox(width: 20),
                                                      YellowButton(
                                                          width: 0.3,
                                                          onPressed: () async {
                                                            CollectionReference
                                                                collRef =
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'products')
                                                                    .doc(widget
                                                                            .order[
                                                                        'proid'])
                                                                    .collection(
                                                                        'reviews');
                                                            await collRef
                                                                .doc(FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .uid)
                                                                .set({
                                                              'name': widget
                                                                      .order[
                                                                  'custname'],
                                                              'email':
                                                                  widget.order[
                                                                      'email'],
                                                              'rate': rate,
                                                              'comment':
                                                                  comment,
                                                              'profileimage':
                                                                  widget.order[
                                                                      'profileimage']
                                                            }).whenComplete(
                                                                    () async {
                                                              await FirebaseFirestore
                                                                  .instance
                                                                  .runTransaction(
                                                                      (transaction) async {
                                                                DocumentReference
                                                                    documentReference =
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'orders')
                                                                        .doc(widget
                                                                            .order['orderid']);
                                                                transaction.update(
                                                                    documentReference,
                                                                    {
                                                                      'orderreview':
                                                                          true
                                                                    });
                                                              });
                                                            });
                                                            await Future.delayed(
                                                                    const Duration(
                                                                        microseconds:
                                                                            100))
                                                                .whenComplete(() =>
                                                                    Navigator.pop(
                                                                        context));
                                                          },
                                                          label: 'OK')
                                                    ])
                                              ]),
                                        ),
                                      ));
                            },
                            child: const Text('Write review'))
                        : const Text(''),
                    widget.order['deliverystatus'] == 'delivered' &&
                            widget.order['orderreview'] == true
                        ? const Row(
                            children: [
                              Icon(
                                Icons.check,
                                color: Colors.blue,
                              ),
                              Text('Review Added',
                                  style: TextStyle(fontStyle: FontStyle.italic))
                            ],
                          )
                        : const Text(''),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
