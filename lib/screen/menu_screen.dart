import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconamoon/iconamoon.dart';
import 'package:telfood/clipper/custom_shape_clipper.dart';
import 'package:telfood/helper/app_colors.dart';
import 'package:telfood/helper/navigators.dart';
import 'package:telfood/screen/kantin_screen.dart';
import 'package:telfood/screen/order_screen.dart';
import 'package:telfood/screen/references_screen.dart';
import 'package:telfood/widgets/store_item.dart';
import 'package:telfood/widgets/text_sheet.dart';

class MenuScreen extends StatefulWidget {
  final String name;

  const MenuScreen({super.key, required this.name});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  TextEditingController tecSeach = TextEditingController();
  
  List<Product> productList = [
    Product(image: "assets/image/geprek.png", name: "Geprek Bensu Premium", price: 12000656000),
    Product(image: "assets/image/geprek.png", name: "Geprek", price: 12000),
    Product(image: "assets/image/kopi.png", name: "Kopi", price: 5000),
    Product(image: "assets/image/geprek.png", name: "Geprek Bensu", price: 120000),
    Product(image: "assets/image/kopi.png", name: "Kopi Premium", price: 5000000),
  ];

  List<Store> storeList = [
    Store(
      imageUrl: "https://images.unsplash.com/photo-1656185662919-fd0efa12b555?q=80&w=2041&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      name: "Fanatic Coffe",
      kategori: "Ayam Geprek - Seblak - Kopi",
      rate: 4,
      delivery: "Free",
      deliveryTime: 25,
    ),
    Store(
      imageUrl: "https://images.unsplash.com/photo-1591085686350-798c0f9faa7f?q=80&w=1931&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      name: "Baju Clothes",
      kategori: "Pakaian",
      rate: 4.8,
      delivery: "Free",
      deliveryTime: 30,
    ),
    Store(
      imageUrl: "https://images.unsplash.com/photo-1534723452862-4c874018d66d?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      name: "Supermarket",
      kategori: "Kebutuhan Pokok - Sabun - Elektronik",
      rate: 4.7,
      delivery: "Free",
      deliveryTime: 20,
    ),
  ];

  int cart = 3;

  String getGreeting() {
    int hour = DateTime.now().hour;
    if (hour < 12) {
      return "Selamat Pagi!";
    } else if (hour < 15) {
      return "Selamat Siang!";
    } else if (hour < 18) {
      return "Selamat Sore!";
    } else {
      return "Selamat Malam!";
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthProduct = MediaQuery.of(context).size.width*0.3;
    double heightProduct = MediaQuery.of(context).size.width*0.41;
    String greeting = getGreeting();

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

            },
            child: const Icon(IconaMoon.menuBurguerHorizontal),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TextSheet(
              text: "KIRIM KE",
              color: AppColors.maroon,
              fontWeight: FontWeight.w700,
              size: 12,
            ),
            InkWell(
              onTap: () {

              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TextSheet(
                    text: "Gedung DC 201",
                    size: 14,
                  ),
                  Icon(Icons.arrow_drop_down)
                ],
              ),
            )
          ],
        ),
        actions: [
          Stack(
            alignment: Alignment(0.3, -0.75),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(8),
                    backgroundColor: AppColors.maroon,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigators.push(context, OrderScreen());
                  },
                  child: const Icon(IconaMoon.shoppingBag),
                ),
              ),
              Visibility(
                visible: cart > 0,
                child: SizedBox.square(
                  dimension: 25,
                  child: Card(
                    margin: EdgeInsets.zero,
                    shape: CircleBorder(),
                    color: AppColors.yellow,
                    elevation: 0,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(2),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: TextSheet(
                            text: cart > 99 ? "99+" : cart.toString(),
                            fontWeight: FontWeight.w700,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: TextSpan(
                      style: GoogleFonts.sen(
                        fontWeight: FontWeight.w400,
                        color: AppColors.text,
                        fontSize: 16,
                      ),
                      children: [
                        TextSpan(text: "Hai ${widget.name}, "),  // Use widget.name here
                        TextSpan(
                          text: greeting,
                          style: GoogleFonts.sen(
                            fontWeight: FontWeight.w700,
                            color: AppColors.text,
                            fontSize: 16,
                          ),
                        ),
                      ]
                  )
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: tecSeach,
                keyboardType: TextInputType.text,
                style: GoogleFonts.sen(
                  fontSize: 14,
                  fontWeight: FontWeight.w400
                ),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFF6F6F6),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    hintText: "Cari minuman, kantin",
                    prefixIcon: Icon(IconaMoon.search)
                ),
              ),
              SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextSheet(
                    text: "Semua Kategori",
                    size: 20,
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {

                    },
                    child: Row(
                      children: [
                        TextSheet(
                          text: "Lihat Semua",
                          size: 16,
                        ),
                        Icon(IconaMoon.arrowRight2, color: AppColors.hint)
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: heightProduct,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigators.push(context, KantinScreen());
                      },
                      child: SizedBox(
                        height: heightProduct,
                        width: widthProduct,
                        child: Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.width*0.1),
                              child: ClipPath(
                                clipper: CustomShapeClipper(cornerRadius: 16, topInsets: (heightProduct)*0.025),
                                child: Container(
                                  color: AppColors.yellow,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              width: widthProduct,
                              child: Center(
                                child: SizedBox(
                                  height: widthProduct,
                                  width: widthProduct*0.8,
                                  child: Image.asset(
                                    productList[index].image,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              width: widthProduct,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  bottom: 10,
                                  left: 10,
                                  right: 10,
                                ),
                                child: Column(
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
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: TextSheet(
                                        text: "Rp ${productList[index].price.toCurrencyString(thousandSeparator: ThousandSeparator.Period, mantissaLength: 0)}",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => SizedBox(width: 20),
                ),
              ),
              SizedBox(height: 30),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextSheet(
                    text: "Pilihan Kantin",
                    size: 20,
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    onTap: () {

                    },
                    child: Row(
                      children: [
                        TextSheet(
                          text: "See All",
                          size: 16,
                        ),
                        Icon(IconaMoon.arrowRight2, color: AppColors.hint)
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: storeList.length,
                itemBuilder: (context, index) {
                  return StoreItem(
                    onTap: () {
                      Navigators.push(context, ReferencesScreen());
                    },
                    imageUrl: storeList[index].imageUrl,
                    name: storeList[index].name,
                    kategori: storeList[index].kategori,
                    rate: storeList[index].rate,
                    delivery: storeList[index].delivery,
                    deliveryTimeOnMinute: storeList[index].deliveryTime
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 30),
              )
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

  Product({required this.image, required this.name, required this.price});
}

class Store {
  final String imageUrl;
  final String name;
  final String kategori;
  final double rate;
  final String delivery;
  final int deliveryTime;

  Store({
    required this.imageUrl,
    required this.name,
    required this.kategori,
    required this.rate,
    required this.delivery,
    required this.deliveryTime,
  });
}
