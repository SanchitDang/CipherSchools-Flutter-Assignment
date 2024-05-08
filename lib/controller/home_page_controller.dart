import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePageController extends GetxController {
  RxString selectedMonth = 'January'.obs;
  RxString selectedFilter = 'today'.obs;
  RxDouble accBalance = 12000.0.obs;
  RxDouble accIncome = 0.0.obs;
  RxDouble accExpense = 0.0.obs;

  void changeAccBalance(double bal){
    accBalance.value = bal;
  }

  void changeAccIncome(double inc){
    accIncome.value = inc;
  }

  void changeAccExpense(double exp){
    accExpense.value = exp;
  }

  void changeMonth(String month){
    selectedMonth.value = month;
  }

  void changeFilter(String filter){
    selectedFilter.value = filter;
    update();
  }

  void setData() async {
    selectedMonth.value = DateFormat('MMMM').format(DateTime.now());
  }

  @override
  void onInit() {
    super.onInit();
    setData();
  }

}