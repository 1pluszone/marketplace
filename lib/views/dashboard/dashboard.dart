import 'package:flutter/material.dart';
import 'package:market_place/views/dashboard/components/app_bar.dart';
import 'package:market_place/views/dashboard/product_widget.dart';
import 'package:market_place/viewModels/dashboard_view_model.dart';
import 'package:market_place/views/product_details.dart';
import 'package:market_place/views/viewsUtil/custom_colors.dart';
import 'package:stacked/stacked.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardAppBarState();
}

class _DashboardAppBarState extends State<Dashboard> {
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
                      const SizedBox(height: 15),
                      categoryWidget(),
                      const SizedBox(height: 10),
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
      onTap: () {},
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
    return Container(
      color: const Color(0xFFe2e1e1),
      child: Column(
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
          GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              //crossAxisCount: 2,
              //schildAspectRatio: .84,
              //children:
              //List.generate(
              // viewModel.products.length,
              //(index) =>
              itemCount: viewModel.products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  childAspectRatio: .665),
              itemBuilder: (context, index) => Ink(
                    child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetails(
                                    product: viewModel.products[index]))),
                        child: ProductWidget(
                            index: index, product: viewModel.products[index])),
                  )
              //),
              ),
        ],
        //  ),
      ),
    );
  }
}
