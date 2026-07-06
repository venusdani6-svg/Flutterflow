import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/auth/base_auth_user_provider.dart';
import '/auth/firebase_auth/auth_util.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) {
        if (!appStateNotifier.loggedIn) {
          return AdminLoginPageWidget();
        }
        if (currentUserDocument == null) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                FlutterFlowTheme.of(context).primary,
              ),
            ),
          );
        }
        return currentUserIsAdmin
            ? AdminDashboardPageWidget()
            : AdminLoginPageWidget();
      },
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          requireAuth: true,
          requireAdmin: true,
          builder: (context, _) => AdminDashboardPageWidget(),
        ),
        FFRoute(
          name: AdminLoginPageWidget.routeName,
          path: AdminLoginPageWidget.routePath,
          builder: (context, params) => AdminLoginPageWidget(),
        ),
        FFRoute(
          name: AdminDashboardPageWidget.routeName,
          path: AdminDashboardPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => AdminDashboardPageWidget(),
        ),
        FFRoute(
          name: StaffUserListPageWidget.routeName,
          path: StaffUserListPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => StaffUserListPageWidget(),
        ),
        FFRoute(
          name: AdministratorListPageWidget.routeName,
          path: AdministratorListPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => AdministratorListPageWidget(),
        ),
        FFRoute(
          name: GuestUserListPageWidget.routeName,
          path: GuestUserListPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => GuestUserListPageWidget(),
        ),
        FFRoute(
          name: UserManagementPageWidget.routeName,
          path: UserManagementPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => UserManagementPageWidget(),
        ),
        FFRoute(
          name: ReservationsManagementPageWidget.routeName,
          path: ReservationsManagementPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => ReservationsManagementPageWidget(),
        ),
        FFRoute(
          name: ReservationListPageWidget.routeName,
          path: ReservationListPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => ReservationListPageWidget(),
        ),
        FFRoute(
          name: CastUserListPageWidget.routeName,
          path: CastUserListPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => CastUserListPageWidget(),
        ),
        FFRoute(
          name: StaffUserdetailsPageWidget.routeName,
          path: StaffUserdetailsPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => StaffUserdetailsPageWidget(),
        ),
        FFRoute(
          name: AdministratodetailsPageWidget.routeName,
          path: AdministratodetailsPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => AdministratodetailsPageWidget(),
        ),
        FFRoute(
          name: ReservationdetailsPageWidget.routeName,
          path: ReservationdetailsPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => ReservationdetailsPageWidget(),
        ),
        FFRoute(
          name: PaymentLedgerListPageWidget.routeName,
          path: PaymentLedgerListPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => PaymentLedgerListPageWidget(),
        ),
        FFRoute(
          name: WithdrawalApplicationListPageWidget.routeName,
          path: WithdrawalApplicationListPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => WithdrawalApplicationListPageWidget(),
        ),
        FFRoute(
          name: KYCReviewListPageWidget.routeName,
          path: KYCReviewListPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => KYCReviewListPageWidget(),
        ),
        FFRoute(
          name: ReportListPageWidget.routeName,
          path: ReportListPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => ReportListPageWidget(),
        ),
        FFRoute(
          name: PaymentLedgerManagementPageWidget.routeName,
          path: PaymentLedgerManagementPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => PaymentLedgerManagementPageWidget(),
        ),
        FFRoute(
          name: WithdrawalApplicationManagementPageWidget.routeName,
          path: WithdrawalApplicationManagementPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) =>
              WithdrawalApplicationManagementPageWidget(),
        ),
        FFRoute(
          name: KYCReviewManagementPageWidget.routeName,
          path: KYCReviewManagementPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => KYCReviewManagementPageWidget(),
        ),
        FFRoute(
          name: ReportManagementPageWidget.routeName,
          path: ReportManagementPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => ReportManagementPageWidget(),
        ),
        FFRoute(
          name: AffiliateListPageWidget.routeName,
          path: AffiliateListPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => AffiliateListPageWidget(),
        ),
        FFRoute(
          name: AffiliateManagementPageWidget.routeName,
          path: AffiliateManagementPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => AffiliateManagementPageWidget(),
        ),
        FFRoute(
          name: CocomiseListPageWidget.routeName,
          path: CocomiseListPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => CocomiseListPageWidget(),
        ),
        FFRoute(
          name: CocomiseManagementPageWidget.routeName,
          path: CocomiseManagementPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => CocomiseManagementPageWidget(),
        ),
        FFRoute(
          name: JobBoardManagementPageWidget.routeName,
          path: JobBoardManagementPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => JobBoardManagementPageWidget(),
        ),
        FFRoute(
          name: JobBoardListPageWidget.routeName,
          path: JobBoardListPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => JobBoardListPageWidget(),
        ),
        FFRoute(
          name: BannerManagementPageWidget.routeName,
          path: BannerManagementPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => BannerManagementPageWidget(),
        ),
        FFRoute(
          name: BannerListPageWidget.routeName,
          path: BannerListPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => BannerListPageWidget(),
        ),
        FFRoute(
          name: SystemSettingsManagementPageWidget.routeName,
          path: SystemSettingsManagementPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => SystemSettingsManagementPageWidget(),
        ),
        FFRoute(
          name: SystemSettingsListPageWidget.routeName,
          path: SystemSettingsListPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => SystemSettingsListPageWidget(),
        ),
        FFRoute(
          name: AuditLogListPageWidget.routeName,
          path: AuditLogListPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => AuditLogListPageWidget(),
        ),
        FFRoute(
          name: AuditLogManagementPageWidget.routeName,
          path: AuditLogManagementPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => AuditLogManagementPageWidget(),
        ),
        FFRoute(
          name: CastUserdetailsPageWidget.routeName,
          path: CastUserdetailsPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => CastUserdetailsPageWidget(),
        ),
        FFRoute(
          name: GuestUserdetailsPageWidget.routeName,
          path: GuestUserdetailsPageWidget.routePath,
          requireAuth: true,
          requireAdmin: true,
          builder: (context, params) => GuestUserdetailsPageWidget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.setRedirectLocationIfUnset(location);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    List<String>? collectionNamePath,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      collectionNamePath: collectionNamePath,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.requireAdmin = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final bool requireAdmin;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          final isLoginRoute = path == AdminLoginPageWidget.routePath;

          if (isLoginRoute &&
              appStateNotifier.loggedIn &&
              currentUserIsAdmin) {
            return AdminDashboardPageWidget.routePath;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return AdminLoginPageWidget.routePath;
          }

          if (requireAdmin && appStateNotifier.loggedIn) {
            if (currentUserDocument != null && !currentUserIsAdmin) {
              return AdminLoginPageWidget.routePath;
            }
          }

          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final waitingForAdminProfile = requireAdmin &&
              appStateNotifier.loggedIn &&
              currentUserDocument == null;
          final child = appStateNotifier.loading || waitingForAdminProfile
              ? Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  name: state.name,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(
                  key: state.pageKey, name: state.name, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
