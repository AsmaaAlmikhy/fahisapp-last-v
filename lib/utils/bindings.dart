import 'package:get/get.dart';

// import '../controller/localization_controller.dart';
import '../controllers/add_data_controller.dart';

class GetXBindings extends Bindings {
  @override
  void dependencies() {
    // Get.put<MyLocaleController>(MyLocaleController());
    Get.put(AppDataController(), permanent: true);
  }
}
