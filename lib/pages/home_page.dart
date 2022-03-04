import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_clone_project/pages/profel_page.dart';
import 'package:pinterest_clone_project/pages/search_page.dart';
import '../model/pinterist_model.dart';
import '../service/network_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../service/scroliameg_service.dart';
import 'datail_page.dart';
import 'message_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PainterisOblectList painterisOblectList;
  List<PainterisOblect> painterisOblects = [];
  String data = "";
  int selectedIndex = 0;
  int _countLoadMore = 1;
  int pageSelctedindex = 0;
  bool isLoad = true;
  bool loadMore = false;

  final ScrollController _scrollController = ScrollController();
  final PageController _pageController = PageController();

  void loadData() async {
    isLoad = true;
    await NetworkService.GET(
            NetworkService.API_POST_LIST, NetworkService.ImptyParams())
        .then((value) {
      savaData(value);
    });
  }

  void savaData(response) {
    setState(() {
      painterisOblectList = NetworkService.parseUserList(response);
      isLoad = false;
      painterisOblects.addAll(painterisOblectList.painterisOblectList
          .map((object) => object)
          .toList());
    });
    print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    print(painterisOblectList);
  }

  Future<void> _loadMore() async {
    await NetworkService.GET(NetworkService.API_POST_LIST,
            NetworkService.LoadMoreParams(_countLoadMore))
        .then((value) {
      savaData(value);
    });
    setState(() {
      loadMore = false;
      _countLoadMore = _countLoadMore + 1;
    });
    print(
        "============================================================================");
    print(loadMore);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          loadMore = true;
        });
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement  dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: WillPopScope(
        onWillPop: () async {
          if (pageSelctedindex != 0) {
            setState(() {
              pageSelctedindex = 0;
              _pageController.jumpToPage(pageSelctedindex);
            });
            return false;
          } else {
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else {
              exit(0);
            }
            return false;
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    height: 40,
                    width: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.black),
                    child: Text(
                      "All",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ),
                  Expanded(
                    child: isLoad
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView(
                            shrinkWrap: true,
                            controller: _scrollController,
                            children: [
                              MasonryGridView.count(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                mainAxisSpacing: 4,
                                crossAxisSpacing: 4,
                                itemCount: painterisOblects.length,
                                itemBuilder: (context, index) {
                                  return ScrolImage(
                                    image: painterisOblects[index],
                                  );
                                },
                              ),
                              loadMore
                                  ? const LinearProgressIndicator(
                                      backgroundColor: Colors.grey,
                                      color: Colors.black,
                                    )
                                  : SizedBox.shrink(),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                  ),
                ],
              ),
              SearchPage(),
              MessagePage(),
              profelPage()
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: (index){
      //     setState(() {
      //       pageSelctedindex=index;
      //     });
      //     _pageController.jumpToPage(pageSelctedindex);
      //   },
      //   elevation: 0,
      //   currentIndex: pageSelctedindex,
      //   showSelectedLabels: false,
      //   showUnselectedLabels: false,
      //   type: BottomNavigationBarType.fixed,
      //   backgroundColor: Colors.white,
      //   unselectedIconTheme: IconThemeData(color: Colors.grey.shade600, size: 25),
      //   selectedIconTheme: const IconThemeData(size: 35, color: Colors.black),
      //   items: const [
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           Icons.home_filled,
      //         ),
      //         label: ""),
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           CupertinoIcons.search,
      //         ),
      //         label: ""),
      //     BottomNavigationBarItem(
      //         icon: Icon(
      //           CupertinoIcons.chat_bubble_text_fill,
      //         ),
      //         label: ""),
      //     BottomNavigationBarItem(
      //         icon: CircleAvatar(
      //           radius: 15,
      //           backgroundColor: Colors.blue,
      //         ),
      //         label: ""),
      //   ],
      // ),
      bottomNavigationBar: Container(
        height: 50,
        margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: CupertinoColors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    pageSelctedindex = 0;
                  });
                  _pageController.jumpToPage(pageSelctedindex);
                },
                icon: Icon(
                  Icons.home_filled,
                )),
            IconButton(
              onPressed: () {
                setState(() {
                  pageSelctedindex = 1;
                });
                _pageController.jumpToPage(pageSelctedindex);
              },
              icon: Icon(
                CupertinoIcons.search,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  pageSelctedindex = 0;
                });
                _pageController.jumpToPage(pageSelctedindex);
              },
              icon: Icon(
                CupertinoIcons.chat_bubble_text_fill,
              ),
            ),

            CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.blue,
                ),
  ]

        ),
      ),
      extendBody: true,
    );
  }
}
