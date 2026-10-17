import 'library_item.dart';
import 'user.dart';

class Library {
  final List<LibraryItem> _items = [];

  void addItem(LibraryItem? item) {
    if(item != null) _items.add(item);
  }

  List<LibraryItem> searchByTitle(String? query) {
    if(query == null || query.isEmpty) return [];
    return _items.where((item) =>
    item.title.toLowerCase().contains(query.toLowerCase())).toList();
  }

  List<LibraryItem> getItemsByAuthor(String? author){
    if(author == null || author.isEmpty) return [];
    return _items.where((item) =>
      item.author != null && item.author == author).toList();
  }

  bool borrwItem(LibraryItem item, User user, DateTime dueDate) {
    if(item.borrower != null) {
      throw Exception('Item is already borrowed by ${item.borrower?.name}.');
    }

    item.borrower = user;
    item.dueDate = dueDate;
    return true;
  }

  void returnItem(LibraryItem item) {
    item.borrower = null;
    item.dueDate = null;
  }

}