import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../model/pinterist_model.dart';
import '../service/network_service.dart';
import '../service/scroliameg_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static const r=15.0;
  String data="";
  TextEditingController _textEditingController=TextEditingController();
  late PainterisOblectList painterisOblectList;
  List<PainterisOblect>painterisOblects=[];
  int selectedIndex = 0;
  int _countLoadMore = 1;
  bool isLoad = true;
  bool loadMore = false;

  final ScrollController _scrollController = ScrollController();

  void loadData(String text) async {
    await NetworkService.GET(
        NetworkService.API_POST_SEARCH_LIST, NetworkService.paramsSearch(text,_countLoadMore))
        .then((value) {

      savaData(value);
    });
  }

  void savaData(response) {
    setState(() {
      print("Response: $response");
      painterisOblectList = NetworkService.parseSearchPost(response);
      isLoad = false;
      painterisOblects.addAll(painterisOblectList.painterisOblectList
          .map((object) => object)
          .toList());
      data = "full";
    });
   print(painterisOblects);
  }

  Future<void> _loadMore() async {
    setState(() {
      _countLoadMore +=1;
    });
    loadData(_textEditingController.text,);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
     body: Container(
       padding: EdgeInsets.only(right: 10,left: 10),
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
          SizedBox(height: 10,),
           forSearch(context),
           (_textEditingController.text.isEmpty)?
           buildGridView():
           Flexible(
             child: ListView(
               controller: _scrollController,
               shrinkWrap: true,
               children: [
                 MasonryGridView.count(
                   physics: NeverScrollableScrollPhysics(),
                   shrinkWrap: true,
                   crossAxisCount: 2,
                   mainAxisSpacing: 4,
                   crossAxisSpacing: 4,
                   itemCount: painterisOblects.length,
                   itemBuilder: (context, index) {
                     return ScrolImage(image:painterisOblects[index],search: _textEditingController.text,);
                   }, ),
               ],
             ),
           ),
         ],
       ),
     ),
      resizeToAvoidBottomInset: false,
    );

  }

  /// for Search
  Container forSearch(BuildContext context) {
    return Container(

           color: Colors.white,
           height: 60,
           alignment: Alignment.bottomCenter,
           width: MediaQuery.of(context).size.width,
           padding: EdgeInsets.only(bottom: 5,top: 20),

           child: TextField(
             onSubmitted: (text){

               setState(() {
                 data="";
                 painterisOblects.clear();
                // _textEditingController.clear();
               });
               loadData(text);
             },
             controller: _textEditingController,
             onTap: (){
               data="";
             },
             onChanged:(text){
               setState(() {
                 data=text;
                 painterisOblects.clear();
               });
             } ,
             textAlignVertical: TextAlignVertical.center,
             decoration: InputDecoration(
                 isCollapsed: true,
                 filled: true,
                 contentPadding: EdgeInsets.only(top: 5,bottom: 5),
                 fillColor: Colors.grey.shade400,

                 prefixIcon: Icon(CupertinoIcons.search,color: Colors.black,size: 30,),
                 hintText: "Search for ideas",
                 hintStyle: TextStyle(color: Colors.grey.shade600,fontSize: 18),
                 suffixIcon: Icon(CupertinoIcons.camera,color: Colors.black,size: 30,),
                 border: OutlineInputBorder(borderRadius: BorderRadius.circular(50),borderSide: BorderSide.none)
             ),
           ),
         );
  }
///  For no data
  Column buildGridView() {
    return Column(
      children: [
        SizedBox(height: 20,),
        Text("Ideas for you",style: TextStyle(color: Colors.black,fontSize: 18),),
        GridView.count(crossAxisCount: 2,childAspectRatio: 3/2,
                shrinkWrap: true,
               crossAxisSpacing: 5,
               mainAxisSpacing: 5,

               children: [
                 InkWell(
                   onTap: (){
                     _textEditingController.text="Favourite meals";
                     loadData(_textEditingController.text);
                   },
                   child: Container(

                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(r),
                         image: DecorationImage(
                             image: AssetImage("assets/images/food.jpg"),
                             fit:BoxFit.fitHeight,

                         )
                     ),
                     child: Container(
                       padding: EdgeInsets.only(bottom: 10),
                       alignment: Alignment.bottomCenter,
                       child: Text("Favourite meals",style: TextStyle(color: Colors.white,fontSize: 18),),
                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(r),
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,end: Alignment.topCenter,
                            colors: [
                              CupertinoColors.black.withOpacity(0.7),
                              Colors.black.withOpacity(0.3),
                              Colors.black.withOpacity(0.1),

                            ]
                          )
                       ),

                     ),
                   ),
                 ),
                 InkWell(

                   onTap: (){
                     _textEditingController.text="Baby cat";
                     loadData(_textEditingController.text);
                   },
                   child: Container(

                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(r),
                         image: DecorationImage(
                             image: AssetImage("assets/images/babyCat.jpg"),
                             fit:BoxFit.fitHeight
                         )
                     ),
                     child: Container(
                       padding: EdgeInsets.only(bottom: 10),
                       alignment: Alignment.bottomCenter,
                       child: Text("Baby cat",style: TextStyle(color: Colors.white,fontSize: 18),),

                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(r),
                           gradient: LinearGradient(
                               begin: Alignment.bottomCenter,end: Alignment.topCenter,
                               colors: [
                                 CupertinoColors.black.withOpacity(0.7),
                                 Colors.black.withOpacity(0.3),
                                 Colors.black.withOpacity(0.1),

                               ]
                           )
                       ),

                     ),
                   ),
                 ),
                 InkWell(

                   onTap: (){
                     _textEditingController.text="Marvel";
                     loadData(_textEditingController.text);
                   },
                   child: Container(

                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(r),
                         image: DecorationImage(
                             image: AssetImage("assets/images/marvel.jpg"),
                             fit:BoxFit.cover
                         )
                     ),
                     child: Container(
                       padding: EdgeInsets.only(bottom: 10),
                       alignment: Alignment.bottomCenter,
                       child: Text("marvel",style: TextStyle(color: Colors.white,fontSize: 18),),

                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(r),
                           gradient: LinearGradient(
                               begin: Alignment.bottomCenter,end: Alignment.topCenter,
                               colors: [
                                 CupertinoColors.black.withOpacity(0.7),
                                 Colors.black.withOpacity(0.3),
                                 Colors.black.withOpacity(0.1),

                               ]
                           )
                       ),

                     ),
                   ),
                 ),
                 Container(

                   decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(r),
                       image: DecorationImage(
                           image: AssetImage("assets/images/nature.jpg"),
                           fit:BoxFit.cover
                       )
                   ),
                   child: InkWell(
                     onTap: (){
                       _textEditingController.text="Nature";
                       loadData(_textEditingController.text);
                     },
                     child: Container(
                       padding: EdgeInsets.only(bottom: 10),
                       alignment: Alignment.bottomCenter,
                       child: Text("Nature",style: TextStyle(color: Colors.white,fontSize: 18),),
                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(r),
                           gradient: LinearGradient(
                               begin: Alignment.bottomCenter,end: Alignment.topCenter,
                               colors: [
                                 CupertinoColors.black.withOpacity(0.7),
                                 Colors.black.withOpacity(0.3),
                                 Colors.black.withOpacity(0.1),

                               ]
                           )
                       ),

                     ),
                   ),
                 ),

               ],
             ),
      ],
    );
  }

  /// Available data


}
