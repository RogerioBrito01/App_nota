


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynote/feature/presentation/widgets/textFormField.dart';
import 'package:mynote/feature/domain/entities/user_entity.dart';
import 'package:mynote/feature/presentation/cubit/auth/auth_cubit.dart';
import 'package:mynote/feature/presentation/cubit/user/user_cubit.dart';
import 'package:mynote/feature/presentation/widgets/common.dart';
import 'package:mynote/feature/presentation/widgets/container_button_widget.dart';

import '../../../app_const.dart';
import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


    final _formlKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();



  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
        body: BlocConsumer<UserCubit,UserState>(
          builder: (context,userState){

            if (userState is UserSuccess){
              return BlocBuilder<AuthCubit,AuthState>(builder:(context,authState){

                if (authState is Authenticated){
                  return HomePage(uid: authState.uid,);
                }else{
                  return _bodyWidget();
                }
              });
            }

            return _bodyWidget();
          },
          listener: (context,userState){
            if (userState is UserSuccess){
              BlocProvider.of<AuthCubit>(context).loggedIn();
            }
            if (userState is UserFailure){
              snackBarError(msg: "cadastro envalido",scaffoldState: _globalKey);
            }
          },
        )
    );
  }

  _bodyWidget() {

    return Container(
      padding: EdgeInsets.all(25),
      child: Form(
        key: _formlKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(context, PageConst.signInPage, (route) => false);
              },
              child: Container(
                height: 50,
                width: 50,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black.withOpacity(.6)),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_back_ios),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            TextFormFieldRegister(
              controller: _usernameController,
              hintText: "Username",
              obscureText: false,

             // ),
              validator: (valor){
                if(valor!.isEmpty) {
                  return "Required field ";
                }
                return null;
              },
            ),

            SizedBox(
              height: 10,
            ),
            TextFormFieldRegister(
              controller: _emailController,
              hintText: "Enter your email",
              obscureText: false,
              validator: (valor){
                if(valor!.isNotEmpty&& valor.contains("@")){
                  return null;
                }if(valor.isEmpty){
                  return "Required field ";
                }
                return "enter a valid email with @";
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormFieldRegister(
              controller: _passwordController,
              hintText: "Enter your Password",
              obscureText: true,
              validator: (valor){
                if(valor!.length <6){
                  return "Required field! minimum of 6 characters";
                }
                return null;
              },
            ),

            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: (){
                submitSignIn();
                _formlKey.currentState!.validate();
              },
              child: ContainerButtonWidget(
               texto: "Create New Account",
                color: Colors.green,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),

      )
    );
  }

  void submitSignIn() {
    if (_usernameController.text.isNotEmpty &&_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context).submitSignUp(user: UserEntity(
        email: _emailController.text,
        password: _passwordController.text,
      )
      );
    }
  }
}
