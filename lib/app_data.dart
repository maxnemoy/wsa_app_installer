class AppData {
  final String name;
  final String iconPath;
  final String uploadPath;

  AppData(
      {required this.name, required this.iconPath, required this.uploadPath});
}

List<AppData> appList = [
  AppData(
      name: "Huawei App Gallary",
      iconPath: "assets/app_gallery.png",
      uploadPath:
          "https://appdl-11-drcn.dbankcdn.com/dl/appdl/application/apk/77/778c4ec7f8e644169084e92e4edb925b/com.huawei.appmarket.2109160959.apk?maple=0&trackId=0&distOpEntity=HWSW"),
  // AppData(
  //     name: "F-Droid",
  //     iconPath: "assets/fdroid.png",
  //     uploadPath:
  //         "https://f-droid.org/F-Droid.apk?ref=dtf.ru"),
  // AppData(
  //     name: "AuroraStore",
  //     iconPath: "assets/aurora.png",
  //     uploadPath:
  //         "https://drive.google.com/u/0/uc?export=download&confirm=Qhs1&id=1GqUlhyUbDVwpxTfZ6NLS7X9Ye2dsqriO"),
];