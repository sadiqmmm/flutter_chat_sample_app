import 'package:chat/src/data/database_helper.dart';
import 'package:chat/src/data/rest_ds.dart';
import 'package:chat/src/models/message.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

abstract class ChatScreenContract {
  void onLoadMessageSuccess(ListMessage messages);
  void onLoadMessageError(String errorMessage);
  void onLogoutSuccess();
}

class ChatScreenPresenter {
  ChatScreenContract _view;
  RestDatasource api = new RestDatasource();
  ChatScreenPresenter(this._view);
  int currentPage = 0;
  loadMessages() {
    print('Loading: ${currentPage + 1}');

    api.getMessages(currentPage + 1).then((ListMessage messages) {
      if (currentPage < messages.totalPages) {
        currentPage++;
      }

      updateBadger();
      _view.onLoadMessageSuccess(messages);
    }).catchError(
        (Exception error) => _view.onLoadMessageError(error.toString()));
  }

  void logout() {
    api.logout().then((dynamic _) {
      var db = new DatabaseHelper();
      db.deleteDb().then((_) {
        _view.onLogoutSuccess();
      });
    });
  }

  void readAll() {
    api.readAll().then((dynamic _) {
      updateBadger();
    });
  }

  void updateBadger() {
    FlutterAppBadger.isAppBadgeSupported().then((isSupported) {
      if (isSupported) FlutterAppBadger.removeBadge();
      // FlutterAppBadger.updateBadgeCount(1);
    });
  }
}
