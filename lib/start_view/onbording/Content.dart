class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: "مرحبا    ",
      image: 'images/quality.png',
      discription: " نحن مـنصـة الكــترونيـة متخــــصصــة في مــجــــال فحــص "
          " الســيـارات المـستعـملة قـــبـل الشــراء وفـــق  مـعـايـــــيـر "
          " عـــالــــمـــيـــة و أنـــظـــــمـــة تـــكـــــنــــولـــوجــــــيـــة"),
  UnbordingContent(
      title: 'التذكير لمواعيد الفحص',
      image: 'images/delevery.png',
      discription:
          " فاحص للتذكير هو تطبيق تابع لمنصة فاحص لمساعدة المستخدم في تذكر  "
          "مواعيد فحص المركبات عبر ارسال اشعارات للمستخدم قبل موعد الفحص "),
  UnbordingContent(
      title: 'سجل الدخول',
      image: 'images/reward.png',
      discription: "  سجل الدخول الان لنبدأ تذكيرك بمواعيدك "),
];
