import 'package:lsm_project/domain/entities/quote.dart';
import 'package:lsm_project/domain/repositories/quote_repo.dart';

class GetExistingQuotesList {
  final QuoteRepository _repository;
  GetExistingQuotesList(this._repository);

  Future<List<Quote>> execute(String userId) async {
    return await _repository.getExistingQuotesList(userId);
  }
}