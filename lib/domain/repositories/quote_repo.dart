import 'package:lsm_project/domain/entities/quote.dart';

abstract class QuoteRepository {

  Future<List<Quote>> getFirstQuotesList(String userId);

  Future<List<Quote>> getExistingQuotesList(String userId);

}
