import 'package:flutter/material.dart';
import 'package:new_nutristionist_template/models/nutrition_items/lunch_items.dart';
import 'package:provider/provider.dart';

class LunchProducts extends StatefulWidget {
  static int quantity = 0;
  final String uid;
  final DateTime day;
  LunchProducts(this.uid, this.day);
  static List<String> addedItems = [];

  @override
  _LunchProductsState createState() => _LunchProductsState();
}

class _LunchProductsState extends State<LunchProducts> {
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    final itemProvider = Provider.of<ItemLunch>(context);
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

                              LunchProducts.addedItems.remove(itemProvider.id);
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

                            LunchProducts.addedItems.add(itemProvider.id);
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
                //       for (int i = 0; i < quantity; i++)
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
