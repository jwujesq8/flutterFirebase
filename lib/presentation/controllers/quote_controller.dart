import 'package:get/get.dart';
import 'package:lsm_project/domain/entities/auth_user.dart';
import 'package:lsm_project/domain/usecases/get_existing_quotes_list.dart';
import 'package:lsm_project/domain/usecases/get_first_quotes_list.dart';
import 'package:lsm_project/domain/entities/book.dart';
import '../../domain/entities/quote.dart';
import '../../domain/usecases/get_logged_user.dart';

class QuoteController extends GetxController {
  GetLoggedUser getLoggedUser;
  GetExistingQuotesList getExistingQuotesList;
  GetFirstQuotesList getFirstQuotesList;

  QuoteController({
    required this.getLoggedUser,
    required this.getExistingQuotesList,
    required this.getFirstQuotesList
  });


  final RxList<Quote> _list = <Quote>[].obs;

  Future<List<Quote>> getStartQuotesList(String userId) async {
    if(userId.isNotEmpty){
      _list.value = await getFirstQuotesList.execute(userId);
    }
    return [];
  }

  @override
  void onInit() async {
    super.onInit();
    var user = await getLoggedUser.execute();
    _list.value = await getStartQuotesList(user.email);
  }


  Future<List<Quote>> getQuotesList(String userId) async {
    if(userId.isNotEmpty){
      _list.value = await getExistingQuotesList.execute(userId);
      return _list.value;
    }
    return [];
  }


}
