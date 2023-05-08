import 'package:flutter/material.dart';

import '../../viewsUtil/view_util.dart';

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: shrinkOffset == expandedHeight ? 0 : 1,
          child: PageView(
            children: [
              firstView(),
              secondView(),
            ],
          ),
        ),
        Opacity(
          opacity: shrinkOffset / expandedHeight,
          child: Column(
            children: [
              Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 50, bottom: 30),
                    child: searchRow(context),
                  )),
            ],
          ),
        ),
        // ),
        Positioned(
          top: expandedHeight / 6 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 20,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: searchRow(context),
          ),
        ),
      ],
    );
  }

  Widget firstView() {
    return Stack(
      children: [
        Image.asset("assets/images/background006.png",
            width: double.infinity, fit: BoxFit.fill),
      ],
    );
  }

  Widget secondView() {
    return Stack(
      children: [
        Image.asset("assets/images/background005.png",
            width: double.infinity, fit: BoxFit.fill),
      ],
    );
  }

  final _controller = TextEditingController();
  Widget searchRow(BuildContext context) {
    return SizedBox(
      //height: 40,
      width: (MediaQuery.of(context).size.width) -
          MediaQuery.of(context).size.width / 10,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 8,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 40),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                    hintText: "Search.."),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: ViewUtil.supersetIcon(
                  const Icon(Icons.shopping_bag_outlined), "1")),
          Expanded(
              flex: 1,
              child: ViewUtil.supersetIcon(
                  const Icon(Icons.message_outlined), "9+"))
        ],
      ),
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
