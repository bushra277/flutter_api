import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:my_app/controllers/home_controller.dart';
import 'package:my_app/core/constant/app_colors.dart';
import 'package:my_app/core/constant/navigator_utils.dart';
import 'package:my_app/models/responses/category.dart';
import 'package:my_app/widgets/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController? homeController;

  @override
  void initState() {
    super.initState();
    homeController = Provider.of<HomeController>(context, listen: false);

    homeController!.getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    // بيانات المستخدم (مؤقتاً ثابتة)
    final String userName = "محمد أحمد";
    final String userPhone = "0791234567";

    final List<String> adImages = [
      'https://picsum.photos/400/200?1',
      'https://picsum.photos/400/200?2',
      'https://picsum.photos/400/200?3',
    ];

    CarouselSliderController buttonCarouselController =
        CarouselSliderController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        appBar: AppBar(
          title: Text(
            "Home",
            style: TextStyle(color: AppColors.titleAppBarColor),
          ),
          centerTitle: true,
          elevation: 2,
          backgroundColor: AppColors.primaryColor,
        ),
        drawer: DrawerWidget(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider.builder(
                    carouselController: buttonCarouselController,
                    itemCount: adImages.length,
                    itemBuilder: (context, index, realIndex) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(adImages[index],
                            fit: BoxFit.cover, width: double.infinity),
                      );
                    },
                    options: CarouselOptions(
                      height: 180,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      viewportFraction: 0.8,
                      onPageChanged: (index, reason) {},
                    )),
                const SizedBox(height: 12),
                Selector<HomeController, List<Category>>(
                    shouldRebuild: (previous, next) => true,
                    selector: (_, service) => service.categories,
                    builder: (context, categories, child) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 1.2,
                        ),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return InkWell(
                            onTap: () {
                              NavigatorUtils.navigateToProductsScreen(
                                  context, category.slug!);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              elevation: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    category.name!,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
