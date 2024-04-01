class Message {
  late final String name;
  late final String successTitle;
  late final String successComment;
  late final String failTitle;
  late final String failComment;

  Message({
    required this.name,
    required this.successTitle,
    required this.successComment,
    required this.failTitle,
    required this.failComment,
  });
}

class ResultMessages {
  static final Map<String, Message> _messages = {
    'contact': Message(
      name: '문의하기',
      successTitle: '접수 완료',
      successComment: '문의에 대한 답변은 작성하신 메일에서 안내해드리도록 하겠습니다.',
      failTitle: '',
      failComment: '',
    ),
    'bossVerification': Message(
      name: '사장님 인증',
      successTitle: '사장님 인증 완료!',
      successComment: '지금 바로 점포 등록 후 소콘을 발행하실 수 있습니다',
      failTitle: '인증에 실패했어요...',
      failComment: '다시 시도해주세요',
    ),
    'storeRegister': Message(
      name: '내점포 등록',
      successTitle: '점포 등록 완료!',
      successComment: '점포 관리로 이동 후\n소콘을 발행하실 수 있습니다',
      failTitle: '',
      failComment: '',
    ),
  };

  static Message getMessage(String key) {
    return _messages[key]!;
  }
}


