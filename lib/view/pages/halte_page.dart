import 'package:e_trans/provider/main_provider.dart';
import 'package:e_trans/view/pages/halte_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HaltePage extends StatelessWidget {
  const HaltePage({Key? key}) : super(key: key);
  static const name = "Halte";
  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, value, child) {
        var data = value.halteByArea;
        return ListView.builder(
          itemCount: data.keys.length,
          itemBuilder: (context, index) {
            var item = data.keys.toList()[index];
            return ExpansionTile(
              title: Text(
                item,
              ),
              children: [
                Container(
                  height: 150,
                  child: HalteList(
                    list: data[item] ?? [],
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }
}
