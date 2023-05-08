import 'package:flutter/material.dart';
import 'package:market_place/dashboard/product_widget.dart';
import 'package:market_place/viewModels/dashboard_view_model.dart';
import 'package:market_place/views/product_details.dart';
import 'package:market_place/views/viewsUtil/custom_colors.dart';
import 'package:stacked/stacked.dart';

import 'dashboard.dart';

class SliverPersistentAppBar extends StatefulWidget {
  const SliverPersistentAppBar({Key? key}) : super(key: key);

  @override
  State<SliverPersistentAppBar> createState() => _SliverPersistentAppBarState();
}

class _SliverPersistentAppBarState extends State<SliverPersistentAppBar> {
  int _selectedIndex = 0;

  static const List<BottomNavigationBarItem> _widgetOptions =
      <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.padding),
      label: 'Voucer',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.wallet),
      label: 'Wallet',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late DashboardViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DashboardViewModel>.reactive(
        viewModelBuilder: () => DashboardViewModel(),
        onViewModelReady: (viewModel) {
          this.viewModel = viewModel;
          viewModel.init();
        },
        builder: (context, _, __) {
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              items: _widgetOptions,
              currentIndex: _selectedIndex,
              selectedItemColor: CustomColors.green,
              unselectedItemColor: Colors.black26,
              showUnselectedLabels: true,
              onTap: _onItemTapped,
            ),
            body: Material(
              child: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: MySliverAppBar(expandedHeight: 300.0),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      categoryWidget(),
                      productListGrid(),
                    ]),
                  )
                ],
              ),
            ),
          );
        });
  }

  int currentCategoryIndex = 0;
  final _categoryPagecontroller = PageController();
  Widget categoryWidget() {
    return Column(
      children: [
        SizedBox(
          height: 70,
          child: PageView(
            controller: _categoryPagecontroller,
            onPageChanged: (value) =>
                setState(() => currentCategoryIndex = value),
            children: [
              sampleCategory(),
              sampleCategory(),
              sampleCategory(),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(3, (index) => buildDot(index: index)),
          ),
        )
      ],
    );
  }

  Row sampleCategory() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        individualCategory(const Icon(Icons.category_outlined), "Category"),
        individualCategory(const Icon(Icons.flight_outlined), "Flight"),
        individualCategory(const Icon(Icons.note_outlined), "Bill"),
        individualCategory(const Icon(Icons.map_outlined), "Data plan"),
        individualCategory(const Icon(Icons.money_outlined), "Top Up"),
      ],
    );
  }

  Widget buildDot({int? index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(left: 5),
      height: 4,
      width: currentCategoryIndex == index ? 12 : 4,
      decoration: BoxDecoration(
          color: currentCategoryIndex == index ? Colors.black : Colors.black38,
          borderRadius: BorderRadius.circular(3)),
    );
  }

  Widget individualCategory(Icon icon, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Dashboard()));
      }, //TODO: add coming soon snackbar
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Color(0xFFdcddde),
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: icon,
        ),
        const SizedBox(height: 10),
        Text(title, style: Theme.of(context).textTheme.bodyLarge)
      ]),
    );
  }

  Widget productListGrid() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text("Best Sale Product",
                  style: Theme.of(context).textTheme.titleMedium),
              const Spacer(),
              TextButton(
                child: const Text("See more"),
                onPressed: () {},
              )
            ],
          ),
        ),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          children: List.generate(
              viewModel.products.length,
              (index) => Ink(
                    child: InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                    product: viewModel.products[index]))),
                        child: Ink(
                            child: ProductWidget(
                                product: viewModel.products[index]))),
                  )),
        ),
      ],
      //  ),
    );
  }
}

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
        // Container(
        //   color: shrinkOffset != expandedHeight
        //       ? Colors.transparent
        //       : Colors.white,
        //child:
        Opacity(
          opacity: shrinkOffset / expandedHeight,
          child: Column(
            children: [
              Container(
                  width: double.infinity,
                  //height: 100,
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
        Image.asset("assets/images/background003.png",
            width: double.infinity, fit: BoxFit.fill),
      ],
    );
  }

  Widget secondView() {
    return Stack(
      children: [
        Image.asset("assets/images/background004.png",
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
          const Expanded(flex: 1, child: Icon(Icons.shopping_bag)),
          const Expanded(flex: 1, child: Icon(Icons.message))
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
