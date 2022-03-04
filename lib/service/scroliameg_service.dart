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
              Icon(Icons.more_horiz)
            ],
          )
        ],
      );
    }
  }

