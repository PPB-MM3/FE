import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:iconamoon/iconamoon.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:telfood/clipper/custom_shape_clipper.dart';
import 'package:telfood/helper/app_colors.dart';
import 'package:telfood/helper/navigators.dart';
import 'package:telfood/widgets/store_item.dart';
import 'package:telfood/widgets/text_sheet.dart';
import 'package:timelines/timelines.dart';

class PesananScreen extends StatefulWidget {
  const PesananScreen({super.key});

  @override
  State<PesananScreen> createState() => _PesananScreenState();
}

class _PesananScreenState extends State<PesananScreen> {
  double _panelHeightOpen = 0;
  final double _panelHeightClosed = 95.0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _panelHeightOpen = MediaQuery.of(context).size.height * 0.65;

    return Material(
      color: AppColors.yellow,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          SlidingUpPanel(
            maxHeight: _panelHeightOpen,
            minHeight: _panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: 0.5,
            body: _body(),
            panelBuilder: (sc) => _panel(sc),
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          appBar(context),
        ],
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return Positioned(
      top: kToolbarHeight,
      left: 20,
      child: Row(
        children: [
          SizedBox.square(
            dimension: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(8),
                backgroundColor: AppColors.maroon,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigators.pop(context);
              },
              child: const Icon(IconaMoon.arrowLeft2),
            ),
          ),
          const SizedBox(width: 15),
          const TextSheet(
            text: "Tunggu Pesanan",
            fontWeight: FontWeight.w800,
            size: 17,
          )
        ],
      ),
    );
  }

  Widget _body() {
    return const Center(child: TextSheet(text: "For Maps"));
  }

  Widget _panel(ScrollController sc) {
    List<TimelineDelivery> timelineDelivery = [
      TimelineDelivery(status: TimelineStatus.done, description: "Pesanan kamu telah diterima"),
      TimelineDelivery(status: TimelineStatus.inProgress, description: "Kantin sedang mempersiapkan pesanan"),
      TimelineDelivery(status: TimelineStatus.todo, description: "Pesananmu sudah siap diantar"),
      TimelineDelivery(status: TimelineStatus.todo, description: "Pesananmu sudah sampai"),
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              width: MediaQuery.of(context).size.width*0.25,
              height: 7,
              decoration: BoxDecoration(
                  color: AppColors.maroon,
                  borderRadius: BorderRadius.circular(50)
              ),
            ),
          ),
          Expanded(
            child: ListView(
              controller: sc,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width*0.2,
                      height: 60,
                      child: Image.asset(
                        "assets/image/geprek.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 60,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: TextSheet(
                                    text: "Kantin KAF",
                                    size: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSheet(
                                  text: DateFormat("dd MMMM yyyy - HH.mm", "id").format(DateTime.now()),
                                  color: AppColors.hint,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return TextSheet(
                                text: "$index Ayam Geprek",
                                fontWeight: FontWeight.w700,
                                size: 13,
                                color: const Color(0xFF646982),
                              );
                            },
                            separatorBuilder: (context, index) => const SizedBox(),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 40),
                const Center(
                  child: TextSheet(
                    text: "20 min",
                    fontWeight: FontWeight.w800,
                    size: 30,
                  ),
                ),
                const Center(
                  child: TextSheet(
                    text: "ESTIMASI TIBA",
                    fontWeight: FontWeight.w400,
                    size: 14,
                    color: AppColors.hint,
                  ),
                ),
                Timeline.tileBuilder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  theme: TimelineThemeData(
                    nodePosition: 0,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  builder: TimelineTileBuilder.connected(
                    itemExtentBuilder: (_, __) => 50,
                    itemCount: timelineDelivery.length,
                    indicatorBuilder: (_, index) {
                      switch (timelineDelivery[index].status) {
                        case TimelineStatus.done:
                          return const DotIndicator(
                            size: 20,
                            color: AppColors.maroon,
                            child: Icon(
                              IconaMoon.check,
                              color: Colors.white,
                              size: 12,
                            ),
                          );
                        case TimelineStatus.sync:
                          return const DotIndicator(
                            size: 20,
                            color: AppColors.hint,
                            child: Icon(
                              IconaMoon.synchronize,
                              color: Colors.white,
                              size: 12,
                            ),
                          );
                        case TimelineStatus.inProgress:
                          return DotIndicator(
                            size: 20,
                            color: AppColors.maroon,
                            child: Icon(
                              MdiIcons.progressHelper,
                              color: Colors.white,
                              size: 12,
                            ),
                          );
                        case TimelineStatus.todo:
                        default:
                          return const DotIndicator(
                            size: 20,
                            color: AppColors.hint,
                            child: Icon(
                              IconaMoon.check,
                              color: Colors.white,
                              size: 12,
                            ),
                          );
                      }
                    },
                    connectorBuilder: (_, index, __) {
                      if (timelineDelivery[index].status == TimelineStatus.done) {
                        return const SolidLineConnector(color: AppColors.maroon, thickness: 2);
                      } else {
                        return const SolidLineConnector(color: AppColors.hint, thickness: 2);
                      }
                    },
                    contentsBuilder: (_, index) => Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextSheet(
                        text: timelineDelivery[index].description,
                        color: timelineDelivery[index].status == TimelineStatus.done ? AppColors.maroon : AppColors.hint,
                        size: 13,
                      ),
                    ),

                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Card(
          margin: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: Color(0xFFE8E8E8),
            ),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20)
            )
          ),
          color: Colors.white,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  child: SizedBox.square(
                    dimension: 60,
                    child: Image.network(
                      "https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: TextSheet(
                              text: "Maharani",
                              size: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSheet(
                            text: "Ibu Kantin",
                            color: AppColors.hint,
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox.square(
                            dimension: 40,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(8),
                                backgroundColor: AppColors.maroon,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {

                              },
                              child: Icon(MdiIcons.phoneOutline),
                            ),
                          ),
                          const SizedBox(width: 10),
                          SizedBox.square(
                            dimension: 40,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(8),
                                side: const BorderSide(color: AppColors.maroon, width: 2),
                                foregroundColor: AppColors.maroon,
                              ),
                              onPressed: () {

                              },
                              child: Icon(MdiIcons.facebookMessenger, color: AppColors.maroon,),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TimelineDelivery {
  final TimelineStatus status;
  final String description;

  TimelineDelivery({required this.status, required this.description});
}
enum TimelineStatus {
  done,
  sync,
  inProgress,
  todo,
}

extension on TimelineStatus {
  bool get isInProgress => this == TimelineStatus.inProgress;
}