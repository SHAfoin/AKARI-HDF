import 'package:akari_project/page_shop/shop_item.dart';
import 'package:flutter/material.dart';

class ShopTile extends StatelessWidget {
  final ShopItem item;

  const ShopTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
                margin: const EdgeInsets.all(10),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Image(
                  image: AssetImage(item.pathToImage),
                )),
          ),
          Text(
            item.name,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
          Container(
            height: 45,
            margin: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
                color: const Color(0xFF370617), borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    item.isBought ? "Acheté !" : item.price.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
                Visibility(
                  visible: !item.isBought,
                  child: const Padding(
                    padding:
                        EdgeInsets.only(top: 8.0, left: 8.0, bottom: 8.0),
                    child: Image(
                      image: AssetImage('assets/images/coin.png'),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
