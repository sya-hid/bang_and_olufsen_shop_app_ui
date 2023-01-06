import 'package:beo_shop_ui/const.dart';
import 'package:beo_shop_ui/models/cart_model.dart';
import 'package:beo_shop_ui/models/product_model.dart';
import 'package:beo_shop_ui/pages/bag_page.dart';
import 'package:beo_shop_ui/providers/cart_provider.dart';
import 'package:beo_shop_ui/providers/fav_provider.dart';
import 'package:drop_shadow/drop_shadow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatefulWidget {
  final ProductModel product;
  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int selectedImage = 0;
  int? selectedColor;
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = BlocProvider.of<CartProvider>(context);
    FavoriteProvider favoriteProvider =
        BlocProvider.of<FavoriteProvider>(context);
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_rounded,
            color: black,
          ),
        ),
        title: const Text(
          'Details',
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
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Hero(
                  tag: widget.product.name,
                  child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.8,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: grey, shape: BoxShape.circle),
                      child: DropShadow(
                          blurRadius: 2,
                          offset: const Offset(5, 5),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.asset(
                              'assets/${widget.product.images[selectedImage]}',
                              colorBlendMode: BlendMode.modulate,
                              color: selectedColor != null
                                  ? availableColors[selectedColor!]
                                  : white,
                            ),
                          ))),
                ),
                BlocBuilder<FavoriteProvider, List<ProductModel>>(
                  bloc: favoriteProvider,
                  builder: (context, state) {
                    return Positioned(
                      right: 20,
                      bottom: 20,
                      child: GestureDetector(
                          onTap: () {
                            favoriteProvider.favorite(widget.product);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: grey,
                            ),
                            child: Icon(
                                favoriteProvider.isFav(widget.product)
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                color: red),
                          )),
                    );
                  },
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...List.generate(
                  widget.product.images.length,
                  (index) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedImage = index;
                          });
                        },
                        child: Container(
                          margin: index == 0
                              ? const EdgeInsets.only()
                              : const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: grey,
                              borderRadius: BorderRadius.circular(10)),
                          height: 50,
                          width: 50,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.asset(
                                'assets/${widget.product.images[index]}'),
                          ),
                        ),
                      ))
            ],
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: black,
                                fontWeight: FontWeight.bold,
                                fontSize: 26),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '\$${widget.product.price}',
                            style: const TextStyle(
                                color: black,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        ...List.generate(
                            availableColors.length,
                            (index) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedColor = index;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    margin: index == 0
                                        ? const EdgeInsets.only()
                                        : const EdgeInsets.only(left: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                          color: index == selectedColor
                                              ? availableColors[index]
                                              : transparent),
                                    ),
                                    child: Container(
                                      height: 60,
                                      width: 30,
                                      decoration: BoxDecoration(
                                          color: availableColors[index],
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                    ),
                                  ),
                                ))
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'More compact. More powerful.',
                  style: TextStyle(
                      color: black, fontSize: 16, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          const Spacer(),
          Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  color: white,
                  boxShadow: [
                    BoxShadow(
                        color: black.withOpacity(0.15),
                        offset: Offset.zero,
                        blurRadius: 5,
                        spreadRadius: 5)
                  ]),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: grey, borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: [
                        GestureDetector(
                            onTap: () {
                              if (quantity > 1) {
                                setState(() {
                                  quantity--;
                                });
                              }
                            },
                            child: const Icon(Icons.remove)),
                        const SizedBox(height: 10),
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            child: const Icon(Icons.add)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Row(
                    children: [
                      Text('QTY',
                          style: TextStyle(
                              color: black.withOpacity(0.2),
                              fontSize: 22,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10),
                      Text(
                        '$quantity',
                        style: const TextStyle(
                            color: black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24),
                      )
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      cartProvider.addCart(widget.product, quantity);
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 20),
                        decoration: BoxDecoration(
                            color: black,
                            borderRadius: BorderRadius.circular(30)),
                        child: const Center(
                          child: Text(
                            'Add to Bag',
                            style: TextStyle(
                                color: white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
