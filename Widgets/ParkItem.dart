import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../Providers/Park.dart';
import '../Screens/ParkDetail_Screen.dart';

class ParkItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final park = Provider.of<Park>(context);

    return LayoutBuilder(builder: (ctx, constraints) {
      return InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ParkDetail_Screen.routeName, arguments: park.id);
        },
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: constraints.maxHeight * 0.22,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: constraints.maxHeight * 0.15,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            park.name,
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: constraints.maxHeight * 0.13,
                        child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            park.getCityFromAdress,
                            style: TextStyle(
                                color: Colors.black45,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: constraints.maxHeight * 0.10,
                          width: constraints.maxWidth * 0.10,
                          child: park.status == 1
                              ? CircleAvatar(
                                  backgroundColor: Colors.green[300],
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.red[300],
                                ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.end,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
