import 'package:e_trans/provider/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:e_trans/utils/context_utils.dart';
import 'package:e_trans/view/screens/rute_screen.dart';

class JurusanPage extends StatelessWidget {
  const JurusanPage({Key? key}) : super(key: key);
  static const name = "Jurusan";

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, value, child) {
        var data = value.jurusan!;
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            var item = data[index];
            return Column(
              children: [
                Card(
                  child: ListTile(
                    onTap: () {
                      context.pushTo(
                        RuteScreen(
                          jurusan: item,
                        ),
                      );
                    },
                    enabled: true,
                    title: Text(item.nama!),
                    subtitle: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Text(item.ket ?? ""),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          showGeneralDialog(
                              context: context,
                              pageBuilder: (ctx, ani1, ani2) {
                                return AlertDialog(
                                  title:
                                      Text("jadwal keberangkatan ${item.nama}"),
                                  content: Container(
                                    width:MediaQuery.of(context).size.width*0.8,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        ListView.builder(
                                            itemCount: (item.jadwal ?? []).length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Card(
                                                    child: ListTile(
                                                  title: Text(item.jadwal![index]),
                                                )),
                                              );
                                            },
                                          ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    MaterialButton(
                                      onPressed: () => context.pop(),
                                      child: Text(
                                        "tutup",
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                    )
                                  ],
                                );
                              });
                        },
                        child: Text("Lihat Jadwal"),
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        );
      },
    );
  }
}
