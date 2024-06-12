import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:iconamoon/iconamoon.dart';
import 'package:telfood/clipper/custom_shape_clipper.dart';
import 'package:telfood/helper/app_colors.dart';
import 'package:telfood/helper/navigators.dart';
import 'package:telfood/widgets/store_item.dart';
import 'package:telfood/widgets/text_sheet.dart';

class KantinScreen extends StatefulWidget {
  const KantinScreen({super.key});

  @override
  State<KantinScreen> createState() => _KantinScreenState();
}

class _KantinScreenState extends State<KantinScreen> {
  TextEditingController tecSeach = TextEditingController();
  
  List<Product> productList = [
    Product(image: "assets/image/geprek.png", name: "Geprek Bensu Premium", price: 12000656000, amount: 1),
    Product(image: "assets/image/geprek.png", name: "Geprek", price: 12000, amount: 0),
    Product(image: "assets/image/kopi.png", name: "Kopi", price: 5000, amount: 0),
    Product(image: "assets/image/geprek.png", name: "Geprek Bensu", price: 120000, amount: 0),
    Product(image: "assets/image/kopi.png", name: "Kopi Premium", price: 5000000, amount: 0),
    Product(image: "assets/image/kapal-api.png", name: "Kopi Kapal Api", price: 5000, amount: 0),
  ];

  Store stores = Store(
      imageUrl: "https://images.unsplash.com/photo-1534723452862-4c874018d66d?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      name: "Kantin KAF",
      description: "Kantin KAF merupakan salah satu kantin yang ada di kawasan IT Telkom Purwokerto yang terletak di lobby DC bagian tengah",
      rate: 4.7,
      delivery: "Free",
      deliveryTime: 20,
    );

  List<String> kategori = [
    "Kopi", "Geprek", "Susu", "Es", "Kacang", "Indomie"
  ];

  String selectedKategori = "Kopi";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 70,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
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
        title: const TextSheet(
          text: "Kantin KAF",
          color: AppColors.yellow,
          fontWeight: FontWeight.w800,
          size: 17,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StoreItem(
                  imageUrl: stores.imageUrl,
                  name: stores.name,
                  kategori: stores.description,
                  rate: stores.rate,
                  delivery: stores.delivery,
                  deliveryTimeOnMinute: stores.deliveryTime
              ),
              const SizedBox(height: 15),
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
                      backgroundColor: kategori[index] == selectedKategori ? AppColors.maroon : null,
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
                text: "Kopi (10)",
                size: 20,
              ),
              const SizedBox(height: 10),
              GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 20,
                  childAspectRatio: 0.9,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: MediaQuery.of(context).size.width*0.1),
                          child: ClipPath(
                            clipper: CustomShapeClipper(cornerRadius: 20, topInsets: MediaQuery.of(context).size.height*0.01),
                            child: Container(
                              color: AppColors.yellow,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10,
                            left: 10,
                            right: 10,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Center(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width*0.25,
                                  height: MediaQuery.of(context).size.width*0.225,
                                  child: Image.asset(
                                    productList[index].image,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 24,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: TextSheet(
                                        text: productList[index].name,
                                        size: 18,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: TextSheet(
                                        text: "Rp ${productList[index].price.toCurrencyString(thousandSeparator: ThousandSeparator.Period, mantissaLength: 0)}",
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Visibility(
                                        visible: productList[index].amount > 0,
                                        child: Row(
                                          children: [
                                            SizedBox.square(
                                              dimension: 30,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  shape: const CircleBorder(),
                                                  padding: EdgeInsets.zero,
                                                  backgroundColor: AppColors.bgTextField,
                                                  foregroundColor: AppColors.maroon,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    if (productList[index].amount > 0) {
                                                      productList[index].amount--;
                                                    }
                                                  });
                                                },
                                                child: const Icon(IconaMoon.signMinus),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            TextSheet(
                                              text: productList[index].amount.toString(),
                                              size: 18,
                                              fontWeight: FontWeight.w700,
                                            ),
                                            const SizedBox(width: 10),
                                          ],
                                        ),
                                      ),
                                      SizedBox.square(
                                        dimension: 30,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            shape: const CircleBorder(),
                                            padding: EdgeInsets.zero,
                                            backgroundColor: AppColors.maroon,
                                            foregroundColor: Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              productList[index].amount++;
                                            });
                                          },
                                          child: const Icon(IconaMoon.signPlus),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Product {
  final String image;
  final String name;
  final int price;
  int amount;

  Product({required this.image, required this.name, required this.price, required this.amount});
}

class Store {
  final String imageUrl;
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