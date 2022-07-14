import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/pinterist_model.dart';
import '../pages/datail_page.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../pages/search_datail_page.dart';


class ScrolImage extends StatefulWidget {
  late PainterisOblect image;
  late String? search;
   ScrolImage({Key? key,required this.image,this.search}) : super(key: key);

  @override
  _ScrolImageState createState() => _ScrolImageState();
}

class _ScrolImageState extends State<ScrolImage> {
    @override
    Widget build(BuildContext context){
      return Column(
        children: [
          GestureDetector(
              onTap: () {
                if(widget.search==null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Detailpage(
                            oblect: widget.image,)));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>SearchDetailPage(
                            oblect: widget.image, text: widget.search!,)));
                }
              },
              child: ClipRRect(
                borderRadius:
                BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl:  widget.image.urls!.regular!,
                  placeholder: (context, url) =>
                      AspectRatio(
                          aspectRatio:  widget.image.width!/ widget.image.height!, //aspect ratio for Image
                          child:Container(
                            color: Colors.grey,
                          )
                      ),
                  errorWidget: (context, url,
                      error) =>
                  const  Icon(
                      Icons.access_alarms_sharp),
                  fit: BoxFit.cover,
                ),
              )),
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [

              Flexible(
                child: widget.image.description !=null?
                Text(
                  "${ widget.image.description}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black),
                ):SizedBox.shrink(),
              ),
              IconButton(onPressed: (){

              }, icon: Icon(Icons.more_horiz) )

            ],
          )
        ],
      );
    }
    Widget dropDownButton(
        List<String> list, String value, void Function(String?) function) {
      return Container(
        height: 35,
        color: Colors.white,
        alignment: Alignment.center,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            alignment: Alignment.center,
            borderRadius: BorderRadius.circular(10),
            isExpanded: true,
            hint: Text(value,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black)),
            style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w500),
            icon: const Icon(
              Icons.keyboard_arrow_down,
            ),
            iconSize: 24,
            onChanged: function,
            items: list.map((String tag) {
              return DropdownMenuItem<String>(
                value: tag,
                child: Text(
                  tag,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w500),
                ),
              );
            }).toList(),
          ),
        ),
      );
    }


  }

