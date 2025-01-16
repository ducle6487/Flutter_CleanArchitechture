import 'package:flutter/material.dart';
import 'package:flutter_clean_architechture/config/app_radius.dart';
import 'package:flutter_clean_architechture/config/app_spacings.dart';
import 'package:flutter_clean_architechture/core/theme/extension/theme_extension.dart';
import 'package:flutter/services.dart';

class AdvancedCarousel extends StatefulWidget {
  final List<Widget> content;
  final double? height;
  final bool? isShowPageIndicator;
  final void Function(int)? onPageChange;

  const AdvancedCarousel({
    super.key,
    required this.content,
    this.height = 500,
    this.isShowPageIndicator = true,
    this.onPageChange,
  });

  @override
  AdvancedCarouselState createState() => AdvancedCarouselState();
}

class AdvancedCarouselState extends State<AdvancedCarousel> {
  final PageController _pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.87,
  );
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.isShowPageIndicator!)
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.content.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(
                        horizontal: AppSpacings.squishy),
                    width: _currentPage == index ? 15 : 10,
                    height: _currentPage == index ? 15 : 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage == index
                          ? context.appColors.errorColor
                          : context.appColors.transparentColor,
                    ),
                  );
                }),
              ),
              const SizedBox(
                height: AppSpacings.roomy,
              )
            ],
          ),
        // Container for the carousel with fixed height
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.content.length,
            onPageChanged: (index) {
              HapticFeedback.selectionClick();
              if (widget.onPageChange != null) {
                widget.onPageChange!(index);
              }
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _pageController,
                builder: (context, child) {
                  double value = 1.0;
                  if (_pageController.position.haveDimensions) {
                    value = _pageController.page! - index;
                    value = (1 - (value.abs() * 0.2))
                        .clamp(0.0, 1.0); // Scaling effect
                  }
                  return Center(
                    child: SizedBox(
                      height: Curves.easeOut.transform(value) *
                          widget.height!, // Adjust height scaling
                      width: Curves.easeOut.transform(value) *
                          MediaQuery.of(context).size.width,
                      child: child,
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: AppSpacings.compact,
                  ), // Margin for spacing between items
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppRadius.large,
                    ), // Rounded corners
                    child: widget.content[index],
                  ),
                ),
              );
            },
          ),
        ),
        // Dots Indicator
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
