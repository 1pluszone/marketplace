import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:market_place/resources/models/product.dart';
import 'package:market_place/resources/utils/util.dart';
import 'package:market_place/views/viewsUtil/custom_colors.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProductDetails extends StatefulWidget {
  final Product product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String? displayImageUrl;
  @override
  void initState() {
    super.initState();

    displayImageUrl = widget.product.imagesUrl?.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.backgroundAsh,
        appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_outlined),
              onPressed: () => Navigator.pop(context),
              color: CustomColors.ash,
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            actions: [
              IconButton(
                icon: widget.product.liked
                    ? const Icon(Icons.favorite, color: CustomColors.redColor)
                    : const Icon(Icons.favorite_outline_outlined,
                        color: CustomColors.lightColor),
                onPressed: () => setState(
                    () => widget.product.liked = !widget.product.liked),
              ),
              IconButton(
                  onPressed: () {},
                  icon:
                      const Icon(Icons.share_outlined, color: Colors.black38)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.shopping_bag_outlined,
                      color: Colors.black38))
            ]),
        bottomSheet: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
          child: Row(
            children: [
              Column(
                  mainAxisSize: MainAxisSize.min,
                  children: AnimationConfiguration.toStaggeredList(
                    childAnimationBuilder: (widget) => SlideAnimation(
                      duration: const Duration(milliseconds: 400),
                      verticalOffset: -50.0,
                      child: FadeInAnimation(
                        child: widget,
                      ),
                    ),
                    children: [
                      Text(
                        "Total Price",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Text(
                        widget.product.amount ?? '',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.merge(const TextStyle(color: CustomColors.green)),
                      )
                    ],
                  )),
              const Spacer(),
              Row(
                  children: AnimationConfiguration.toStaggeredList(
                childAnimationBuilder: (widget) => SlideAnimation(
                  duration: const Duration(milliseconds: 400),
                  verticalOffset: -50.0,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: [
                  Container(
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                          color: CustomColors.green,
                          borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(7))),
                      child: Row(
                        children: const [
                          Icon(Icons.shopping_bag_outlined,
                              color: Colors.white),
                          Text("1", style: TextStyle(color: Colors.white))
                        ],
                      )),
                  Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: const BoxDecoration(
                          color: CustomColors.darkPurple,
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(7))),
                      child: Row(
                        children: const [
                          Text(
                            "Buy Now",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )),
                ],
              )),
            ],
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 20),
            child: SingleChildScrollView(
                child: AnimationLimiter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: AnimationConfiguration.toStaggeredList(
                  duration: const Duration(milliseconds: 500),
                  childAnimationBuilder: (widget) => SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: widget,
                    ),
                  ),
                  children: [
                    Stack(
                      children: [
                        Image.asset(displayImageUrl!),
                        Positioned(
                            top: 10,
                            left: 10,
                            child: Column(
                              children: imageview(),
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        widget.product.brandName ?? '',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    Text(
                      widget.product.productName ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.merge(const TextStyle(fontSize: 20)),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: CustomColors.starGold),
                              Text(
                                  "${widget.product.rating?.averageRating} Ratings",
                                  style: Theme.of(context).textTheme.bodySmall),
                            ],
                          ),
                          dotContainer(),
                          Text(
                              "${Util.shortenNumber(widget.product.rating?.totalReviews ?? 0)}+ Reviews",
                              style: Theme.of(context).textTheme.bodySmall),
                          dotContainer(),
                          Text(
                              "${Util.shortenNumber(widget.product.totalSold ?? 0)}+ Sold",
                              style: Theme.of(context).textTheme.bodySmall)
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    aboutItem(),
                    descriptionSection(),
                    shippingSection(),
                    reviewsRatings(),
                    reivewWithImages(),
                    const SizedBox(height: 100)
                  ],
                ),
              ),
            )),
          ),
        ));
  }

  List<Widget> imageview() {
    return List.generate(
        widget.product.imagesUrl!.length,
        (index) => InkWell(
              onTap: () {
                displayImageUrl = widget.product.imagesUrl![index];
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.only(bottom: 10),
                height: 50,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Image.asset(widget.product.imagesUrl![index]),
              ),
            ));
  }

  Widget dotContainer() {
    return Container(
      height: 4,
      width: 4,
      decoration: BoxDecoration(
          color: Colors.black38, borderRadius: BorderRadius.circular(3)),
    );
  }

  int index = 0;
  Widget aboutItem() {
    return Column(
      children: [
        CustomSlidingSegmentedControl<int>(
          isStretch: true,
          innerPadding: EdgeInsets.zero,
          padding: 0,
          decoration: transparentBoxDecoration(),
          thumbDecoration: transparentBoxDecoration(),
          children: {
            1: Column(
              children: [
                Text("About Item", style: sectionStyle(1)),
                const Spacer(),
                AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    width: double.infinity,
                    height: 3,
                    color: index == 1 ? CustomColors.green : CustomColors.ash)
              ],
            ),
            2: Column(
              children: [
                Text("Reviews", style: sectionStyle(2)),
                const Spacer(),
                AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: double.infinity,
                    height: 3,
                    color: index == 2 ? CustomColors.green : CustomColors.ash),
              ],
            ),
          },
          //decoration: ,
          onValueChanged: (i) {
            setState(() {
              index = i;
            });
          },
        ),
        Row(
          children: [
            Expanded(
                child: brandColor("Brand:", widget.product.brandName ?? '')),
            Expanded(child: brandColor("Color", widget.product.color ?? ''))
          ],
        ),
      ],
    );
  }

  TextStyle sectionStyle(int currentIndex) {
    return TextStyle(
        color: index == currentIndex ? CustomColors.green : CustomColors.ash,
        fontWeight: FontWeight.bold);
  }

  BoxDecoration transparentBoxDecoration() =>
      const BoxDecoration(color: Colors.transparent);

  Widget brandColor(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Wrap(
        children: [
          Text("$title    ",
              style: const TextStyle(
                  color: CustomColors.ash,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          Text(value,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
        ],
      ),
    );
  }

  bool showMore = false;
  Widget descriptionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Description:", style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        Text(
            showMore
                ? widget.product.description!
                : "${widget.product.description!.substring(0, 80)}...",
            style: Theme.of(context).textTheme.bodyLarge),
        TextButton(
            onPressed: () {
              showMore = !showMore;
              setState(() {});
            },
            child: Text(showMore ? "see Less ^" : "See More v")),
        const Divider(),
      ],
    );
  }

  Widget shippingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 7),
        Text("Shippings Information:",
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        shippingSectionRows("Delivery:", widget.product.shippingInfo?.delivery),
        shippingSectionRows("Shipping:", widget.product.shippingInfo?.shipping),
        shippingSectionRows("Arrive:", widget.product.shippingInfo?.arrive),
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 20), child: Divider())
      ],
    );
  }

  Widget shippingSectionRows(String title, String? text) {
    return Column(
      children: [
        Row(
          children: [
            Text(title, style: Theme.of(context).textTheme.bodyLarge),
            Text("   $text",
                style: const TextStyle(fontWeight: FontWeight.bold))
          ],
        ),
        const SizedBox(height: 10)
      ],
    );
  }

  Widget reviewsRatings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Reviews & Ratings",
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.end,
                  children: [
                    Text(widget.product.rating!.averageRating.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.merge(const TextStyle(fontSize: 50))),
                    const Text("/5.0"),
                  ],
                ),
                RatingBarIndicator(
                  rating: widget.product.rating!.averageRating!,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemSize: 15,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                    "${Util.shortenNumber(widget.product.rating!.totalReviews!)}+ Reviews")
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                individualRowRating("5", widget.product.rating!.fiveStar!,
                    widget.product.rating!.totalReviews!),
                individualRowRating("4", widget.product.rating!.fourStar!,
                    widget.product.rating!.totalReviews!),
                individualRowRating("3", widget.product.rating!.threeStar!,
                    widget.product.rating!.totalReviews!),
                individualRowRating("2", widget.product.rating!.twoStar!,
                    widget.product.rating!.totalReviews!),
                individualRowRating("1", widget.product.rating!.oneStar!,
                    widget.product.rating!.totalReviews!),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget individualRowRating(String rateNumber, int rateValue, int totalRate) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        Text(rateNumber),
        LinearPercentIndicator(
          width: 140.0,
          lineHeight: 14.0,
          percent: rateValue / totalRate,
          backgroundColor: const Color(0xFFdbd3d3),
          progressColor: CustomColors.green,
          barRadius: const Radius.circular(12),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            Util.shortenNumber(rateValue),
            textAlign: TextAlign.right,
          ),
        )
      ],
    );
  }

  Widget reivewWithImages() {
    return Column(
      children: [
        Text("Reviews with images & videos",
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: imageview(),
        )
      ],
    );
  }
}
