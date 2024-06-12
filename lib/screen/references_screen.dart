import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:iconamoon/iconamoon.dart';
import 'package:telfood/clipper/custom_shape_clipper.dart';
import 'package:telfood/helper/app_colors.dart';
import 'package:telfood/helper/navigators.dart';
import 'package:telfood/widgets/store_item.dart';
import 'package:telfood/widgets/store_item_references.dart';
import 'package:telfood/widgets/text_sheet.dart';

class ReferencesScreen extends StatefulWidget {
  const ReferencesScreen({super.key});

  @override
  State<ReferencesScreen> createState() => _ReferencesScreenState();
}

class _ReferencesScreenState extends State<ReferencesScreen> {
  TextEditingController tecSeach = TextEditingController();
  
  List<Product> productList = [
    Product(image: "https://images.unsplash.com/photo-1647102398925-e23f6486ca04?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", name: "Fried Chicken", price: 12000, amount: 1, store: "Kantin Neo"),
    Product(image: "https://images.unsplash.com/photo-1666239308345-c4c12ef3e177?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", name: "Ayam Kecap Urap", price: 25000, amount: 0, store: "Kantin Beta"),
    Product(image: "https://images.unsplash.com/photo-1627799370307-9b2a689bb94f?q=80&w=1888&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", name: "Ayam Bakar", price: 16000, amount: 0, store: "Kantin Alpha"),
    Product(image: "https://images.unsplash.com/photo-1647102398925-e23f6486ca04?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", name: "Fried Chicken", price: 12000, amount: 1, store: "Kantin Bela"),
    Product(image: "https://images.unsplash.com/photo-1666239308345-c4c12ef3e177?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", name: "Ayam Kecap Urap", price: 25000, amount: 0, store: "Kantin 02"),
    Product(image: "https://images.unsplash.com/photo-1627799370307-9b2a689bb94f?q=80&w=1888&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", name: "Ayam Bakar", price: 16000, amount: 0, store: "Kantin Pustaka"),
  ];

  Store stores = Store(
      imageUrl: [
        "https://images.unsplash.com/photo-1534723452862-4c874018d66d?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1561566302-67abce51c2c3?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1534723452862-4c874018d66d?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1561566302-67abce51c2c3?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
        "https://images.unsplash.com/photo-1534723452862-4c874018d66d?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      ],
      name: "TelFood",
      description: "Layanan siap antar bagi masyarakat Telkom University dengan berbagai pilihan menu pada kantin yang ada di seluruh area kampus",
      rate: 4.7,
      delivery: "Free",
      deliveryTime: 20,
    );

  List<String> kategori = [
    "Kopi", "Ayam", "Susu", "Es", "Kacang", "Indomie"
  ];

  String selectedKategori = "Ayam";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StoreItemReferences(
                imageUrl: stores.imageUrl,
                name: stores.name,
                kategori: stores.description,
                rate: stores.rate,
                delivery: stores.delivery,
                deliveryTimeOnMinute: stores.deliveryTime,
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 60,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: kategori.length,
                        itemBuilder: (context, index) {
                          return FilterChip(
                            label: TextSheet(
                              text: kategori[index],
                              color: kategori[index] == selectedKategori ? Colors.white : null,
                              size: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            side: kategori[index] == selectedKategori ? BorderSide.none : null,
                            backgroundColor: kategori[index] == selectedKategori ? AppColors.yellow : null,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 15,
                            ),
                            onSelected: (value) {
                              setState(() {
                                selectedKategori = kategori[index];
                              });
                            },
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(width: 10),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const TextSheet(
                      text: "Ayam (10)",
                      size: 20,
                    ),
                    const SizedBox(height: 10),
                    GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 30,
                        mainAxisSpacing: 20,
                        childAspectRatio: 0.8,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.zero,
                          color: Colors.white,
                          surfaceTintColor: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height*0.135,
                                    width: MediaQuery.of(context).size.width,
                                    child: Image.network(
                                      productList[index].image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextSheet(
                                      text: productList[index].name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.w700,
                                      size: 15,
                                    ),
                                    TextSheet(
                                      text: productList[index].store,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      size: 13,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: TextSheet(
                                              text: "Rp ${productList[index].price.toCurrencyString(mantissaLength: 0, thousandSeparator: ThousandSeparator.Period)}",
                                              textAlign: TextAlign.start,
                                              fontWeight: FontWeight.w700,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 5),
                                        SizedBox.square(
                                          dimension: 30,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              shape: const CircleBorder(),
                                              padding: const EdgeInsets.all(0),
                                              backgroundColor: AppColors.yellow,
                                              foregroundColor: Colors.white,
                                            ),
                                            onPressed: () {
                                              Navigators.pop(context);
                                            },
                                            child: const Icon(IconaMoon.signPlus),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox.square(
              dimension: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(8),
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.text,
                ),
                onPressed: () {
                  Navigators.pop(context);
                },
                child: const Icon(IconaMoon.arrowLeft2),
              ),
            ),
            const SizedBox(width: 20),
            SizedBox.square(
              dimension: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(8),
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.text,
                ),
                onPressed: () {

                },
                child: const Icon(Icons.more_horiz),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
    );
  }
}

class Product {
  final String image;
  final String name;
  final String store;
  final int price;
  int amount;

  Product({required this.image, required this.name, required this.store, required this.price, required this.amount});
}

class Store {
  final List<String> imageUrl;
  final String name;
  final String description;
  final double rate;
  final String delivery;
  final int deliveryTime;

  Store({
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.rate,
    required this.delivery,
    required this.deliveryTime,
  });
}