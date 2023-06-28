import 'package:lsm_project/domain/entities/quote.dart';
import 'package:lsm_project/domain/repositories/book_repo.dart';
import 'package:lsm_project/domain/repositories/quote_repo.dart';

class CloseBooksConnection {
  final BookRepository _repository;
  CloseBooksConnection(this._repository);

  Future<void> execute() async {
    return await _repository.closeConnection();
  }
}