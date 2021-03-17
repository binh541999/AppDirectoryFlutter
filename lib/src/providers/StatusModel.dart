import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:redux_example/src/models/Member.dart';
import 'package:redux_example/src/services/sqlLite/dboMember.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusModel with ChangeNotifier {
  PrefsState _currentPrefs = PrefsState(isLoading: false,isError: false,isFirstOpen: true,isSignOut: true);

  DarkNotifier() {
    _loadStatus();
  }

  Future<void> _loadStatus() async {
    await SharedPreferences.getInstance().then((prefs) {
      bool statusFirstOpen = prefs.getBool('isFirstOpen') ?? true;
      _currentPrefs = PrefsState(isFirstOpen: statusFirstOpen);
      bool statusSignOut = prefs.getBool('isSignOut') ?? true;
      _currentPrefs = PrefsState(isFirstOpen: statusSignOut);
    });

    notifyListeners();
  }

  Future<void> _saveFirstOpen() async {
    await SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('isFirstOpen', _currentPrefs.isFirstOpen);
    });
  }

  Future<void> _saveSignOut() async {
    await SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('isSignOut', _currentPrefs.isSignOut);
    });
  }

  bool get isLoading => _currentPrefs.isLoading;
  bool get isFirstOpen => _currentPrefs.isFirstOpen;
  bool get isError => _currentPrefs.isError;
  bool get isSignOut => _currentPrefs.isSignOut;

  set isLoading(bool newValue) {
    if (newValue == _currentPrefs.isLoading) return;
    _currentPrefs = PrefsState(isLoading: newValue);
    notifyListeners();
  }
  set isError(bool newValue) {
    if (newValue == _currentPrefs.isError) return;
    _currentPrefs = PrefsState(isError: newValue);
    notifyListeners();
  }
  set isFirstOpen(bool newValue) {
    if (newValue == _currentPrefs.isFirstOpen) return;
    _currentPrefs = PrefsState(isFirstOpen: newValue);
    notifyListeners();
    _saveFirstOpen();
  }
  set isSignOut(bool newValue) {
    if (newValue == _currentPrefs.isSignOut) return;
    _currentPrefs = PrefsState(isSignOut: newValue);
    notifyListeners();
    _saveSignOut();
  }

  // void removeAll() {
  //   _currentPrefs.;
  //   // This call tells the widgets that are listening to this model to rebuild.
  //   notifyListeners();
  // }
}

class PrefsState {
  final bool isLoading;
  final bool isError;
  final bool isFirstOpen;
  final bool isSignOut;

  const PrefsState({
    this.isLoading = false,
    this.isError = false,
    this.isFirstOpen = true,
    this.isSignOut=true
  });
}