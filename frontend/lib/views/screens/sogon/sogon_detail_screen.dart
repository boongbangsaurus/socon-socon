import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socon/utils/colors.dart';
import 'package:socon/utils/fontSizes.dart';
import 'package:socon/viewmodels/sogon_view_model.dart';
import 'package:socon/views/modules/app_bar.dart';
import 'package:socon/views/modules/socon_mysocon.dart';

class SogonDetailScreen extends StatefulWidget {
  final String sogon_id;

  const SogonDetailScreen(this.sogon_id, {Key? key}) : super(key: key);

  @override
  State<SogonDetailScreen> createState() => _SogonDetailScreenState();
}

class _SogonDetailScreenState extends State<SogonDetailScreen> {
  late final nickname;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<SogonViewModel>(context, listen: false)
        .getSogonDetail(widget.sogon_id));
    loadUserNickname();
  }

  Future<String?> getUserNickname() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userNickname');
  }

  void loadUserNickname() async {
    nickname = await getUserNickname();
  }

  String calculateTimeDifference(DateTime createdAt) {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays >= 1) {
      return '${difference.inDays}일 전';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours}시간 전';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes}분 전';
    } else {
      return '방금 전';
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController _commentController = TextEditingController();
    return Scaffold(
      appBar: CustomAppBarWithArrow(
        title: '소곤',
      ),
      body: SingleChildScrollView(child: Consumer<SogonViewModel>(
        builder: (context, model, child) {
          if (model.sogonDetail == null) {
            return CircularProgressIndicator();
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Text(model.sogonDetail!.member_name),
                        Text(' * '),
                        Text(calculateTimeDifference(
                            model.sogonDetail!.create_at))
                      ]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            model.sogonDetail!.title,
                            style: const TextStyle(
                                fontSize: FontSizes.XLARGE,
                                fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Dialog(
                                      // 모달 테두리 설정
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                        side: BorderSide(
                                            color: Colors.yellow,
                                            width: 2), // 노란색 테두리
                                      ),
                                      child: Container(
                                        width: 300, // 모달의 너비
                                        height: 300, // 모달의 높이
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          // 컨텐츠 크기에 맞게 조절
                                          children: <Widget>[
                                            Expanded(
                                              // 이미지가 Container를 꽉 채우도록 설정
                                              child: Image.network(
                                                'https://firebasestorage.googleapis.com/v0/b/socon-socon.appspot.com/o/images%2Fsocon%2Fgimbap.png?alt=media&token=89ee3277-cf77-4e9d-b02e-8eb80996e965',
                                                fit: BoxFit
                                                    .cover, // 이미지가 컨테이너를 꽉 채우도록 설정
                                              ),
                                            ),
                                            // 닫기 버튼
                                            TextButton(
                                              child: Text('닫기'),
                                              onPressed: () {
                                                Navigator.of(context)
                                                    .pop(); // 모달 닫기
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Text('소콘'),
                              style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: Size(50, 30),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  backgroundColor: AppColors.YELLOW,
                                  foregroundColor: AppColors.WHITE)),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(model.sogonDetail!.content),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                const Divider(
                  color: AppColors.GRAY300, // 선의 색상
                  thickness: 1, // 선의 굵기
                ),
                ...model.comments!.map((comment) => Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 0, bottom: 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    comment.member_name,
                                    style: const TextStyle(
                                        fontSize: FontSizes.XXSMALL,
                                        color: AppColors.GRAY400),
                                  ),
                                  Text(comment.content),
                                ],
                              ),
                              // 작성자 본인이고 아직 채택되지 않은 글이라면, 모든 사람에게 채택버튼이 존재한다.
                              // 채택 버튼을 누른경우 모달로 알림!
                              // 모든 사람은 채택된 소곤인 경우 채택 표시만 보인다.
                              (nickname == model.sogonDetail?.member_name &&
                                      !model.sogonDetail!.expired)
                                  ? TextButton(
                                      style: TextButton.styleFrom(
                                          foregroundColor: AppColors.BLACK),
                                      onPressed: () {
                                        final viewModel =
                                            Provider.of<SogonViewModel>(context,
                                                listen: false);
                                        viewModel.setPicked(widget.sogon_id,
                                            comment.id.toString());
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.check_circle_outline,
                                            size: 18,
                                          ),
                                          Text(' 채택'),
                                        ],
                                      ))
                                  : (model.sogonDetail!.expired &&
                                          comment.is_picked)
                                      ? TextButton(
                                          style: TextButton.styleFrom(
                                              foregroundColor: AppColors.BLACK,
                                              backgroundColor: AppColors.GREEN),
                                          onPressed: () {},
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.check_circle_outline,
                                                size: 18,
                                              ),
                                              Text(' 채택'),
                                            ],
                                          ))
                                      : SizedBox(
                                          width: 1,
                                        )
                            ],
                          ),
                        ),
                        const Divider(
                          color: AppColors.GRAY300, // 선의 색상
                          thickness: 1, // 선의 굵기
                        ),
                      ],
                    )),
                SizedBox(height: 60),
              ],
            );
          }
        },
      )),
      bottomSheet: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        color: Colors.white,
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _commentController,
                  decoration: InputDecoration(
                    hintText: "댓글을 입력하세요.",
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  if (_commentController.text.isNotEmpty) {
                    final viewModel =
                        Provider.of<SogonViewModel>(context, listen: false);
                    viewModel.commentRegister(
                        widget.sogon_id, _commentController.text);
                    _commentController.text = '';
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
