import 'package:duas/controller/login_screen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginScreen extends GetView<LoginScreenController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          // appBar: AppBar(
          //   title: Text('${controller.screenName}'),
          // ),

          body: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 25,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                child: Text(
                  '',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Text(
                    'Dua',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Communication',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    const Text(
                      '.',
                      style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 60),
              TextField(
                controller: controller.name,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.email), hintText: 'Email'),
              ),
              TextField(
                controller: controller.password,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.password), hintText: 'Password'),
              ),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  controller.login();
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  elevation: 10,
                  shadowColor: const Color(0xff084379),
                  child: Container(
                    height: 50,
                    width: Get.width,
                    decoration: BoxDecoration(
                        color: const Color(0xff084379),
                        gradient: const LinearGradient(colors: [
                          Color(0xff0a2141),
                          Color(0xff092b51),
                          Color(0xff084379),
                        ]),
                        borderRadius: BorderRadius.circular(30)),
                    child: const Center(
                        child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
