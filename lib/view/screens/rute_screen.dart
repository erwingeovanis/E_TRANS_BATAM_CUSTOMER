import 'package:e_trans/data/models/jurusan.dart';
import 'package:flutter/material.dart';
import 'package:timelines/timelines.dart';
import 'package:universe/universe.dart';

class RuteScreen extends StatefulWidget {
  const RuteScreen({Key? key, required this.jurusan}) : super(key: key);
  final Jurusan jurusan;

  @override
  _RuteScreenState createState() => _RuteScreenState();
}

class _RuteScreenState extends State<RuteScreen> {
  late final MapController _controller;
  @override
  void initState() {
    _controller = MapController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rute ${widget.jurusan.nama}"),
      ),
      body: Stack(
        children: [
          Container(
            child: U.GoogleMap(
              controller: _controller,
              markers: MarkerLayer(
                widget.jurusan.rute!
                    .map((e) => Marker(LatLng(e.latitude, e.longitude)))
                    .toList(),
                options: MarkerLayerOptions(
                    widget: Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40,
                )),
              ),
              center: LatLng(widget.jurusan.rute!.first.latitude,
                  widget.jurusan.rute!.first.longitude),
              polylines: PolylineLayer(
                Polyline(widget.jurusan.rute!
                    .map((e) => LatLng(e.latitude, e.longitude))
                    .toList()),
                options: PolylineLayerOptions(
                  isDotted: true,
                  interactive: true,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Material(
              type: MaterialType.transparency,
              child: Container(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 10,
                ),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FixedTimeline.tileBuilder(
                      theme: TimelineThemeData(
                        nodePosition: 0,
                        color: Color(0xff989898),
                        indicatorTheme: IndicatorThemeData(
                          position: 0,
                          size: 20.0,
                        ),
                        connectorTheme: ConnectorThemeData(
                          thickness: 2.5,
                        ),
                      ),
                      builder: TimelineTileBuilder.connected(
                        connectionDirection: ConnectionDirection.before,
                        contentsBuilder: (ctx, index) {
                          return Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    _controller.move(LatLng(
                                        widget.jurusan.rute!.reversed
                                            .toList()[index]
                                            .latitude,
                                        widget.jurusan.rute!.reversed
                                            .toList()[index]
                                            .longitude));
                                  },
                                  child: Text(
                                    widget.jurusan.rute!.reversed
                                            .toList()[index]
                                            .nama ??
                                        "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .copyWith(
                                          fontSize: 18.0,
                                        ),
                                  ),
                                ),
                                Padding(padding: EdgeInsets.all(10)),
                              ],
                            ),
                          );
                        },
                        indicatorBuilder: (ctx, index) {
                          // print(
                          //     "${widget.jurusan.currentRoute} == ${widget.jurusan.rute!.map((e) => e.toJson()).toList()}");
                          if (index > (widget.jurusan.currentRoute ?? 0)) {
                            return DotIndicator(
                              color: Colors.blueAccent,
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 12.0,
                              ),
                            );
                          } else {
                            return OutlinedDotIndicator(
                              borderWidth: 2.5,
                            );
                          }
                        },
                        connectorBuilder: (_, index, ___) => SolidLineConnector(
                          color: index > (widget.jurusan.currentRoute ?? 0)
                              ? Colors.blueAccent
                              : null,
                        ),
                        itemCount: (widget.jurusan.rute ?? []).length,
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
