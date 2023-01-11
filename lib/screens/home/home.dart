import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pingolearn/app/app_bootstratper.dart';
import 'package:pingolearn/screens/home/home_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "e-Shop",
        ),
        backgroundColor: Color(0xff0C54BE),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: ChangeNotifierProvider<HomeProvider>(
        create: (context) => locator()..init(),
        child: Consumer<HomeProvider>(
          builder: ((context, value, child) {
            if (value.homePageState == HomePageState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 4 / 6,
              children: List.generate(value.products.products.length, (index) {
                final product = value.products.products[index];
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width: MediaQuery.of(context).size.width * 0.4,
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage(
                                product.thumbnail,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Text(
                          product.title,
                          maxLines: 1,
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 12),
                        ),
                        Text(
                          product.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                              fontSize: 10),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text(
                              "\$${product.price}",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: value.showDiscount
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                                decoration: value.showDiscount
                                    ? TextDecoration.lineThrough
                                    : null,
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            if (value.showDiscount) ...[
                              Text(
                                "\$${value.getDiscountedPrice(product.discountPercentage, product.price)}",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                "${product.discountPercentage}% off",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.green,
                                ),
                              )
                            ]
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}
