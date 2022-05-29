import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../domain/model/onboarding_model.dart';
import '../../resources/assest_manger.dart';
import '../../resources/color_manger.dart';
import '../../resources/strings_manger.dart';
import '../../resources/values_manger.dart';
import '../viewmodel/onboarding_model_view.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final OnboardingViewModel _viewModel = OnboardingViewModel();
  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputSliderViewObject,
      builder: (context, snapshot) =>
          _GetContent(data: snapshot.data, viewModel: _viewModel),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

class _GetContent extends StatelessWidget {
  const _GetContent({
    required this.viewModel,
    this.data,
    Key? key,
  }) : super(key: key);
  final OnboardingViewModel viewModel;
  final SliderViewObject? data;

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Container();
    } else {
      return Scaffold(
        appBar: AppBar(
            backgroundColor: ColorManger.white,
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: ColorManger.white,
                statusBarBrightness: Brightness.dark)),
        backgroundColor: ColorManger.white,
        body: PageView.builder(
            controller: data?.pageController,
            itemCount: data?.numberOfSlides,
            onPageChanged: (index) => viewModel.onPageChanged(index),
            itemBuilder: (context, index) {
              return ColumnData(sliderObject: data?.list[index]);
            }),
        bottomSheet: Container(
          //height: AppSizeMange.s96,
          color: ColorManger.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => viewModel.skip(context),
                  child: Text(
                    AppStringsManger.skip,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              Container(
                color: ColorManger.primary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    data!.first
                        ? const SizedBox()
                        : MaterialButton(
                            onPressed: () => viewModel.goPrevious(),
                            child: SvgPicture.asset(
                                AppImage.onboardingArrowLeftIcon,
                                width: AppSizeMange.s20)),
                    SmoothPageIndicator(
                        controller: data!.pageController,
                        count: data!.numberOfSlides,
                        effect: ScrollingDotsEffect(
                            activeDotColor: ColorManger.white,
                            dotHeight: AppSizeMange.s12,
                            dotColor: ColorManger.grey2)),
                    MaterialButton(
                        onPressed: () => viewModel.goNext(context),
                        child: SvgPicture.asset(
                          AppImage.onboardingArrowRightIcon,
                          width: AppSizeMange.s20,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}

class ColumnData extends StatelessWidget {
  final Sliderobject? sliderObject;
  const ColumnData({Key? key, this.sliderObject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSizeMange.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPaddingSizeMange.p8),
          child: Text(
            "${sliderObject?.title}",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPaddingSizeMange.p8),
          child: Text(
            "${sliderObject?.subTitle}",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(
          height: AppSizeMange.s60,
        ),
        SvgPicture.asset("${sliderObject?.image}"),
      ],
    );
  }
}
