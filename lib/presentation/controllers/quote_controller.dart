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

  QuoteController({
    required this.getLoggedUser,
    required this.getExistingQuotesList
  });


  final RxList<Quote> _quotes = <Quote>[].obs;

  Future<AuthUser> getUser() async{
    var user = await getLoggedUser.execute();
    return user;
  }

  Future<List<Quote>> getExistingQuotes(String userId) async {
    if(userId.isNotEmpty){
      _quotes.value = await getExistingQuotesList.execute(userId);
      return _quotes.value;
    }
    return [];
  }

  @override
  void onInit() async {
    super.onInit();
    var userId = await getUser();
    _quotes.value = await getExistingQuotes(userId.email);
  }


}
