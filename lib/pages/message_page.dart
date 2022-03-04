import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  int selecteindex=1;
  static const  r=15.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: EdgeInsets.only(left: 10,right: 10),
        child: Column(
          children: [
            SizedBox(height: 25,),
            Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(

                    onPressed: (){
                      setState(() {
                        selecteindex=0;
                      });
                    },shape: StadiumBorder(),
                    child: Text("Updates",style: TextStyle(color: selecteindex ==0?Colors.white:Colors.black),),
                    color: selecteindex==0?Colors.black:Colors.white,
                    height: 40,

                  ),
                  MaterialButton(
                    onPressed: (){
                      setState(() {
                        selecteindex=1;
                      });
                    },shape: StadiumBorder(),
                    child: Text("Updates",style: TextStyle(color: selecteindex ==1?Colors.white:Colors.black),),
                    color:selecteindex ==1 ?Colors.black:Colors.white,
                    height: 40,

                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(child:
                  Text("See what Kiki Smith and 7 other friends in Home decor,Food and drink ans 1 other topic",textAlign: TextAlign.start,style: TextStyle(color: Colors.black,fontSize: 16),
                  )
                  ),
                  Container(
                    //alignment: Alignment.,
                    child: Row(
                    children: [
                      Transform.translate(
                          offset: Offset(20,0),
                          child: CircleAvatar(radius: 25,backgroundColor: Colors.blueAccent,)
                      ),
                      Transform.translate(
                          offset: Offset(10,0),
                          child: CircleAvatar(radius: 25,backgroundColor: Colors.yellow,)
                      ),
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.grey.shade300,
                        child: Text("7",style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold,color: Colors.black),),
                      ),

                    ],
                  ),)
                ],
              ),
            ),

            Flexible(child:Container(

              child:ListView.builder(
                  itemCount: 50,
                itemBuilder: (BuildContext context, int index) {

                      if((index*29)%3==0) {
                        return Column(
                          children: [
                            SizedBox(height: 60,
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text("See what Kiki Smith and 7 other friends in Home decor,Food and drink ans 1 other topic",
                                      overflow: TextOverflow.ellipsis,maxLines: 2,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    height: 40,width: 40,
                                    decoration: BoxDecoration(color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            viewFour(),
                          ],
                        );
                      }
                      else if((index)%3==1) {
                        return Column(
                          children: [
                            SizedBox(height: 60,
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text("See what Kiki Smith and 7 other friends in Home decor,Food and drink ans 1 other topic",
                                      overflow: TextOverflow.ellipsis,maxLines: 2,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    height: 40,width: 40,
                                    decoration: BoxDecoration(color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            viewThree(),
                          ],
                        );
                      }
                      else {
                        return Column(
                          children: [
                            SizedBox(height: 60,
                              child: Row(
                                children: [
                                  Flexible(
                                    child: Text("See what Kiki Smith and 7 other friends in Home decor,Food and drink ans 1 other topic",
                                      overflow: TextOverflow.ellipsis,maxLines: 2,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    height: 40,width: 40,
                                    decoration: BoxDecoration(color: Colors.grey,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            vieeFive()
                          ],
                        );
                      }

                },

              )

            ) ,)
          ],
        ),
      )
    );

  }

  Widget viewThree(){
    return StaggeredGrid.count(
      crossAxisCount: 3,

      crossAxisSpacing: 2,
      children:  [
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.4,
          child:  Container(
            decoration: const BoxDecoration(color: Colors.red,
              borderRadius: BorderRadius.horizontal(left: Radius.circular(r )),
            ),

          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount:1.4,
          child:Container(
                  color: Colors.black,


          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount:1.4,
          child: Container(

            decoration: const BoxDecoration(color: Colors.yellow,
              borderRadius: BorderRadius.horizontal(right: Radius.circular(r)),
            ),

          ),
        ),

      ],
    );
  }
  Widget viewFour(){
    return Container(

      child: StaggeredGrid.count(
        crossAxisCount: 4,
        mainAxisSpacing: 2,
        crossAxisSpacing: 1,
        children:  [
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 1,
            child:  Container(
              decoration: const BoxDecoration(color: Colors.red,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(r))),

            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 1,
            child:Container(

              margin: EdgeInsets.only(left: 2),
              decoration: const BoxDecoration(color: Colors.red,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(r))),

            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
              mainAxisCellCount: 1,
            child: Container(

              decoration: const BoxDecoration(color: Colors.red,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(r))),

            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
    mainAxisCellCount: 1,
            child: Container(

              margin: EdgeInsets.only(left: 2),
              decoration: const BoxDecoration(color: Colors.red,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(r))),

            ),
          ),
        ],
      ),
    );
  }
  Widget vieeFive(){
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 2,
      crossAxisSpacing: 1,
      children:  [
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child:  Container(
            decoration: const BoxDecoration(color: Colors.red,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(r),bottomLeft:Radius.circular(r) )),

          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child:Container(
            color: Colors.red,
            margin: EdgeInsets.only(left: 2),


          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Container(

            decoration: const BoxDecoration(color: Colors.red,
                borderRadius: BorderRadius.only(topRight: Radius.circular(r))),

          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Container(
            color: Colors.blue,

          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: Container(
            decoration: const BoxDecoration(color: Colors.red,
                borderRadius: BorderRadius.only(bottomRight: Radius.circular(r))),

          ),
        ),
      ],
    );
  }
}
