import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:jackket/Homepage.dart';
import 'package:jackket/home.dart';
import 'package:jackket/login.dart';
import 'package:jackket/user/user_model.dart';
import 'package:email_auth/email_auth.dart';

class Register_Screen extends StatefulWidget {
  static String route = "register";
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  _Register_ScreenState createState() => _Register_ScreenState();
}

class _Register_ScreenState extends State<Register_Screen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  CollectionReference _userCollection =
      FirebaseFirestore.instance.collection("test");
  String? nameString, emailString, passwordString, confirmpassString, otpString;
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  late EmailAuth emailAuth;
  var submitValid;

  void sendOTP() async {
    EmailAuth.sessionName = "Test Session";
    var res = await EmailAuth.sendOtp(receiverMail: _emailController.text);
    if (res) {
      print("OTP Sent");
    } else {
      print("We could not sent the OTP");
    }
  }

  void verifyOTP() {
    var res = EmailAuth.validate(
        receiverMail: _emailController.text, userOTP: _otpController.text);
    if (res) {
      print("OTP verified");
    } else {
      print("Invalid OTP");
    }
  }

  validator() {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      print("validate");
    } else {
      print("not validate");
    }
  }

  Widget box() {
    return SizedBox(
      height: 20,
    );
  }

  Widget buildUserName() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                  icon: Icon(Icons.face),
                  labelText: "ชื่อ",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ))),
              validator: (String? value) {
                if (value == null || value.trim().length == 0) {
                  return "กรุณาระบุข้อมูล";
                } else {
                  return null;
                }
              },
              onSaved: (String? value) {
                nameString = value;
              },
            )
          ],
        ),
      ),
    );
  }

  Widget otp() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _otpController,
              decoration: InputDecoration(
                  icon: Icon(Icons.face),
                  labelText: "รหัส OTP",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Colors.white,
                      ))),
              validator: (String? value) {
                if (value == null || value.trim().length == 0) {
                  return "กรุณาระบุข้อมูล";
                }
                
                 else {
                  return null;
                }
              },
              onSaved: (String? value) {
                otpString = value;
              },
            )
          ],
        ),
      ),
    );
  }

  Widget buildEmail() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                    hintText: "name@example.com",
                    icon: Icon(Icons.email),
                    labelText: "อีเมล",
                    suffixIcon: TextButton(
                        onPressed: () => sendOTP(), child: Text("Send OTP")),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ))),
                validator: (String? value) {
                  if (value == null || value.trim().length == 0) {
                    return "กรุณาระบุข้อมูล";
                  }
                  if (!RegExp(
                          r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                      .hasMatch(value)) {
                    return "กรุณากรอกอีเมลให้ถูกต้อง";
                  }
                  return null;
                },
                onSaved: (String? value) {
                  emailString = value;
                })
          ],
        ),
      ),
    );
  }

  Widget buildPassword() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                controller: _password,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: "กรอกรหัสผ่านของคุณ...",
                    labelText: "รหัสผ่าน",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ))),
                validator: (String? value) {
                  if (value == null || value.trim().length == 0) {
                    return "กรุณาระบุข้อมูล";
                  }
                  if (value.length < 6) {
                    return "รหัสผ่านไม่ควรน้อยกว่า 6 ตัวอักษร";
                  }
                  return null;
                },
                onSaved: (String? value) {
                  passwordString = value;
                })
          ],
        ),
      ),
    );
  }

  Widget ConfirmPassword() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
                controller: _confirmpassword,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                    icon: Icon(Icons.lock),
                    hintText: "ยืนยันรหัสผ่านของคุณ...",
                    labelText: "ยืนยันรหัสผ่าน",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Colors.white,
                        ))),
                validator: (String? value) {
                  if (value == null || value.trim().length == 0) {
                    return "กรุณาระบุข้อมูล";
                  }
                  if (_password.text != _confirmpassword.text) {
                    return "กรุณากรอกรหัสผ่านให้ตรงกัน";
                  }
                  return null;
                },
                onSaved: (String? value) {
                  confirmpassString = value;
                })
          ],
        ),
      ),
    );
  }

  Future<Null> regisFirebase() async {
    await Firebase.initializeApp().then((value) async {
      print('######success######');
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailString!, password: passwordString!)
          .then((value) {
        print('Regis success');
      }).catchError((value) {});
    });
  }

  Widget regisButton2() {
    return SizedBox(
        width: 200,
        height: 50,
        child: ElevatedButton(
          onPressed: () async {
            print("You Click upload");
            if (_formKey.currentState!.validate()) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      title: otp(),
                      actions: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: ElevatedButton(
                                child: Text(
                                  "ตกลง",
                                  style: TextStyle(
                                    fontFamily: "Jasmine",
                                    color: Color(0xFF707070),
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFE5EFC1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20))),
                                ),
                                onPressed: () async {
                                  var res = EmailAuth.validate(
                                      receiverMail: _emailController.text,
                                      userOTP: _otpController.text);
                                  if (res) {
                                    print("OTP verified");
                                    _formKey.currentState?.save();
                                    _userCollection.add({
                                      "name": nameString,
                                      "email": emailString,
                                      "password": confirmpassString
                                    });
                                    print(
                                        "name = $nameString, email = $emailString, password = $passwordString , confirmpass = $confirmpassString");

                                    try {
                                      await FirebaseAuth.instance
                                          .createUserWithEmailAndPassword(
                                        email: emailString!,
                                        password: passwordString!,
                                      )
                                          .then((value) async {
                                        _formKey.currentState?.reset();
                                        print('Regis success');
                                        await value.user?.updateProfile(
                                            displayName: nameString);
                                        postDetailsToFirestore();
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(20))),
                                                title: Text(
                                                  'ลงทะเบียนเสร็จสิ้น',
                                                  style: TextStyle(
                                                    fontFamily: "Jasmine",
                                                    color: Color(0xFF707070),
                                                    fontSize: 30.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                actions: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                    children: [
                                                      ElevatedButton(
                                                        child: Text(
                                                          "เข้าสู่ระบบ",
                                                          style: TextStyle(
                                                            fontFamily: "Jasmine",
                                                            color:
                                                                Color(0xFF707070),
                                                            fontSize: 22.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary:
                                                              Color(0xFFE5EFC1),
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                              20))),
                                                        ),
                                                        onPressed: () {
                                                          Navigator
                                                              .pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    signin_Screen()),
                                                          );
                                                        },
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              );
                                            });
                                      });
                                    } on FirebaseAuthException catch (e) {
                                      print(e.code);
                                      String message = "";
                                      if (e.code == "email-already-in-use") {
                                        message = "มีอีเมลนี้ในระบบแล้ว";
                                      }
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(20))),
                                              title: Text(
                                                message,
                                                style: TextStyle(
                                                  fontFamily: "Jasmine",
                                                  color: Color(0xFF707070),
                                                  fontSize: 30.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              actions: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
                                                      child: Text(
                                                        "ตกลง",
                                                        style: TextStyle(
                                                          fontFamily: "Jasmine",
                                                          color:
                                                              Color(0xFF707070),
                                                          fontSize: 22.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        primary:
                                                            Color(0xFFE5EFC1),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius
                                                                        .circular(
                                                                            20))),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(
                                                          context,
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                
                                              ],
                                            );
                                          });
                                      //Fluttertoast.showToast(
                                      //msg: message, gravity: ToastGravity.BOTTOM);
                                    }
                                  }
                                  else {
                                     print("Invalid OTP");
                                      showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          title: Text(
                                            'รหัสผ่าน OTP ไม่ถูกต้อง',
                                            style: TextStyle(
                                              fontFamily: "Jasmine",
                                              color: Color(0xFF707070),
                                              fontSize: 30.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                          actions: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                ElevatedButton(
                                                  child: Text(
                                                    "ตกลง",
                                                    style: TextStyle(
                                                      fontFamily: "Jasmine",
                                                      color: Color(0xFF707070),
                                                      fontSize: 22.0,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                  style: ElevatedButton.styleFrom(
                                                    primary: Color(0xFFE5EFC1),
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20))),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                              ],
                                            )
                                          ],
                                        );
                                      });
                                  }
                                },
                              ),
                            ),
                            ElevatedButton(
                            child: Text(
                              "ยกเลิก",
                              style: TextStyle(
                                fontFamily: "Jasmine",
                                color: Color(0xFF707070),
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFFE5EFC1),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          ],
                        )
                      ],
                    );
                  });
            }
          },
          child: Text(
            "ลงทะเบียน",
            style: TextStyle(
                fontFamily: "Jasmine",
                color: Color(0xFF707070),
                fontSize: 30.0,
                fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
              primary: Color(0xFFE5EFC1),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)))),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                title: Text("error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              home: Scaffold(
                backgroundColor: Color(0xFF557B83),
                appBar: PreferredSize(
                  preferredSize: Size.fromHeight(70),
                  child: AppBar(
                    automaticallyImplyLeading: true,
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 15, top: 12),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          'assets/backbutton.png',
                          scale: 12,
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25))),
                    centerTitle: true,
                    backgroundColor: Color(0xff39AEA9),
                    title: Column(children: [
                      box(),
                      Text(
                        "ลงทะเบียน",
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontFamily: "Jasmine",
                            fontSize: 60.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
                  ),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30.0,
                          ),
                          buildUserName(),
                          SizedBox(
                            height: 20.0,
                          ),
                          buildEmail(),
                          SizedBox(
                            height: 20.0,
                          ),
                          buildPassword(),
                          SizedBox(
                            height: 20.0,
                          ),
                          ConfirmPassword(),
                          SizedBox(
                            height: 50.0,
                          ),
                          regisButton2()
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    UserModel userModel = UserModel(
        email: '',
        name: '',
        profileImage: '',
        uid: '',
        statusNoti: true,
        JacketName: []);
    userModel.uid = user!.uid;
    // narimetisaigopi@gmail.com
    userModel.email = user.email!;
    userModel.name = user.displayName!;

    await firebaseFirestore
        .collection("test")
        .doc(user.uid)
        .set(userModel.toMap());
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("User account created")));
  }
}
