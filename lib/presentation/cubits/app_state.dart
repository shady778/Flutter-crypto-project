import 'package:equatable/equatable.dart';
import '../../data/Models/CoinModel.dart';

class AppState extends Equatable {
  final List<CoinModel> homeCoins;
  final bool isHomeCoinsLoading;

  final List<CoinModel> marketCoins;
  final bool isMarketCoinsLoading;

  final List<CoinModel> favoriteCoins;
  final bool isFavoritesLoading;

  final bool isLoggedIn;
  final bool isAuthLoading;
  final String? authError;

  final String userName;
  final String userEmail;

  final String marketSearchQuery;
  final int marketFilterIndex;

  const AppState({
    this.homeCoins = const [],
    this.isHomeCoinsLoading = true,
    this.marketCoins = const [],
    this.isMarketCoinsLoading = true,
    this.favoriteCoins = const [],
    this.isFavoritesLoading = true,
    this.isLoggedIn = false,
    this.isAuthLoading = false,
    this.authError,
    this.userName = '',
    this.userEmail = '',
    this.marketSearchQuery = '',
    this.marketFilterIndex = 0,
  });

  AppState copyWith({
    List<CoinModel>? homeCoins,
    bool? isHomeCoinsLoading,
    List<CoinModel>? marketCoins,
    bool? isMarketCoinsLoading,
    List<CoinModel>? favoriteCoins,
    bool? isFavoritesLoading,
    bool? isLoggedIn,
    bool? isAuthLoading,
    String? authError,
    String? userName,
    String? userEmail,
    String? marketSearchQuery,
    int? marketFilterIndex,
  }) {
    return AppState(
      homeCoins: homeCoins ?? this.homeCoins,
      isHomeCoinsLoading: isHomeCoinsLoading ?? this.isHomeCoinsLoading,
      marketCoins: marketCoins ?? this.marketCoins,
      isMarketCoinsLoading: isMarketCoinsLoading ?? this.isMarketCoinsLoading,
      favoriteCoins: favoriteCoins ?? this.favoriteCoins,
      isFavoritesLoading: isFavoritesLoading ?? this.isFavoritesLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isAuthLoading: isAuthLoading ?? this.isAuthLoading,
      authError: authError,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
      marketSearchQuery: marketSearchQuery ?? this.marketSearchQuery,
      marketFilterIndex: marketFilterIndex ?? this.marketFilterIndex,
    );
  }

  AppState clearAuthError() {
    return AppState(
      homeCoins: homeCoins,
      isHomeCoinsLoading: isHomeCoinsLoading,
      marketCoins: marketCoins,
      isMarketCoinsLoading: isMarketCoinsLoading,
      favoriteCoins: favoriteCoins,
      isFavoritesLoading: isFavoritesLoading,
      isLoggedIn: isLoggedIn,
      isAuthLoading: isAuthLoading,
      authError: null,
      userName: userName,
      userEmail: userEmail,
      marketSearchQuery: marketSearchQuery,
      marketFilterIndex: marketFilterIndex,
    );
  }

  @override
  List<Object?> get props => [
        homeCoins,
        isHomeCoinsLoading,
        marketCoins,
        isMarketCoinsLoading,
        favoriteCoins,
        isFavoritesLoading,
        isLoggedIn,
        isAuthLoading,
        authError,
        userName,
        userEmail,
        marketSearchQuery,
        marketFilterIndex,
      ];
}
