import 'package:flutter_clean_architechture/config/app_icons.dart';
import 'package:flutter_clean_architechture/config/app_strings.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_floating_action_button.dart';
import 'package:flutter_clean_architechture/core/widgets/enum/floating_action_button_type.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_clean_architechture/app/presentation/third_page/view/third_page_view.dart';
import 'package:flutter_clean_architechture/app/presentation/second_page/view/second_page_view.dart';
import 'package:flutter_clean_architechture/app/presentation/fourth_page/view/fourth_page_view.dart';
import 'package:flutter_clean_architechture/app/presentation/fifth_page/view/fifth_page_view.dart';
import 'package:flutter_clean_architechture/app/presentation/notifications_history/controller/notification_history_view_controller.dart';
import 'package:flutter_clean_architechture/app/presentation/notifications_history/provider/notification_history_view_provider.dart';
import 'package:flutter_clean_architechture/config/app_dimensions.dart';
import 'package:flutter_clean_architechture/config/app_icons_image.dart';
import 'package:flutter_clean_architechture/core/localization/controller/localization_controller.dart';
import 'package:flutter_clean_architechture/core/localization/provider/localization_provider.dart';
import 'package:flutter_clean_architechture/core/localization/enum/text_type.dart';
import 'package:flutter_clean_architechture/app/presentation/home/provider/home_view_provider.dart';
import 'package:flutter_clean_architechture/app/presentation/first_page/view/first_page_view.dart';
import 'package:flutter_clean_architechture/app/presentation/home/widget/advanced_home_app_bar.dart';
import 'package:flutter_clean_architechture/core/localization/service/localization_service.dart';
import 'package:flutter_clean_architechture/core/notification/service/notification_observable_service.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_navigation_bar.dart';
import 'package:flutter_clean_architechture/core/widgets/advanced_navigation_rail.dart';
import 'package:flutter_clean_architechture/core/router/enum/home_page_type.dart';
import 'package:flutter_clean_architechture/core/widgets/model/advanced_bottom_navigation_bar_item_model.dart';
import 'package:flutter_clean_architechture/core/widgets/model/advanced_navigation_rail_destination_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LocalizationState state =
        ref.watch(LocalizationProvider.localizationControllerProvider);
    NotificationHistoryViewController notificationController = ref.watch(
      NotificationHistoryViewProvider
          .notificationHistoryViewControllerProvider.notifier,
    );
    NotificationObservableService.createInstance(notificationController);

    return state.toggleReload ? content(context, ref) : content(context, ref);
  }

  Widget content(BuildContext context, WidgetRef ref) {
    final homeViewState =
        ref.watch(HomeViewProvider.homeViewControllerProvider);
    return Scaffold(
      key: homeViewState.homePageScaffoldKey,
      appBar: _getAppBar(homePageType: homeViewState.homePageType)
          as PreferredSizeWidget?,
      body: Row(
        children: <Widget>[
          _getNavigationRail(
              ref: ref,
              homePageType: homeViewState.homePageType,
              context: context),
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: homeViewState.pageController,
              onPageChanged: (index) async => await _onPageChanged(
                ref: ref,
                index: index,
                context: context,
              ),
              children: const <Widget>[
                FirstPageView(),
                SecondPageView(),
                ThirdPageView(),
                FourthPageView(),
                FifthPageView(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton:
          _createFloatingActionButton(homePageType: homeViewState.homePageType),
      bottomNavigationBar: _getBottomNavigationBar(
        ref: ref,
        homePageType: homeViewState.homePageType,
        context: context,
      ),
    );
  }

  /// Represents the page change event.
  Future<void> _onPageChanged({
    required WidgetRef ref,
    required int index,
    required BuildContext context,
  }) async {
    if (context.mounted) {
      final homeViewController =
          ref.read(HomeViewProvider.homeViewControllerProvider.notifier);
      final HomePageType? homePageType =
          HomePageType.getHomePageTypeByIndex(index: index);

      if (homePageType != null) {
        await homeViewController.changePage(homePageType: homePageType);
      }
    }
  }

  /// Creates a [FloatingActionButton].
  Widget? _createFloatingActionButton({
    required HomePageType homePageType,
  }) {
    return switch (homePageType) {
      HomePageType.firstPage => AdvancedFloatingActionButton(
          icon: AppIcons.add.icon,
          title: null,
          onTap: () async {},
          tooltip: AppStrings.emptyText.text,
          type: FloatingActionButtonType.normal,
        ),
      HomePageType.fourthPage => null,
      HomePageType.thirdPage => null,
      HomePageType.secondPage => null,
      HomePageType.fifthPage => null,
    };
  }

  /// Creates an [AppBar].
  Widget? _getAppBar({
    required HomePageType homePageType,
  }) {
    return switch (homePageType) {
      HomePageType.firstPage => AdvancedHomeAppBar(
          title: LocalizationService.translateText(TextType.firstPage),
        ),
      HomePageType.secondPage => null,
      HomePageType.thirdPage => AdvancedHomeAppBar(
          title: LocalizationService.translateText(TextType.thirdPage),
        ),
      HomePageType.fourthPage => AdvancedHomeAppBar(
          title: LocalizationService.translateText(TextType.fourthPage),
        ),
      HomePageType.fifthPage => AdvancedHomeAppBar(
          title: LocalizationService.translateText(TextType.fifthPage),
        ),
    };
  }

  /// Creates a [AdvancedNavigationBar].
  Widget? _getBottomNavigationBar({
    required WidgetRef ref,
    required HomePageType homePageType,
    required BuildContext context,
  }) {
    if (MediaQuery.sizeOf(ref.context).shortestSide >=
        AppDimensions.maxPhoneWidth) {
      return null;
    }

    return SizedBox(
      height: AppDimensions.bottomAppBarHeight,
      width: Get.width,
      child: AdvancedNavigationBar(
        currentIndex: homePageType.index,
        onTap: (index) async => await _onPageChanged(
          ref: ref,
          index: index,
          context: context,
        ),
        items: <AdvancedNavigationBarItemModel>[
          AdvancedNavigationBarItemModel(
            unselectedIcon: _getUnSelectedWidget(0),
            selectedIcon: _getSelectedWidget(0),
            title: LocalizationService.translateText(TextType.firstPage)
                .toUpperCase(),
            tooltip: LocalizationService.translateText(TextType.firstPage),
          ),
          AdvancedNavigationBarItemModel(
            unselectedIcon: _getUnSelectedWidget(1),
            selectedIcon: _getSelectedWidget(1),
            tooltip: LocalizationService.translateText(TextType.secondPage),
            title: LocalizationService.translateText(TextType.secondPage)
                .toUpperCase(),
          ),
          AdvancedNavigationBarItemModel(
            unselectedIcon: _getUnSelectedWidget(2),
            selectedIcon: _getSelectedWidget(2),
            tooltip: LocalizationService.translateText(TextType.thirdPage),
            title: LocalizationService.translateText(TextType.thirdPage)
                .toUpperCase(),
          ),
          AdvancedNavigationBarItemModel(
            unselectedIcon: _getUnSelectedWidget(3),
            selectedIcon: _getSelectedWidget(3),
            tooltip: LocalizationService.translateText(TextType.fourthPage),
            title: LocalizationService.translateText(TextType.fourthPage)
                .toUpperCase(),
          ),
          AdvancedNavigationBarItemModel(
            unselectedIcon: _getUnSelectedWidget(4),
            selectedIcon: _getSelectedWidget(4),
            title: LocalizationService.translateText(TextType.fifthPage)
                .toUpperCase(),
            tooltip: LocalizationService.translateText(TextType.fifthPage),
          ),
        ],
      ),
    );
  }

  /// Creates a [AdvancedNavigationRail].
  Widget _getNavigationRail({
    required WidgetRef ref,
    required HomePageType homePageType,
    required BuildContext context,
  }) {
    if (MediaQuery.sizeOf(ref.context).shortestSide <
        AppDimensions.maxPhoneWidth) {
      return const SizedBox();
    }

    return AdvancedNavigationRail(
      currentIndex: homePageType.index,
      onTap: (index) async => await _onPageChanged(
        ref: ref,
        index: index,
        context: context,
      ),
      destinations: <AdvancedNavigationRailDestinationModel>[
        AdvancedNavigationRailDestinationModel(
          unselectedIcon: _getUnSelectedWidget(0),
          selectedIcon: _getSelectedWidget(0),
          title: LocalizationService.translateText(TextType.firstPage),
        ),
        AdvancedNavigationRailDestinationModel(
          unselectedIcon: _getUnSelectedWidget(1),
          selectedIcon: _getSelectedWidget(1),
          title: LocalizationService.translateText(TextType.secondPage),
        ),
        AdvancedNavigationRailDestinationModel(
          unselectedIcon: _getUnSelectedWidget(2),
          selectedIcon: _getSelectedWidget(2),
          title: LocalizationService.translateText(TextType.thirdPage),
        ),
        AdvancedNavigationRailDestinationModel(
          unselectedIcon: _getUnSelectedWidget(3),
          selectedIcon: _getSelectedWidget(3),
          title: LocalizationService.translateText(TextType.fourthPage),
        ),
        AdvancedNavigationRailDestinationModel(
          unselectedIcon: _getUnSelectedWidget(4),
          selectedIcon: _getSelectedWidget(4),
          title: LocalizationService.translateText(TextType.fifthPage),
        ),
      ],
    );
  }

  Widget _getSelectedWidget(int index) {
    return Container(
      padding: EdgeInsets.only(top: AppDimensions.tabbarIconTopPadding),
      height: AppDimensions.tabbarBackgroundSize,
      width: AppDimensions.tabbarBackgroundSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_getSelectedIcon(index) is IconData)
            Icon(
              _getSelectedIcon(index) as IconData,
              size: AppDimensions.tabbarIconSize,
            )
          else if (_getSelectedIcon(index) is AssetImage)
            Image(
              image: _getSelectedIcon(index) as AssetImage,
              height: AppDimensions.tabbarIconSize,
              width: AppDimensions.tabbarIconSize,
              fit: BoxFit.cover,
            )
          else
            Image(
              image: _getSelectedIcon(index) as NetworkImage,
              height: AppDimensions.tabbarIconSize,
              width: AppDimensions.tabbarIconSize,
              fit: BoxFit.cover,
            )
        ],
      ),
    );
  }

  Widget _getUnSelectedWidget(int index) {
    return Container(
      padding: EdgeInsets.only(top: AppDimensions.tabbarIconTopPadding),
      height: AppDimensions.tabbarBackgroundSize,
      width: AppDimensions.tabbarBackgroundSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (_getUnSelectedIcon(index) is IconData)
            Icon(
              _getUnSelectedIcon(index) as IconData,
              size: AppDimensions.tabbarIconSize,
            )
          else if (_getUnSelectedIcon(index) is AssetImage)
            Image(
              image: _getUnSelectedIcon(index) as AssetImage,
              height: AppDimensions.tabbarIconSize,
              width: AppDimensions.tabbarIconSize,
              fit: BoxFit.cover,
            )
          else
            Image(
              image: _getUnSelectedIcon(index) as NetworkImage,
              height: AppDimensions.tabbarIconSize,
              width: AppDimensions.tabbarIconSize,
              fit: BoxFit.cover,
            )
        ],
      ),
    );
  }

  Object? _getUnSelectedIcon(int index) {
    return switch (index) {
      0 => AppIconsImage.home.asset,
      1 => AppIconsImage.map.asset,
      2 => AppIconsImage.medical.asset,
      3 => AppIconsImage.news.asset,
      4 => AppIconsImage.services.asset,
      _ => null,
    };
  }

  Object? _getSelectedIcon(int index) {
    return switch (index) {
      0 => AppIconsImage.homeSelected.asset,
      1 => AppIconsImage.mapSelected.asset,
      2 => AppIconsImage.medicalSelected.asset,
      3 => AppIconsImage.newsSelected.asset,
      4 => AppIconsImage.servicesSelected.asset,
      _ => null,
    };
  }
}
