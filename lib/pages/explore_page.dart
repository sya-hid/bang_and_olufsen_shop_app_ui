import 'package:beo_shop_ui/const.dart';
import 'package:beo_shop_ui/models/cart_model.dart';
import 'package:beo_shop_ui/models/product_model.dart';
import 'package:beo_shop_ui/pages/bag_page.dart';
import 'package:beo_shop_ui/pages/detail_page.dart';
import 'package:beo_shop_ui/providers/cart_provider.dart';
import 'package:beo_shop_ui/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = BlocProvider.of<CartProvider>(context);
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: const Text(
          'Explore',
          style: TextStyle(
              color: black, fontWeight: FontWeight.bold, fontSize: 28),
        ),
        centerTitle: true,
        backgroundColor: transparent,
        elevation: 0,
        actions: [
          BlocBuilder<CartProvider, List<CartModel>>(
            bloc: cartProvider,
            builder: (context, state) {
              return state.isNotEmpty
                  ? GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BagPage()));
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        decoration: const BoxDecoration(
                            color: yellow,
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(20))),
                        child: Row(
                          children: [
                            const Icon(Icons.shopping_bag_outlined,
                                color: black),
                            const SizedBox(width: 5),
                            Text('${state.length}',
                                style: const TextStyle(
                                    color: black, fontWeight: FontWeight.w600))
                          ],
                        ),
                      ),
                    )
                  : Container();
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Wrap(
            spacing: 20,
            children: [
              ...List.generate(
                  products.length,
                  (index) => Padding(
                        padding: EdgeInsets.only(top: index % 2 == 1 ? 50 : 10),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailPage(
                                          product: products[index])));
                            },
                            child: ProductItem(product: products[index])),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
