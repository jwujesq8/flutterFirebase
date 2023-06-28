import 'package:lsm_project/domain/entities/book.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lsm_project/data/models/book_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lsm_project/domain/entities/quote.dart';

import '../../domain/repositories/quote_repo.dart';
import '../data_sources/quotes_ds.dart';

class QuoteRepositoryImpl extends QuoteRepository {
  final QuoteDataSource _quoteDataSource;
  final GetStorage _storage = GetStorage();

  QuoteRepositoryImpl(this._quoteDataSource);

  @override
  Future<List<Quote>> getFirstQuotesList(String userId) async {
    var quotes = await _quoteDataSource.getQuotes(userId);
    print("QUOTES:");
    print(quotes);
    _storage.write('quotes_$userId', quotes);
    return quotes;
  }

  @override
  Future<List<Quote>> getExistingQuotesList(String userId) async {
    var quotes = _storage.read('quotes_$userId');
    return quotes;
  }

}
