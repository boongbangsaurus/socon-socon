import 'package:flutter/material.dart';


class StoreDetailPage extends StatelessWidget {
  final int storeId;

  const StoreDetailPage({super.key, required this.storeId, });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
        extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Image.network(
            'https://cataas.com/cat',
            fit: BoxFit.cover,
            height: 200,
          ),

        ],
      )
    );
  }
}


class StoreDetail extends StatelessWidget {
  const StoreDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // 배경으로 들어갈 이미지
        Positioned(
          top: 25,
          left: 0,
          right: 0,
          child: Image.network(
            'https://cataas.com/cat',
            fit: BoxFit.cover,
            height: 200,
          ),
        ),
        // AppBar를 CustomScrollView와 SliverAppBar를 사용하여 구현
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 200.0, // 확장될 때의 최대 높이
              floating: false,
              pinned: true,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(), // SliverAppBar 밑으로 이미지가 보이도록 투명한 배경 설정
              ),
            ),
            // 실제 컨텐츠가 들어갈 부분
            SliverToBoxAdapter(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 200), // 이미지와 겹치지 않게 하기 위한 공간 조절
                  Text('여기에 본문 컨텐츠가 들어갑니다.'),
                  // 본문 컨텐츠 추가...
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

