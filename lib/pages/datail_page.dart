import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_clone_project/pages/search_page.dart';
import 'package:pinterest_clone_project/service/deep_link/link.dart';
import '../model/pinterist_model.dart';
import '../service/network_service.dart';
import '../service/scroliameg_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Detailpage extends StatefulWidget {
  PainterisOblect oblect;

  Detailpage({Key? key, required this.oblect}) : super(key: key);

  @override
  _DetailpageState createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  late PainterisOblectList painterisOblectList;
  List<PainterisOblect> painterisOblects = [];
  String data = "";
  int selectedIndex = 0;
  int _countLoadMore = 1;
  int pageSelctedindex = 0;
  bool isLoad = true;
  bool loadMore = false;
  final ScrollController _scrollController = ScrollController();

  void loadData() async {
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
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    print("=================================================================");
    print(painterisOblects.length);
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
    print("=================================================================");
    print(painterisOblects.length);
    //painterisOblects.clear();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      resizeToAvoidBottomInset: true,
      body: ListView(
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: widget.oblect.width! / widget.oblect.height!,
                child: Container(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.only(right: 5),
                  width: double.infinity,
                  //height: 400,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: AspectRatio(
                    aspectRatio: widget.oblect.width! / widget.oblect.height!,
                    child: CachedNetworkImage(
                      imageUrl: widget.oblect.urls!.regular!,
                      // placeholder:  (context, url) {return
                      //   Container(
                      //
                      //   );
                      // },
                    ),
                  ),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                    color: CupertinoColors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    )),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                              widget.oblect.user!.profileImage!.large!,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(widget.oblect.user!.name!),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(widget.oblect.likes.toString() +
                                  " followers"),
                            ],
                          ),
                          const Spacer(),
                          MaterialButton(
                            onPressed: () {},
                            shape: const StadiumBorder(),
                            child: const Text(
                              "Follow",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            color: Colors.grey.shade400,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    widget.oblect.description != null
                        ? Container(
                            color: CupertinoColors.white,
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Text(
                              widget.oblect.description!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20),
                            ),
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                CupertinoIcons.bubble_left_fill,
                                color: Colors.black,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                onPressed: () {},
                                shape: const StadiumBorder(),
                                child: const Text("View"),
                                color: Colors.grey.shade400,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              MaterialButton(
                                onPressed: () {},
                                shape: const StadiumBorder(),
                                child: const Text("Save"),
                                color: Colors.red,
                              ),
                            ],
                          ),

                          //Spacer(),
                          IconButton(
                              onPressed: () async {
                                print(widget.oblect.id.toString());
                                //String ok= LinkService.createShortLink("${widget.oblect.urls}").toString();
                                String deepLink =
                                    (await LinkService.createShortLink(
                                            widget.oblect.id.toString()))
                                        .toString();
                                await Clipboard.setData(
                                    ClipboardData(text: deepLink));
                                print("tugadi");
                              },
                              icon: Icon(
                                Icons.share,
                                color: Colors.black,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Comments",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text(
                      "Love this Pin? Let ",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    Text(
                      widget.oblect.user!.name!,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: const [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey,
                      child: Text(
                        "R",
                        style: TextStyle(
                            color: CupertinoColors.white, fontSize: 30),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Add a comment",
                            border: InputBorder.none),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: const BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                const Text(
                  "More Like this",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                MasonryGridView.count(
                  padding: EdgeInsets.only(top: 1, right: 10, left: 10),
                  physics: const NeverScrollableScrollPhysics(),
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
