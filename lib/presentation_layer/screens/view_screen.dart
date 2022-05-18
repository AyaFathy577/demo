import 'package:demo/data_layer/models/menu_model.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ViewScreen extends StatefulWidget {
  const ViewScreen({Key? key}) : super(key: key);

  @override
  State<ViewScreen> createState() => _ViewScreenState();
}

class _ViewScreenState extends State<ViewScreen>
    with SingleTickerProviderStateMixin {
  List<MenuModel> menuList = [
    MenuModel(id: 0, name: "name1", items: [
      "items0",
      "items1",
      "items2",
      "items0",
      "items1",
      "items2",
      "items0",
      "items1",
      "items2"
    ]),
    MenuModel(id: 1, name: "name2", items: ["items3", "items4"]),
    MenuModel(
        id: 2,
        name: "name3",
        items: ["items5", "items6", "items5", "items6", "items5", "items6"]),
    MenuModel(id: 3, name: "name4", items: ["items7", "items8"]),
    MenuModel(id: 4, name: "name5", items: ["items9", "items10", "items10"]),
    MenuModel(id: 5, name: "name6", items: ["items11", "items12"]),
  ];
  TabController? controller;
  final double? _appBarScrollExtent = 200;
  double? _appBarScrollLimit;
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollController _parentScrollController = ScrollController();
  ItemScrollController? itemScrollController = ItemScrollController();
  ScrollPhysics? _physics = const NeverScrollableScrollPhysics();

  @override
  void initState() {
    _appBarScrollLimit = _appBarScrollExtent! - 45;
    _parentScrollController.addListener(_onAppBarScroll);
    itemPositionsListener.itemPositions.addListener(onListScrolled);
    controller = TabController(length: menuList.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _parentScrollController.removeListener;
    itemPositionsListener.itemPositions.removeListener;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: menuList.length,
        child: CustomScrollView(
          controller: _parentScrollController,
          slivers: [
            SliverAppBar(
              toolbarHeight: _appBarScrollExtent ?? 10,
              floating: true,
              pinned: true,
              backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
              leadingWidth: 0,
              title: Column(
                children: [
                  Image.network(
                    "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                  ),
                  const Text(
                    "Data Of Restaurant",
                    style: TextStyle(fontSize: 30, color: Colors.red),
                  ),
                ],
              ),
              bottom: TabBar(
                controller: controller,
                isScrollable: true,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                labelPadding: EdgeInsets.zero,
                indicatorPadding: EdgeInsets.zero,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                indicator: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                // indicator: const UnderlineTabIndicator(
                //   borderSide: BorderSide(color: Colors.blue, width: 2),
                //   insets: EdgeInsets.symmetric(horizontal: 33),
                // ),
                onTap: (v) {
                  itemPositionsListener.itemPositions
                      .removeListener(onListScrolled);
                  itemScrollController!
                      .scrollTo(
                          index: v, duration: const Duration(milliseconds: 10))
                      .then((value) => Future.delayed(
                          const Duration(seconds: 1),
                          () => itemPositionsListener.itemPositions
                              .addListener(onListScrolled)));
                },
                tabs: menuList.map((e) {
                  return SizedBox(width: 90, child: Tab(text: e.name));
                }).toList(),
              ),
            ),
            SliverFillRemaining(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ScrollablePositionedList.builder(
                  itemScrollController: itemScrollController,
                  shrinkWrap: true,
                  physics: _physics,
                  itemCount: menuList.length,
                  itemPositionsListener: itemPositionsListener,
                  itemBuilder: (c, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 0, top: 10),
                          child: Text(menuList[index].name),
                        ),
                        ListView.builder(
                          itemCount: menuList[index].items.length,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index1) {
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      bottom: 8),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Image.network(
                                          "https://images.pexels.com/photos/302743/pexels-photo-302743.jpeg",
                                          width: 100,
                                        ),
                                      ),
                                      Text(menuList[index].items[index1]),
                                    ],
                                  ),
                                ),
                                index + 1 == menuList.length &&
                                        index1 + 1 ==
                                            menuList[index].items.length
                                    ? SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.45)
                                    : Container()
                              ],
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onListScrolled() {
    controller!
        .animateTo(itemPositionsListener.itemPositions.value.first.index);
  }

  void _onAppBarScroll() {
    debugPrint("_parentScrollController.offset : ${_parentScrollController.offset}");
    if (_parentScrollController.offset > _appBarScrollLimit!) {
      _physics = null;
      setState(() {});
    } else if (_parentScrollController.offset <= _appBarScrollLimit!) {
      _physics = const NeverScrollableScrollPhysics();
      setState(() {});
    }
  }
}
