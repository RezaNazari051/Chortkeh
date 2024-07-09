import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

double getWidth(BuildContext context,double size){
  return MediaQuery.of(context).size.width * size;
}

extension SizeEtention on num{

  double width(){

    return ScreenUtil().screenWidth * this /100;
  }
  double height(BuildContext context){
    return  ScreenUtil().screenHeight * this /100;

  }

}