import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/Stalls_Provider.dart';
import '../Widgets/StallItem.dart';

class StallsList extends StatefulWidget {
  final parkId;

  StallsList(this.parkId);

  @override
  _StallsListState createState() => _StallsListState();
}

class _StallsListState extends State<StallsList> {
  @override
  Widget build(BuildContext context) {
    final stalls = Provider.of<Stalls>(context).getStalls;

    return ListView.builder(
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
            value: stalls[index],
            child: StallItem(stalls[index]),
          ),
      itemCount: stalls.length,
    );
  }
}
