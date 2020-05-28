import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AppBarMy extends StatelessWidget {
  final Text title;
  final Widget myBody;
  final Widget icon;
  final Widget secondTrailingIcon;
  final Widget leadingIcon;
  AppBarMy(
      {this.title,
      this.myBody,
      this.icon,
      this.leadingIcon,
      this.secondTrailingIcon});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              backgroundColor: Theme.of(context).primaryColor,
              middle: title,
              trailing: Container(
                width: 112,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    secondTrailingIcon != null
                        ? secondTrailingIcon
                        : SizedBox(
                            height: 0,
                          ),
                    icon,
                  ],
                ),
              ),
              leading: leadingIcon,
            ),
            child: Material(
              child: myBody,
            ),
          )
        : Scaffold(
            appBar: AppBar(
              leading: leadingIcon,
              centerTitle: true,
              backgroundColor: Theme.of(context).primaryColor,
              title: title,
              actions: <Widget>[
                Container(
                    width: 112,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        secondTrailingIcon != null
                            ? secondTrailingIcon
                            : SizedBox(
                                height: 0,
                              ),
                        icon,
                      ],
                    )),
              ],
            ),
            body: Material(
              child: myBody,
            ),
          );
  }
}
