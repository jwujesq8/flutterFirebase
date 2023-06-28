import 'package:lsm_project/domain/entities/quote.dart';
import 'package:lsm_project/domain/repositories/quote_repo.dart';

class GetFirstQuotesList {
  final QuoteRepository _repository;
  GetFirstQuotesList(this._repository);

  Future<List<Quote>> execute(String userId) async {
    return await _repository.getFirstQuotesList(userId);
  }
}