import 'package:akari_project/main.dart';
import 'package:akari_project/page_shop/shop_item.dart';
import 'package:akari_project/themes.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ShopTile extends StatefulWidget {
  final ShopItem item;

  const ShopTile({super.key, required this.item});

  @override
  State<ShopTile> createState() => _ShopTileState();
}

class _ShopTileState extends State<ShopTile> {
  Future<void> changeTheme() async {
    var userBox = await Hive.box('userBox');
    if (widget.item.type == ShopItemType.background) {
      userBox.put("background", widget.item.id);
    } else if (widget.item.type == ShopItemType.bulb) {
      userBox.put("bulb", widget.item.id);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        var obtenu = widget.item.isBought;
        if (obtenu) {
          // changer le thème
          changeTheme();
        }
      },
      child: Container(
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
                var name = widget.item.type == ShopItemType.background
                    ? "Thème ${widget.item.name}"
                    : "Ampoule ${widget.item.name}";
                if (!obtenu) {
                  if (coins >= widget.item.price) {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text(name),
                        content: const Text("Confirmer l'achat ?",
                            style: TextStyle(fontSize: 20)),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'Cancel'),
                            child: const Text('Non'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                var name =
                                    widget.item.type == ShopItemType.background
                                        ? "background_${widget.item.name}"
                                        : "bulb${widget.item.name}";
                                Hive.box('userBox')
                                    .put('coins', coins - widget.item.price);
                                widget.item.isBought = true;
                                Hive.box('shopItemBox').put(name, widget.item);
                                Navigator.pop(context, 'OK');
                              });
                            },
                            child: const Text('Oui'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: Text(name),
                        content: const Text(
                          "Pas assez de pièces !",
                          style: TextStyle(fontSize: 20),
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                }
              },
              child: ValueListenableBuilder<Box>(
                valueListenable: Hive.box('userBox').listenable(),
                builder: (context, box, _) {
                  var theme = box.get("background");
                  return Container(
                    height: 45,
                    margin: const EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: MyTheme.getTheme(theme).shopItem,
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Builder(
                            builder: (context) {
                              if (widget.item.isBought) {
                                if ((widget.item.type ==
                                            ShopItemType.background &&
                                        widget.item.id == theme) ||
                                    (widget.item.type == ShopItemType.bulb &&
                                        widget.item.id == box.get("bulb"))) {

                                    return const Text(
                                      "Selectionné",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    );
                                  } else {
                                    return const Text(
                                      "Acheté !",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    );
                                  }
                                } else {

                                return Text(
                                  widget.item.price.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                );
                              }
                            },
                          ),
                        ),
                        Visibility(
                          visible: !widget.item.isBought,
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 8.0, left: 8.0, bottom: 8.0),
                            child: Image(
                              image: MyTheme.getTheme(theme).monnaie,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
