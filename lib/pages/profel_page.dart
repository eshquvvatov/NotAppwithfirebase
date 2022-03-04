import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class profelPage extends StatefulWidget {
  const profelPage({Key? key}) : super(key: key);

  @override
  _profelPageState createState() => _profelPageState();
}

class _profelPageState extends State<profelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Icon(Icons.share, color: Colors.black,size: 30,),
          SizedBox(width: 20,),
          Icon(Icons.more_horiz_rounded, color: Colors.black,size: 30,),
          SizedBox(width: 10,),
        ],
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.deepPurpleAccent,
                child: Text("R",style: TextStyle(fontSize: 70),),
              ),
              SizedBox(height: 10,),
              Text("Ravshanbek",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text("Eshquvvatov",style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text("ravshanbekeshquvvatov@gmail.com",style: TextStyle(fontSize: 16,color: Colors.grey.shade600),),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("0 ",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                  Text("followrs ",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                  Text("0 ",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                  Text("following ",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
                ],
              ),


            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              Expanded(
                child: TextField(

                  decoration:InputDecoration(

                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none
                    ) ,
                    contentPadding: EdgeInsets.only(top: 5,bottom: 5),
                     isCollapsed: false,
                     fillColor: Colors.grey.shade200,
                     filled: true,
                     prefixIcon: Icon(CupertinoIcons.search,color: Colors.grey,),
                    hintText: "Text"
                  ),

                ),
              ),
              IconButton(onPressed: (){}, icon:Icon(Icons.add,size: 40,color: Colors.black,))
            ],
          )
          ,
        ],
      ),
    );
  }


}