import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../utils/date.dart';
import "../widgets/custom_app_bar.dart";
import '../widgets/gallery_item.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset : true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('도움말',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            SizedBox(height: 50),
            Text("전국 꽃집 사장님들을 위한 애플리케이션, 로라는 “전국 꽃집 사장님들의 단 하나뿐인 고객 관리 플랫폼”입니다. 로라 앱을 통해 다양한 꽃집 맞춤 고객 관리 서비스를 만나보세요.\n\n\n오류 및 문의사항\nE-mail: laurakorea20@gmail.com",
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}