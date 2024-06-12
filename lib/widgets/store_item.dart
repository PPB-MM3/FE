import 'package:flutter/material.dart';
import 'package:iconamoon/iconamoon.dart';
import 'package:telfood/helper/app_colors.dart';
import 'package:telfood/widgets/text_sheet.dart';

class StoreItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String kategori;
  final double rate;
  final String delivery;
  final int deliveryTimeOnMinute;
  final void Function()? onTap;

  const StoreItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.kategori,
    required this.rate,
    required this.delivery,
    required this.deliveryTimeOnMinute,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height*0.225,
            width: MediaQuery.of(context).size.width,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextSheet(
            text: name,
            size: 20,
          ),
          TextSheet(
            text: kategori,
            color: AppColors.hint,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Row(
                children: [
                  const Icon(IconaMoon.star, color: AppColors.maroon, size: 16),
                  const SizedBox(width: 5),
                  TextSheet(
                    text: rate.toString(),
                    fontWeight: FontWeight.w700,
                    size: 16,
                  )
                ],
              ),
              SizedBox(width: MediaQuery.of(context).size.width*0.075),
              Row(
                children: [
                  const Icon(IconaMoon.deliveryFast, color: AppColors.maroon, size: 16),
                  const SizedBox(width: 5),
                  TextSheet(
                    text: delivery,
                    fontWeight: FontWeight.w400,
                  )
                ],
              ),
              SizedBox(width: MediaQuery.of(context).size.width*0.075),
              Row(
                children: [
                  const Icon(IconaMoon.clock, color: AppColors.maroon, size: 16),
                  const SizedBox(width: 5),
                  TextSheet(
                    text: "$deliveryTimeOnMinute min",
                    fontWeight: FontWeight.w400,
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
