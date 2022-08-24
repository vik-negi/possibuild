import 'package:flutter/material.dart';
import 'package:possi_build/components/userOptions.dart';
import 'package:possi_build/models/userModel.dart';
import 'package:possi_build/screens/SigninPage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({
    Key? key,
    this.userModel,
    this.userData,
  }) : super(key: key);
  final UserModel? userModel;
  final Map? userData;
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 210,
                child: Stack(
                  children: [
                    Container(
                      height: 150,
                      color: Colors.purple,
                    ),
                    const Positioned(
                      top: 100,
                      left: 25,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: NetworkImage(
                              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQI5AIyuub1fFa92zVOo09Tlsr5vguctsBAjg&usqp=CAU"),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 120,
                      left: 150,
                      child: Text(
                        "${widget.userModel!.firstName.substring(0, 1).toUpperCase()}${widget.userModel!.firstName.substring(1)} ${widget.userModel!.lastName}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 155,
                      left: 150,
                      child: Text(
                        widget.userModel!.email,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: Column(
                    children: [
                      const UserOptions(
                        icon: Icons.verified_user,
                        title: 'Credit Details',
                      ),
                      const UserOptions(
                        icon: Icons.verified_user,
                        title: 'Account Setting',
                      ),
                      const UserOptions(
                        icon: Icons.location_history,
                        title: 'Invite Your Friends',
                      ),
                      const UserOptions(
                        icon: Icons.message,
                        title: 'Support',
                      ),
                      const UserOptions(
                        icon: Icons.info,
                        title: 'About Us',
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignIn()),
                                (route) => false);
                          },
                          child: const ListTile(
                            tileColor: Colors.white,
                            leading: Icon(
                              Icons.logout,
                              color: Color.fromRGBO(255, 99, 99, 1),
                            ),
                            title: Text("Logout",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromRGBO(255, 99, 99, 1),
                                    fontWeight: FontWeight.w500)),
                            trailing: Icon(Icons.arrow_right_sharp,
                                color: Colors.redAccent, size: 30),
                          ),
                        ),
                      )
                    ],
                  )),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



// class UpgradeSection extends StatelessWidget {
//   const UpgradeSection({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             const Icon(
//               CupertinoIcons.up_arrow,
//               size: 30,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Text("Upgrade your Account!",
//                       style: TextStyle(
//                           fontSize: 18,
//                           // color: Colors.white,
//                           fontWeight: FontWeight.w600)),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text("Get Unlimited Premium Account For More Discount.",
//                       style: TextStyle(
//                           fontSize: 11,
//                           // color: Colors.white,
//                           fontWeight: FontWeight.w300)),
//                 ],
//               ),
//             )
//           ],
//         ),
//         const SizedBox(
//           height: 15,
//         ),
//         ElevatedButton(
//           onPressed: () async {
//             // await Navigator.of(context).pushNamed(MyRoutes.exploreRoute);
//           },
//           style: ElevatedButton.styleFrom(
//             textStyle:
//                 const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
//             primary: const Color.fromARGB(255, 234, 171, 0),
//             // padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 80),
//             minimumSize: const Size(300, 50),
//           ),
//           child: const Text("Upgrade Now"),
//         ),
//       ],
//     );
//   }
// }
