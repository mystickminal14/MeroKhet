import 'package:flutter/material.dart';

class CustomHeaderDash extends StatefulWidget {
  final String title,route;
  const CustomHeaderDash({super.key, required this.title, required this.route});

  @override
  State<CustomHeaderDash> createState() => _CustomHeaderDashState();
}

class _CustomHeaderDashState extends State<CustomHeaderDash> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(0), // Add margin for spacing
              child: const Image(
                image: AssetImage('assets/Leaf.png'),
                fit: BoxFit.cover,
                width: 70,
                height: 70,
              ),
            ),
            Text(
              widget.title,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'poppins-semi',
                  fontWeight: FontWeight.w400,
                  fontSize: 16),
            ),
            const SizedBox(
              width: 4,
            ),
            IconButton(onPressed: (){
              Navigator.pushReplacementNamed(context, widget.route);
    }, icon:const Icon(Icons.arrow_back_ios_new_sharp))
            // const CircleAvatar(
            //   foregroundImage: AssetImage('assets/F.jpg'),
            //   maxRadius: 20,
            // ),
          ],
        ),
        const Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: TextField(
              style:
                  TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontFamily: 'poppins',
                    fontWeight: FontWeight.w400),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.8,
                      color: Colors.black,
                      style: BorderStyle.solid,
                      strokeAlign: BorderSide.strokeAlignCenter,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1.8,
                      color: Colors.black,
                      style: BorderStyle.solid,
                      strokeAlign: BorderSide.strokeAlignCenter,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
            ))
      ],
    );
  }
}
