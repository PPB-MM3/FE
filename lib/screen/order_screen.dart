import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconamoon/iconamoon.dart';
import 'package:telfood/clipper/custom_shape_clipper.dart';
import 'package:telfood/helper/app_colors.dart';
import 'package:telfood/helper/navigators.dart';
import 'package:telfood/screen/pesanan_screen.dart';
import 'package:telfood/widgets/store_item.dart';
import 'package:telfood/widgets/text_sheet.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> with TickerProviderStateMixin {
  late final TabController _tabController;
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
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      setState((){
        _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    _tabController.dispose();
  }

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
          text: "Orderan Saya",
          color: AppColors.yellow,
          fontWeight: FontWeight.w800,
          size: 17,
        ),
        bottom: TabBar(
            controller: _tabController,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
            indicatorColor: AppColors.maroon,
            indicatorWeight: 2,
            labelStyle: GoogleFonts.sen(
              color: AppColors.maroon,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
            unselectedLabelStyle: GoogleFonts.sen(
              color: AppColors.unselectLabel,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
            tabs: const [
              Tab(text: "Proses"),
              Tab(text: "Riwayat"),
            ]
        ),
      ),
      body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: [
            proses(),
            riwayat(),
          ]
      ),
    );
  }

  Widget proses() {
    return SafeArea(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextSheet(
                text: "Kantin KAF",
                fontWeight: FontWeight.w800,
                color: AppColors.yellow,
              ),
              const Divider(color: AppColors.maroon),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.2,
                    child: Image.asset(
                      "assets/image/geprek.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextSheet(
                                text: "Geprek KAF",
                                fontWeight: FontWeight.w700,
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 20),
                            TextSheet(
                              text: "#A1904",
                              color: AppColors.hint,
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.right,
                              decoration: TextDecoration.underline,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              TextSheet(
                                text: "Rp 30.000",
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(width: 10),
                              VerticalDivider(thickness: 1),
                              SizedBox(width: 10),
                              TextSheet(
                                text: "03 Pesanan",
                                size: 12,
                                color: AppColors.hint,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: FilledButton(
                          onPressed: () {
                            Navigators.push(context, PesananScreen());
                          },
                          style: FilledButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                            ),
                            backgroundColor: AppColors.maroon,
                            foregroundColor: Colors.white,
                          ),
                          child: const TextSheet(
                            text: "Lihat Detail",
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          )
                      ),
                    ),
                  ),
                  SizedBox(width: 40),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: OutlinedButton(
                          onPressed: () {

                          },
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            side: const BorderSide(
                                color: AppColors.maroon
                            ),
                            // backgroundColor: AppColors.maroon,
                            foregroundColor: AppColors.maroon,
                          ),
                          child: const TextSheet(
                            text: "Batalkan",
                            fontWeight: FontWeight.w700,
                            color: AppColors.maroon,
                          )
                      ),
                    ),
                  ),
                ],
              )
            ],
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 30),
      ),
    );
  }

  Widget riwayat() {
    return SafeArea(
      child: ListView.separated(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        itemCount: 3,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextSheet(
                text: "Kantin KAF",
                fontWeight: FontWeight.w800,
                color: AppColors.yellow,
              ),
              const Divider(color: AppColors.maroon),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.2,
                    child: Image.asset(
                      "assets/image/geprek.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextSheet(
                                text: "Geprek KAF",
                                fontWeight: FontWeight.w700,
                                textAlign: TextAlign.left,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(width: 20),
                            TextSheet(
                              text: "#A1904",
                              color: AppColors.hint,
                              fontWeight: FontWeight.w400,
                              textAlign: TextAlign.right,
                              decoration: TextDecoration.underline,
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        IntrinsicHeight(
                          child: Row(
                            children: [
                              TextSheet(
                                text: "Rp 30.000",
                                fontWeight: FontWeight.w700,
                              ),
                              SizedBox(width: 10),
                              VerticalDivider(thickness: 1),
                              SizedBox(width: 10),
                              TextSheet(
                                text: "03 Pesanan",
                                size: 12,
                                color: AppColors.hint,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 40,
                child: FilledButton(
                    onPressed: () {

                    },
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)
                      ),
                      backgroundColor: AppColors.maroon,
                      foregroundColor: Colors.white,
                    ),
                    child: const TextSheet(
                      text: "Lihat Detail",
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    )
                ),
              )
            ],
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: 30),
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