import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import 'package:my_app/controllers/home_controller.dart';
import 'package:my_app/controllers/products_controller.dart';
import 'package:my_app/core/constant/app_colors.dart';
import 'package:my_app/models/responses/category.dart';
import 'package:my_app/models/responses/product_by_category_response.dart';
import 'package:my_app/widgets/drawer_widget.dart';

class ProductsScreen extends StatefulWidget {
  final String? categoryName;

  const ProductsScreen({super.key, this.categoryName});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  ProductController? productController;

  @override
  void initState() {
    super.initState();
    productController = Provider.of<ProductController>(context, listen: false);

    productController!.getAllProducts(categoryName: widget.categoryName);
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
                Selector<ProductController, List<Product>>(
                    shouldRebuild: (previous, next) => true,
                    selector: (_, service) => service.products,
                    builder: (context, products, child) {
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
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return InkWell(
                            onTap: () {},
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              elevation: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        productController!.deleteProduct(
                                            productId: products[index].id!);
                                      },
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                        size: 30,
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        showUpdateProductDialog(context, product);
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                        size: 30,
                                      )),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    product.title!,
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
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: IconButton(onPressed: (){
                    showAddProductDialog(context);
                  }, icon: Icon(Icons.add , color: Colors.white,)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  void showAddProductDialog(BuildContext context) {
  final TextEditingController titleController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      final controller = context.read<ProductController>();

      return AlertDialog(
        title: const Text('Add Product'),
        content: TextField(
          controller: titleController,
          decoration: const InputDecoration(
            labelText: 'Product Title',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final title = titleController.text.trim();
              if (title.isNotEmpty) {
                await controller.addProduct(title: title);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      );
    },
  );
}

void showUpdateProductDialog(BuildContext context, Product product) {
  final TextEditingController titleController =
      TextEditingController(text: product.title);

  showDialog(
    context: context,
    builder: (context) {
      final controller = context.read<ProductController>();

      return AlertDialog(
        title: const Text('Update Product'),
        content: TextField(
          controller: titleController,
          decoration: const InputDecoration(
            labelText: 'Product Title',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final title = titleController.text.trim();
              if (title.isNotEmpty) {
                await controller.updateProduct(
                  id: product.id!,
                  title: title,
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Update'),
          ),
        ],
      );
    },
  );
}

}
