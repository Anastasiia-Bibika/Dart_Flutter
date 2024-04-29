import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Автомобільні марки',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: CarBrandsPage(),
    );
  }
}

class CarBrandsPage extends StatefulWidget {
  @override
  _CarBrandsPageState createState() => _CarBrandsPageState();
}

class _CarBrandsPageState extends State<CarBrandsPage> {
  int _currentIndex = 0;
  List<CarBrand> _carBrands = [
    CarBrand(
      image: 'assets/images/bmw.jpg',
      name: 'BMW',
      description:
      'BMW is a German car manufacturer known for its luxury, style, and high technical specifications. The company was founded in 1916 as an aircraft and engine manufacturer, but after World War I, it switched to producing motorcycles and cars.',
    ),
    CarBrand(
      image: 'assets/images/toyota.jpg',
      name: 'Toyota',
      description:
      'Toyota is a Japanese car manufacturer known for its reliability, efficiency, and innovation. The company was founded in 1937 and specialized in producing automobiles for a wide range of consumers. The first Toyota car was the Model AA sedan, which was released in 1936.',
    ),
    CarBrand(
      image: 'assets/images/audi.jpg',
      name: 'Audi',
      description:
      'Audi is a German automobile manufacturer known for its luxury vehicles, innovative technology, and sleek design. Founded in 1910, Audi has a long history of producing high-quality cars that cater to both performance enthusiasts and those seeking comfort and style.',
    ),
    CarBrand(
      image: 'assets/images/ford.jpg',
      name: 'Ford',
      description:
      'Ford is an American multinational automaker with a rich history dating back to its founding in 1903 by Henry Ford. Renowned for pioneering the assembly line technique of mass production, Ford revolutionized the automobile industry.',
    ),
  ];

  void _nextCard() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _carBrands.length;
    });
  }

  void _prevCard() {
    setState(() {
      _currentIndex =
          (_currentIndex - 1 + _carBrands.length) % _carBrands.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      appBar: AppBar(
        title: Text('Автомобільні марки'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CardWidget(
                carBrand: _carBrands[_currentIndex],
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _prevCard,
                    child: Text('Назад'),
                  ),
                  ElevatedButton(
                    onPressed: _nextCard,
                    child: Text('Далі'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CarBrand {
  final String image;
  final String name;
  final String description;

  CarBrand(
      {required this.image, required this.name, required this.description});
}

class CardWidget extends StatelessWidget {
  final CarBrand carBrand;

  CardWidget({required this.carBrand});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              carBrand.image,
              width: double.infinity,
              height: 200.0,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0),
            Text(
              carBrand.name,
              style: TextStyle(
                fontSize: 35.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleLarge!.color,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0),
            Text(
              carBrand.description,
              style: TextStyle(
                fontSize: 20.0,
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
