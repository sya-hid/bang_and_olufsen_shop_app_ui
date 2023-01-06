import 'package:beo_shop_ui/const.dart';
import 'package:beo_shop_ui/models/cart_model.dart';
import 'package:beo_shop_ui/providers/cart_provider.dart';
import 'package:beo_shop_ui/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BagPage extends StatefulWidget {
  const BagPage({super.key});

  @override
  State<BagPage> createState() => _BagPageState();
}

class _BagPageState extends State<BagPage> {
  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = BlocProvider.of<CartProvider>(context);
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
          'Bag',
          style: TextStyle(
              color: black, fontWeight: FontWeight.bold, fontSize: 28),
        ),
        centerTitle: true,
        backgroundColor: transparent,
        elevation: 0,
      ),
      body: BlocBuilder<CartProvider, List<CartModel>>(
        bloc: cartProvider,
        builder: (context, state) {
          return state.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Your Bag',
                            style: TextStyle(
                                color: black,
                                fontWeight: FontWeight.bold,
                                fontSize: 28),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${state.length} Items',
                            style: TextStyle(
                                color: black.withOpacity(0.3),
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          verticalDirection: VerticalDirection.up,
                          children: [
                            ...List.generate(
                                state.length,
                                (index) => Slidable(
                                      key: ValueKey(state[index].product.name),
                                      endActionPane: ActionPane(
                                          extentRatio: 0.3,
                                          motion: const ScrollMotion(),
                                          dismissible: DismissiblePane(
                                            onDismissed: () {
                                              cartProvider.removeCart(
                                                  state[index].product);
                                            },
                                          ),
                                          children: [
                                            SlidableAction(
                                              onPressed: (context) {
                                                cartProvider.removeCart(
                                                    state[index].product);
                                              },
                                              icon: Icons.close,
                                              foregroundColor: black,
                                              backgroundColor: yellow,
                                              label: 'Remove',
                                              borderRadius:
                                                  const BorderRadius.horizontal(
                                                      left:
                                                          Radius.circular(20)),
                                            )
                                          ]),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        child: CartItem(
                                          cart: state[index],
                                        ),
                                      ),
                                    ))
                          ],
                        ),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
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
                                  color: grey,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Total',
                                    style: TextStyle(
                                        color: black.withOpacity(0.2),
                                        fontSize: 14),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    '\$${cartProvider.getTotal().toStringAsFixed(2)}',
                                    style: const TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                        color: black),
                                  )
                                ],
                              ),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 60, vertical: 20),
                                  decoration: BoxDecoration(
                                      color: black,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: const Center(
                                    child: Text(
                                      'Checkout',
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
                )
              : const Center(
                  child: Text(
                    'Empty',
                    style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: 32),
                  ),
                );
        },
      ),
    );
  }
}
