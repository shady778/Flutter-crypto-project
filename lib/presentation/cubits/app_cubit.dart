import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/Repositories/AppRepo.dart';
import '../../data/Models/CoinModel.dart';
import 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AppRepo _appRepo;

  AppCubit(this._appRepo) : super(const AppState()) {
    checkAuthStatus();
  }

  void checkAuthStatus() {
    final loggedIn = _appRepo.checkUserLoggedIn();
    if (loggedIn) {
      emit(state.copyWith(
        isLoggedIn: true,
        userName: _appRepo.getUserName(),
        userEmail: _appRepo.getUserEmail(),
      ));
    } else {
      emit(state.copyWith(isLoggedIn: false));
    }
  }

  Future<bool> login(String email, String password) async {
    emit(state.copyWith(isAuthLoading: true));
    emit(state.clearAuthError());
    final success = await _appRepo.login(email, password);
    if (success) {
      emit(state.copyWith(
        isAuthLoading: false,
        isLoggedIn: true,
        userName: _appRepo.getUserName(),
        userEmail: _appRepo.getUserEmail(),
      ));
      return true;
    } else {
      emit(
        state.copyWith(isAuthLoading: false, authError: "Invalid credentials"),
      );
      return false;
    }
  }

  Future<bool> signup(String name, String email, String password) async {
    emit(state.copyWith(isAuthLoading: true));
    emit(state.clearAuthError());
    final success = await _appRepo.signup(name, email, password);
    if (success) {
      emit(state.copyWith(
        isAuthLoading: false,
        isLoggedIn: true,
        userName: _appRepo.getUserName(),
        userEmail: _appRepo.getUserEmail(),
      ));
      return true;
    } else {
      emit(state.copyWith(isAuthLoading: false, authError: "Signup failed"));
      return false;
    }
  }

  Future<void> logout() async {
    await _appRepo.logout();
    emit(state.copyWith(isLoggedIn: false, userName: '', userEmail: ''));
  }

  void loadAllData() {
    loadHomeCoins();
    loadMarketCoins();
    loadFavoriteCoins();
  }

  Future<void> loadHomeCoins() async {
    emit(state.copyWith(isHomeCoinsLoading: true));
    try {
      final coins = await _appRepo.getHomeCoins();
      emit(state.copyWith(homeCoins: coins, isHomeCoinsLoading: false));
    } catch (e) {
      emit(state.copyWith(isHomeCoinsLoading: false));
    }
  }

  Future<void> loadMarketCoins() async {
    emit(state.copyWith(isMarketCoinsLoading: true));
    try {
      final coins = await _appRepo.getAllCoins();
      emit(state.copyWith(marketCoins: coins, isMarketCoinsLoading: false));
    } catch (e) {
      emit(state.copyWith(isMarketCoinsLoading: false));
    }
  }

  Future<void> loadFavoriteCoins() async {
    emit(state.copyWith(isFavoritesLoading: true));
    try {
      final favs = await _appRepo.getFavorites();
      emit(state.copyWith(favoriteCoins: favs, isFavoritesLoading: false));
    } catch (e) {
      emit(state.copyWith(isFavoritesLoading: false));
    }
  }

  Future<void> toggleFavorite(CoinModel coin) async {
    await _appRepo.toggleFavorite(coin);
    await loadFavoriteCoins();
  }

  void updateMarketSearchQuery(String query) {
    emit(state.copyWith(marketSearchQuery: query));
  }

  void updateMarketFilter(int index) {
    emit(state.copyWith(marketFilterIndex: index));
  }
}
