import 'package:flutter/material.dart';
import 'package:market_place/views/viewsUtil/custom_colors.dart';

import '../resources/models/product.dart';

class ProductWidget extends StatefulWidget {
  final Product product;
  const ProductWidget({super.key, required this.product});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Center(
          child: Card(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        widget.product.imagesUrl!.first,
                        height: 120,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 12, bottom: 8, left: 12),
                      child: Text(
                        widget.product.productType ?? '',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12, bottom: 12),
                      child: Text(widget.product.productName ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 17),
                        Text(
                          widget.product.rating?.averageRating.toString() ?? '',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          " | ",
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          widget.product.rating?.totalReviews.toString() ?? '',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            widget.product.amount ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.merge(
                                    const TextStyle(color: Color(0xFF399F86))),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Positioned(
                    right: 5,
                    child: IconButton(
                      icon: widget.product.liked
                          ? const Icon(Icons.favorite,
                              color: CustomColors.redColor)
                          : const Icon(Icons.favorite_outline_outlined,
                              color: CustomColors.lightColor),
                      onPressed: () => setState(
                          () => widget.product.liked = !widget.product.liked),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
