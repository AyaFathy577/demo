// import 'package:flutter/material.dart';
// import 'package:provider/src/provider.dart';
// import 'package:wave/constants/app_colors.dart';
// import 'package:wave/constants/app_fonts.dart';
// import 'package:wave/constants/app_images.dart';
// import 'package:wave/constants/enums.dart';
// import 'package:wave/models/item.dart';
// import 'package:wave/models/response_wrapper.dart';
// import 'package:wave/models/tags.dart';
// import 'package:wave/models/top_offers.dart';
// import 'package:wave/parents/base_state.dart';
// import 'package:wave/providers/services/stores_details_provider.dart';
// import 'package:wave/repos/local/shared_pref_manager.dart';
// import 'package:wave/repos/remote/servicer_manager.dart';
// import 'package:wave/widgets/components/bottom_actions.dart';
// import 'package:wave/widgets/components/custom_app_bar.dart';
// import 'package:wave/widgets/components/item_view.dart';
// import 'package:wave/widgets/components/localized_text.dart';
// import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
// import 'package:wave/widgets/components/store_details_without_items.dart';
// import 'package:wave/widgets/components/store_main_details.dart';
// import 'package:wave/utils/extension.dart';
//
// class StoresDetailsScreen extends StatefulWidget {
//   static const String routeName = '/stores-details';
//
//   const StoresDetailsScreen({Key? key}) : super(key: key);
//
//   @override
//   _StoresDetailsScreenState createState() => _StoresDetailsScreenState();
// }
//
// class _StoresDetailsScreenState
//     extends BaseState<StoresDetailsScreen, StoresDetailsProvider>
//     with SingleTickerProviderStateMixin {
//   TopOffers? currentStore;
//   TabController? controller;
//   ScrollController? scrollController;
//   final ScrollController _parentScrollController = ScrollController();
//   final ScrollController _scrollController = ScrollController();
//   bool _appBarContentVisible = false;
//   static double? APPBAR_SCROLL_EXTENT;
//   static double? APPBAR_SCROLL_LIMIT;
//   StoresDetailsProvider? provider;
//   ItemScrollController? itemScrollController;
//   bool items = true;
//   final ItemPositionsListener itemPositionsListener =
//       ItemPositionsListener.create();
//   ScrollPhysics? physics = NeverScrollableScrollPhysics();
//   List<Tags>? myList;
//
//   @override
//   void initState() {
//     super.initState();
//     provider = context.read<StoresDetailsProvider>();
//     APPBAR_SCROLL_EXTENT = 600;
//     APPBAR_SCROLL_LIMIT = APPBAR_SCROLL_EXTENT! - 45;
//     _parentScrollController.addListener(_onAppBarScroll);
//     _scrollController.addListener(_onPageScroll);
//     itemPositionsListener.itemPositions.addListener(onListScrolled);
//     scrollController = ScrollController();
//     itemScrollController = ItemScrollController();
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _parentScrollController.removeListener;
//     _scrollController.removeListener;
//     itemPositionsListener.itemPositions.removeListener;
//   }
//
//   void onListScrolled() {
//     controller!
//         .animateTo(itemPositionsListener.itemPositions.value.first.index);
//   }
//
//   void _onAppBarScroll() {
//     if (_parentScrollController.offset > APPBAR_SCROLL_LIMIT! &&
//         !_appBarContentVisible) {
//       physics = null;
//
//       setState(() => _appBarContentVisible = true);
//     } else if (_parentScrollController.offset <= APPBAR_SCROLL_LIMIT! &&
//         _appBarContentVisible) {
//       physics = const NeverScrollableScrollPhysics();
//       setState(() => _appBarContentVisible = false);
//     }
//   }
//
//   void _onPageScroll() {
//     if (_scrollController.offset > 5 && !_appBarContentVisible) {
//       physics = null;
//       setState(() => _appBarContentVisible = true);
//     } else if (_scrollController.offset <= 0 && _appBarContentVisible) {
//       physics = const NeverScrollableScrollPhysics();
//       setState(() => _appBarContentVisible = false);
//     }
//   }
//
//   bool get canPageScroll =>
//       _appBarContentVisible &&
//       _scrollController.hasClients &&
//       _scrollController.position.maxScrollExtent != 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FocusScope.of(context).unfocus();
//       },
//       child: Scaffold(
//           appBar: items
//               ? _appBarContentVisible
//                   ? PreferredSize(
//                       preferredSize: const Size.fromHeight(kToolbarHeight),
//                       child: CustomAppBar(
//                         titleKey: provider?.storeName,
//                         titleStyle:
//                             AppFonts.bold(fontFamily: AppFonts.NeoSansPro)
//                                 .copyWith(
//                                     fontWeight: appBarTitleWeight,
//                                     color: appBarTitleColor,
//                                     fontSize: appBarTitleSize),
//                         color: Color.fromRGBO(255, 255, 255, 0),
//                         elevation: appBarElevation,
//                       ),
//                     )
//                   : null
//               : null,
//           body: FutureBuilder<ResponseWrapper>(
//               future: provider?.currentStore != null
//                   ? Future.value(
//                       ResponseWrapper.success(response: provider?.currentStore))
//                   : ServicesManager()
//                       .getStoreDetails(
//                           provider?.branchId ?? 1,
//                           SharedPreferencesManager.lat ?? '',
//                           SharedPreferencesManager.long ?? '')
//                       .then((value) {
//                       provider?.currentStore = value.unwrap();
//                       currentStore = value.unwrap<TopOffers>();
//                       if (currentStore?.store?.menus?.length == 0) {
//                         APPBAR_SCROLL_EXTENT = 400;
//                         APPBAR_SCROLL_LIMIT = APPBAR_SCROLL_EXTENT! - 45;
//                       }
//                       print(currentStore?.distance);
//                       myList = currentStore?.store?.tags;
//                       // myList.forEach((element) { })
//                       if (myList![0].items?.length == 0) {
//                         myList!.removeAt(0);
//                         if (myList![0].items?.length == 0) {
//                           myList!.removeAt(0);
//                         }
//                       } else if (myList![1].items?.length == 0) {
//                         myList!.removeAt(1);
//                       }
//                       controller =
//                           TabController(length: myList!.length, vsync: this);
//                       return value;
//                     }),
//               builder: (context, snapshot) {
//                 //  myList=currentStore!.tags;
//                 return snapshot.hasData
//                     ? myList?.length == 0
//                         ? StoreDetailsWithoutItems(currentStore: currentStore!)
//                         : Stack(children: [
//                             DefaultTabController(
//                               length: myList!.length,
//                               child: CustomScrollView(
//                                 controller: _parentScrollController,
//                                 slivers: [
//                                   SliverAppBar(
//                                     toolbarHeight: APPBAR_SCROLL_EXTENT ?? 10,
//                                     floating: true,
//                                     pinned: true,
//                                     backgroundColor:
//                                         const Color.fromRGBO(255, 255, 255, 1),
//                                     //     expandedHeight: APPBAR_SCROLL_EXTENT,
//                                     leadingWidth: 0,
//                                     title: StoreMainDetails(
//                                       currentStore: currentStore!,
//                                     ),
//                                     bottom: TabBar(
//                                       controller: controller,
//                                       isScrollable: true,
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 16),
//                                       labelPadding: EdgeInsets.zero,
//                                       indicatorPadding: EdgeInsets.zero,
//                                       labelColor: AppColors.accent,
//                                       unselectedLabelColor: AppColors.grey180,
//                                       labelStyle: AppFonts.semiBold(
//                                               fontFamily: AppFonts.NeoSansPro)
//                                           .copyWith(
//                                               fontSize: 12,
//                                               fontWeight: FontWeight.w500),
//                                       unselectedLabelStyle: AppFonts.regular(
//                                               fontFamily: AppFonts.NeoSansPro)
//                                           .copyWith(
//                                         fontSize: 12,
//                                       ),
//                                       indicator: UnderlineTabIndicator(
//                                         borderSide: BorderSide(
//                                             color: AppColors.primary, width: 2),
//                                         insets: const EdgeInsets.symmetric(
//                                             horizontal: 33),
//                                       ),
//                                       onTap: (v) {
//                                         itemPositionsListener.itemPositions
//                                           ..removeListener(onListScrolled);
//                                         itemScrollController!
//                                             .scrollTo(
//                                                 index: v,
//                                                 duration: const Duration(
//                                                     milliseconds: 10))
//                                             .then((value) => Future.delayed(
//                                                 Duration(seconds: 1),
//                                                 () => itemPositionsListener
//                                                     .itemPositions
//                                                     .addListener(
//                                                         onListScrolled)));
//
//                                         // print(v);
//                                       },
//                                       tabs: myList!.mapIndexed((e, i) {
//                                         return i == 0
//                                             ? Row(children: [
//                                                 Image.asset(AppImages.icMenu),
//                                                 SizedBox(
//                                                   width: 90,
//                                                   child: Tab(
//                                                     text: e.name,
//                                                   ),
//                                                 ),
//                                               ])
//                                             : SizedBox(
//                                                 width: 90,
//                                                 child: Tab(
//                                                   text: e.name,
//                                                 ),
//                                               );
//                                       }).toList(),
//                                     ),
//                                   ),
//                                   SliverFillRemaining(
//                                       child: Padding(
//                                     padding: EdgeInsets.only(
//                                       top: _appBarContentVisible ? 55 : 10,
//                                     ),
//                                     child: ScrollablePositionedList.builder(
//                                         itemScrollController:
//                                             itemScrollController,
//                                         //     shrinkWrap: true,
//                                         physics: physics,
//                                         itemCount: myList!.length,
//                                         itemPositionsListener:
//                                             itemPositionsListener,
//                                         itemBuilder: (c, index) {
//                                           Tags currentType = myList![index];
//                                           return Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: <Widget>[
//                                               Padding(
//                                                 padding: EdgeInsets.only(
//                                                     left: 16,
//                                                     right: 16,
//                                                     bottom:
//                                                         _appBarContentVisible
//                                                             ? 10
//                                                             : 0,
//                                                     top: _appBarContentVisible
//                                                         ? 0
//                                                         : 10),
//                                                 child: LocalizedText(
//                                                   currentType.name ?? '',
//                                                   style: AppFonts.semiBold(
//                                                           fontFamily: AppFonts
//                                                               .NeoSansPro)
//                                                       .copyWith(
//                                                           fontSize: 14,
//                                                           fontWeight:
//                                                               FontWeight.w500,
//                                                           color: AppColors
//                                                               .black43),
//                                                 ),
//                                               ),
//                                               SizedBox(
//                                                 height: _appBarContentVisible
//                                                     ? 10
//                                                     : 0,
//                                               ),
//                                               Padding(
//                                                 padding: EdgeInsets.only(
//                                                     bottom:
//                                                         _appBarContentVisible
//                                                             ? 10
//                                                             : 0),
//                                                 child: ListView.builder(
//                                                     itemCount: myList![index]
//                                                         .items!
//                                                         .length,
//                                                     // controller:
//                                                     //     _scrollController,
//                                                     physics:
//                                                         const NeverScrollableScrollPhysics(),
//                                                     shrinkWrap: true,
//                                                     itemBuilder:
//                                                         (BuildContext context,
//                                                             int index1) {
//                                                       Item currentItem =
//                                                           currentType
//                                                               .items![index1];
//                                                       return Column(children: [
//                                                         ItemView(
//                                                             mode: ItemViewMode
//                                                                 .STORE,
//                                                             branchId: provider
//                                                                     ?.branchId ??
//                                                                 1,
//                                                             currentItem:
//                                                                 currentItem),
//                                                         index + 1 ==
//                                                                     myList
//                                                                         ?.length &&
//                                                                 index1 + 1 ==
//                                                                     currentType
//                                                                         .items
//                                                                         ?.length
//                                                             ? SizedBox(
//                                                                 height: MediaQuery.of(
//                                                                             context)
//                                                                         .size
//                                                                         .height *
//                                                                     0.45,
//                                                               )
//                                                             : SizedBox()
//                                                       ]);
//                                                     }),
//                                               ),
//                                             ],
//                                           );
//                                         }),
//                                   ))
//                                 ],
//                               ),
//                             ),
//                             const BottomAction()
//                           ])
//                     : const Center(child: CircularProgressIndicator());
//               })),
//     );
//   }
// }
