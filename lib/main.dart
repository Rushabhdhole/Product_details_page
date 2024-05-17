import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Product {
  final String name;
  final double price;
  final String image;
  final String description;
  final double rating;
  final List<String> specifications;
  final List<String> reviews;
  final List<String> faqs;

  Product({
    required this.name,
    required this.price,
    required this.image,
    required this.description,
    required this.rating,
    required this.specifications,
    required this.reviews,
    required this.faqs,
  });
}

class MyApp extends StatelessWidget {
  final List<Product> products = [
    Product(
      name: "Running Shoes",
      price: 50.0,
      image: "assets/shoe1.jpg",
      description: "Comfortable and lightweight running shoes.",
      rating: 4.5,
      specifications: [
        "Material: Mesh",
        "Sole: Rubber",
        "Weight: 250g",
        "Colors: Red, Blue, Black",
      ],
      reviews: [
        "John Doe: Very comfortable and stylish!",
        "Jane Smith: Perfect for my daily runs.",
      ],
      faqs: [
        "Q: Are these shoes true to size?",
        "A: Yes, they fit as expected.",
        "Q: Can I use them for hiking?",
        "A: They are best suited for running.",
      ],
    ),
    Product(
      name: "Basketball Shoes",
      price: 70.0,
      image: "assets/shoe2.jpg",
      description: "High-top shoes with great ankle support.",
      rating: 4.7,
      specifications: [
        "Material: Leather",
        "Sole: Rubber",
        "Weight: 300g",
        "Colors: White, Black",
      ],
      reviews: [
        "Alice: Great ankle support and comfortable.",
        "Bob: Excellent shoes for playing basketball.",
      ],
      faqs: [
        "Q: Are these shoes suitable for outdoor courts?",
        "A: Yes, they have a durable sole.",
        "Q: Do they come in different widths?",
        "A: They are available in standard width.",
      ],
    ),
    Product(
      name: "Casual Sneakers",
      price: 40.0,
      image: "assets/shoe3.jpg",
      description: "Stylish sneakers for everyday wear.",
      rating: 4.3,
      specifications: [
        "Material: Canvas",
        "Sole: Rubber",
        "Weight: 200g",
        "Colors: White, Black, Grey",
      ],
      reviews: [
        "Charlie: Looks great and feels comfortable.",
        "Diana: Perfect for casual outings.",
      ],
      faqs: [
        "Q: Are these sneakers waterproof?",
        "A: No, they are not waterproof.",
        "Q: Can I wash them in a machine?",
        "A: Yes, but use a gentle cycle.",
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ProductList(products: products),
    );
  }
}

class ProductList extends StatelessWidget {
  final List<Product> products;

  ProductList({required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2 / 3,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetail(product: products[index]),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: Image.asset(
                            products[index].image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                products[index].name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '\$${products[index].price}',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: List.generate(5, (starIndex) {
                                  return Icon(
                                    starIndex < products[index].rating
                                        ? Icons.star
                                        : Icons.star_border,
                                    size: 16,
                                    color: Colors.amber,
                                  );
                                }),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ProductDetail extends StatelessWidget {
  final Product product;

  ProductDetail({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Image.asset(
                product.image,
                height: 300,
              ),
            ),
            SizedBox(height: 20),
            Text(
              product.name,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              '\$${product.price}',
              style: TextStyle(fontSize: 24, color: Colors.green),
            ),
            SizedBox(height: 10),
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < product.rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                );
              }),
            ),
            SizedBox(height: 20),
            Text(
              product.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Specifications:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...product.specifications.map((spec) => Text('- $spec')).toList(),
            SizedBox(height: 20),
            Text(
              'Reviews:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...product.reviews.map((review) => Text('- $review')).toList(),
            SizedBox(height: 20),
            Text(
              'FAQs:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...product.faqs.map((faq) => Text(faq)).toList(),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Implement your buy now functionality here
                },
                child: Text('Buy Now'),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
