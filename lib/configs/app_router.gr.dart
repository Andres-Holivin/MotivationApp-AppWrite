// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../models/category_model.dart' as _i9;
import '../pages/add_scheduler_detail_page.dart' as _i6;
import '../pages/category_page.dart' as _i2;
import '../pages/login_page.dart' as _i4;
import '../pages/master_page.dart' as _i3;
import '../pages/registration_page.dart' as _i5;
import '../pages/splash_page.dart' as _i1;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    SplashPageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashPage());
    },
    CategoryPageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.CategoryPage());
    },
    MasterPageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.MasterPage());
    },
    LoginPageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.LoginPage());
    },
    RegistrationPageRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.RegistrationPage());
    },
    AddSchedulerDetailPageRoute.name: (routeData) {
      final args = routeData.argsAs<AddSchedulerDetailPageRouteArgs>();
      return _i7.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.AddSchedulerDetailPage(
              key: args.key, categoryModel: args.categoryModel));
    }
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(SplashPageRoute.name, path: '/'),
        _i7.RouteConfig(CategoryPageRoute.name, path: '/category-page'),
        _i7.RouteConfig(MasterPageRoute.name, path: '/master-page'),
        _i7.RouteConfig(LoginPageRoute.name, path: '/login-page'),
        _i7.RouteConfig(RegistrationPageRoute.name, path: '/registration-page'),
        _i7.RouteConfig(AddSchedulerDetailPageRoute.name,
            path: '/add-scheduler-detail-page')
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashPageRoute extends _i7.PageRouteInfo<void> {
  const SplashPageRoute() : super(SplashPageRoute.name, path: '/');

  static const String name = 'SplashPageRoute';
}

/// generated route for
/// [_i2.CategoryPage]
class CategoryPageRoute extends _i7.PageRouteInfo<void> {
  const CategoryPageRoute()
      : super(CategoryPageRoute.name, path: '/category-page');

  static const String name = 'CategoryPageRoute';
}

/// generated route for
/// [_i3.MasterPage]
class MasterPageRoute extends _i7.PageRouteInfo<void> {
  const MasterPageRoute() : super(MasterPageRoute.name, path: '/master-page');

  static const String name = 'MasterPageRoute';
}

/// generated route for
/// [_i4.LoginPage]
class LoginPageRoute extends _i7.PageRouteInfo<void> {
  const LoginPageRoute() : super(LoginPageRoute.name, path: '/login-page');

  static const String name = 'LoginPageRoute';
}

/// generated route for
/// [_i5.RegistrationPage]
class RegistrationPageRoute extends _i7.PageRouteInfo<void> {
  const RegistrationPageRoute()
      : super(RegistrationPageRoute.name, path: '/registration-page');

  static const String name = 'RegistrationPageRoute';
}

/// generated route for
/// [_i6.AddSchedulerDetailPage]
class AddSchedulerDetailPageRoute
    extends _i7.PageRouteInfo<AddSchedulerDetailPageRouteArgs> {
  AddSchedulerDetailPageRoute(
      {_i8.Key? key, required _i9.CategoryModel categoryModel})
      : super(AddSchedulerDetailPageRoute.name,
            path: '/add-scheduler-detail-page',
            args: AddSchedulerDetailPageRouteArgs(
                key: key, categoryModel: categoryModel));

  static const String name = 'AddSchedulerDetailPageRoute';
}

class AddSchedulerDetailPageRouteArgs {
  const AddSchedulerDetailPageRouteArgs(
      {this.key, required this.categoryModel});

  final _i8.Key? key;

  final _i9.CategoryModel categoryModel;

  @override
  String toString() {
    return 'AddSchedulerDetailPageRouteArgs{key: $key, categoryModel: $categoryModel}';
  }
}
