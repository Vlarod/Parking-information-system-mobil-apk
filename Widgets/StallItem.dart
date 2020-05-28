import 'package:flutter/material.dart';

import '../Providers/Stall.dart';
import '../Screens/StallDetailScreen.dart';

class StallItem extends StatelessWidget {
  Stall stall;

  StallItem(this.stall);

  Widget subtitle(int type) {
    switch (type) {
      case 0:
        return Text("Volné");
        break;
      case 1:
        return Text("Rezervačné");
        break;
      case 2:
        return Text("Servis");
        break;
      default:
        return Text("Servis");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
          leading: Container(
            height: 45,
            child: CircleAvatar(
              backgroundColor: Colors.black12,
              foregroundColor: Colors.black54,
              radius: 30,
              child: Padding(
                padding: EdgeInsets.all(6),
                child: FittedBox(
                  child: Text(
                    stall.id.toString(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          title: stall.status == 0
              ? Text(
                  "Voľné",
                  style: TextStyle(
                      color: Colors.green[300], fontWeight: FontWeight.bold),
                )
              : Text(
                  "Obsadené",
                  style: TextStyle(
                      color: Colors.red[300], fontWeight: FontWeight.bold),
                ),
          subtitle: subtitle(stall.type),
          trailing: IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              Navigator.of(context).pushNamed(StallDetailScreen.routeName, arguments: stall);
            },
          )),
    );
  }
}
