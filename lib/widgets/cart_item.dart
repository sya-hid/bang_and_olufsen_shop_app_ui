import 'package:beo_shop_ui/const.dart';
import 'package:beo_shop_ui/models/cart_model.dart';
import 'package:beo_shop_ui/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItem extends StatelessWidget {
  final CartModel cart;
  const CartItem({
    Key? key,
    required this.cart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvider = BlocProvider.of<CartProvider>(context);
    return Row(children: [
      Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: grey,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Image.asset('assets/${cart.product.images[0]}'),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cart.product.name,
              maxLines: 1,
              style: const TextStyle(
                  color: black, fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 5),
            Text(
              '\$${cart.product.price}',
              style: TextStyle(
                  color: black.withOpacity(0.3),
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
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
            '${cart.quantity}',
            style: const TextStyle(
                color: black, fontWeight: FontWeight.bold, fontSize: 24),
          )
        ],
      ),
      const SizedBox(width: 10),
      Container(
        padding: const EdgeInsets.all(5),
        decoration:
            BoxDecoration(color: grey, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            GestureDetector(
                onTap: () {
                  cartProvider.reduceQuantity(cart.product);
                },
                child: const Icon(Icons.remove)),
            const SizedBox(height: 10),
            GestureDetector(
                onTap: () {
                  cartProvider.addQuantity(cart.product);
                },
                child: const Icon(Icons.add)),
          ],
        ),
      ),
    ]);
  }
}
