import 'package:flutter/material.dart';
import 'package:new_nutristionist_template/models/nutrition_items/breakfast_items.dart';
import 'package:provider/provider.dart';

class BreakFastProducts extends StatefulWidget {
  static int quantity = 0;
  final String uid;
  final DateTime day;
  BreakFastProducts(this.uid, this.day);
  static List<String> addedItems = [];

  @override
  _BreakFastProductsState createState() => _BreakFastProductsState();
}

class _BreakFastProductsState extends State<BreakFastProducts> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemBreakfast>(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 20,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.black)),
      child: Column(
        children: [
          // ClipRRect(
          //   borderRadius: BorderRadius.circular(2),
          //   child: Container(
          //     width: double.infinity,
          //     constraints: BoxConstraints(
          //         minHeight: 100,
          //         maxHeight: MediaQuery.of(context).size.height * 0.3),
          //     child: Image.network(
          //       itemProvider.imageUrl,
          //       fit: BoxFit.fitWidth,
          //     ),
          //   ),
          // ),
          Container(
            padding: const EdgeInsets.only(left: 5),
            margin: const EdgeInsets.only(left: 5, bottom: 2, right: 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SizedBox(
                //   height: 4,
                // ),
                Text(
                  itemProvider.title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w600),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 3),
                //   child: Text(
                //     itemProvider.price,
                //     overflow: TextOverflow.ellipsis,
                //     maxLines: 2,
                //     style: TextStyle(
                //         fontSize: 18,
                //         color: Colors.black,
                //         fontWeight: FontWeight.w900),
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            if (quantity > 0) {
                              quantity--;

                              BreakFastProducts.addedItems
                                  .remove(itemProvider.id);
                            }
                          });
                        },
                        borderRadius: BorderRadius.circular(18),
                        child: Icon(
                          Icons.remove,
                          color: Colors.red,
                        ),
                      ),
                    ),
                    Text(quantity.toString()),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            quantity++;

                            BreakFastProducts.addedItems.add(itemProvider.id);
                          });
                        },
                        borderRadius: BorderRadius.circular(18),
                        child: Icon(
                          Icons.add,
                          color: Colors.green,
                        ),
                      ),
                    )
                  ],
                ),
                // InkWell(
                //   onTap: () {
                //     setState(() {
                //     });
                //   },
                //   child: Card(
                //     child: ListTile(
                //       leading: Text('Add'),
                //       trailing: Icon(
                //         Icons.check,
                //         color: Colors.green,
                //       ),
                //     ),
                //   ),
                // )
              ],
            ),
          )
        ],
      ),
    );
  }
}
