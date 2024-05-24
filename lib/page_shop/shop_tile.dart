import 'package:akari_project/page_shop/shop_item.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ShopTile extends StatefulWidget {
  final ShopItem item;

  const ShopTile({super.key, required this.item});

  @override
  State<ShopTile> createState() => _ShopTileState();
}

class _ShopTileState extends State<ShopTile> {
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
                  image: AssetImage(widget.item.pathToImage),
                )),
          ),
          Text(
            widget.item.name,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
          GestureDetector(
            onTap: () {
              var obtenu = widget.item.isBought;
              var coins = Hive.box('userBox').get('coins');
              if (!obtenu) {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: Text(widget.item.name),
                    content: const Text("Confirmer l'achat ?"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Non'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            Hive.box('userBox')
                                .put('coins', coins - widget.item.price);
                            widget.item.isBought = true;
                            Navigator.pop(context, 'OK');
                          });
                        },
                        child: const Text('Oui'),
                      ),
                    ],
                  ),
                );
              }
            },
            child: Container(
              height: 45,
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: const Color(0xFF370617),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      widget.item.isBought
                          ? "Acheté !"
                          : widget.item.price.toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Visibility(
                    visible: !widget.item.isBought,
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
            ),
          )
        ],
      ),
    );
  }
}
