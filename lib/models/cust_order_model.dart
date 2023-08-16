import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomerOrderModel extends StatelessWidget {
  const CustomerOrderModel({
    super.key,
    required this.order,
  });

  final QueryDocumentSnapshot<Object?> order;

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
                  child: Container(
                    width: 80,
                    height: 80,
                    child: Image.network(order['orderimage']),
                  ),
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        order['ordername'],
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
                                  (order['orderprice'].toStringAsFixed(2)),
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              'X ${order['orderqty'].toStringAsFixed(2)}',
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
            children: [const Text('see More..'), Text(order['deliverystatus'])],
          ),
          children: [
            Container(
              //height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: order['deliverystatus'] == 'delivered'
                      ? Colors.brown.withOpacity(0.4)
                      : Colors.yellow.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: ${order['custname']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Phone no: : ${order['phone']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Email Address: ${order['email']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Address: ${order['address']}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        const Text(
                          'Payment Status: ',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '${order['paymentstatus']}',
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
                          '${order['deliverystatus']}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.green),
                        ),
                      ],
                    ),
                    order['deliverystatus'] == 'shipping'
                        ? Text(
                            ('Estimated Delivery date: ') +
                                (DateFormat('yyyy-MM-dd')
                                    .format(order['deliverydate'].toDate()))
                                    .toString(),
                            style: const TextStyle(fontSize: 16),
                          )
                        : const Text(''),
                    order['deliverystatus'] == 'delivered' &&
                            order['orderreview'] == false
                        ? TextButton(
                            onPressed: () {}, child: const Text('Write review'))
                        : const Text(''),
                    order['deliverystatus'] == 'delivered' &&
                            order['orderreview'] == true
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
