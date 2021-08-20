import 'dart:math';

import'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class ProfileHeader implements SliverPersistentHeaderDelegate{
  ProfileHeader({
    this.minExtent,
    @required this.maxExtent,
  });
  final double minExtent;
  final double maxExtent;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent){
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.asset('Asset/Images/kick image 3.jpg',fit: BoxFit.cover),
        Container(
          color: Colors.white,
          child: Row(children: <Widget>[
            Expanded(child: Container(child: Center(child: Icon(Icons.grid_on, color: Theme.of(context).primaryColor,))),),
            Expanded(child: Container(child: Center(child: Icon(Icons.list, color: Theme.of(context).primaryColor,)),))
          ],),
        ),
      ],
    ); 
    
  }
  double titleOpacity(double shrinkOffset){
    return 1.0 - max(0.0, shrinkOffset) / maxExtent;
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate){
    return true;
  }

  @override 
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null; 
} 


