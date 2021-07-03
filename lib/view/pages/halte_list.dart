import 'package:e_trans/data/models/halte.dart';
import 'package:flutter/material.dart';
import 'package:universe/universe.dart';

class HalteList extends StatelessWidget {
  const HalteList({Key? key, required this.list}) : super(key: key);
  final List<Halte>? list;
  @override
  Widget build(BuildContext context) {
    return PageStorage(
      bucket: PageStorageBucket(),
      child: Container(
        child: ListView.builder(
          itemCount: list!.length,
          itemBuilder: (context, index) {
            var data = list![index];
            var size = MediaQuery.of(context).size;
            return ListTile(
              title: Text(data.nama ?? ""),
              trailing: IconButton(
                icon: Icon(Icons.info_outline),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Stack(
                        children: [
                          SizedBox(
                            width: size.width,
                            height: size.height,
                            child: U.GoogleMap(
                              size: Size(
                                size.width,
                                200,
                              ),
                              zoom: 100,
                              showCenterMarker: false,
                              showLocationMarker: false,
                              markers: MarkerLayer(
                                Marker(
                                  LatLng(data.latitude!, data.longitude!),
                                ),
                                options: MarkerLayerOptions(),
                              ),
                              center: LatLng(
                                  data.latitude ?? 0, data.longitude ?? 0),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 50,
                                    alignment: Alignment.center,
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          data.nama ?? "",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(color: Colors.black),
                                        ),
                                        IconButton(
                                            icon: Icon(Icons.close_outlined),
                                            onPressed: () =>
                                                Navigator.of(context).pop())
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
