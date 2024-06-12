import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:iconamoon/iconamoon.dart';
import 'package:telfood/helper/app_colors.dart';
import 'package:telfood/helper/navigators.dart';
import 'package:telfood/widgets/text_sheet.dart';

class StoreItemReferences extends StatefulWidget {
  final List<String> imageUrl;
  final String name;
  final String kategori;
  final double rate;
  final double? horizontalPadding;
  final String delivery;
  final int deliveryTimeOnMinute;

  const StoreItemReferences({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.kategori,
    required this.rate,
    this.horizontalPadding,
    required this.delivery,
    required this.deliveryTimeOnMinute,
  });

  @override
  State<StoreItemReferences> createState() => _StoreItemReferencesState();
}

class _StoreItemReferencesState extends State<StoreItemReferences> {
  int current = 0;
  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height*0.375,
              width: MediaQuery.of(context).size.width,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: CarouselSlider.builder(
                  carouselController: carouselController,
                  options: CarouselOptions(
                    aspectRatio: 1,
                    viewportFraction: 1,
                    onPageChanged: (index, reason) {
                      setState(() {
                        current = index;
                      });
                    },
                  ),
                  itemCount: widget.imageUrl.length,
                  itemBuilder: (context, index, realIndex) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(
                        widget.imageUrl[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: SizedBox(
                  height: 25,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: widget.imageUrl.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => setState(() {
                          carouselController.animateToPage(
                            index,
                            duration: Duration(milliseconds: 200),
                          );
                          current = index;
                        }),
                        child: Icon(
                          current == index ? Icons.radio_button_checked : Icons.circle,
                          color: Colors.white.withOpacity(current == index ? 1 : 0.41),
                          size: current == index ? 25 : 15,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(width: 5),
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: widget.horizontalPadding ?? 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Row(
                children: [
                  Row(
                    children: [
                      const Icon(IconaMoon.star, color: Color(0xFFFF7622), size: 16),
                      const SizedBox(width: 5),
                      TextSheet(
                        text: widget.rate.toString(),
                        fontWeight: FontWeight.w700,
                        size: 16,
                      )
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*0.075),
                  Row(
                    children: [
                      const Icon(IconaMoon.deliveryFast, color: Color(0xFFFF7622), size: 16),
                      const SizedBox(width: 5),
                      TextSheet(
                        text: widget.delivery,
                        fontWeight: FontWeight.w400,
                      )
                    ],
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width*0.075),
                  Row(
                    children: [
                      const Icon(IconaMoon.clock, color: Color(0xFFFF7622), size: 16),
                      const SizedBox(width: 5),
                      TextSheet(
                        text: "${widget.deliveryTimeOnMinute} min",
                        fontWeight: FontWeight.w400,
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextSheet(
                text: widget.name,
                size: 20,
              ),
              const SizedBox(height: 5),
              TextSheet(
                text: widget.kategori,
                color: AppColors.hint,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
