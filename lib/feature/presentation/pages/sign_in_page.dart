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

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {


  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldGlobalKey = GlobalKey<ScaffoldState>();


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldGlobalKey,
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
            snackBarError(msg: "invalid email",scaffoldState: _scaffoldGlobalKey);
          }
        },
      )
    );
  }

  _bodyWidget() {
    return Container(
      padding: EdgeInsets.all(25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          Container(height: 120, child: Image.asset("assets/notebook.png"),),
          SizedBox(
            height: 40,
          ),
         TextFormFieldRegister(
           controller: _emailController,
           hintText: 'Enter your email',
         ),

          SizedBox(
            height: 10,
          ),
          TextFormFieldRegister(
            controller: _passwordController,
            hintText: "Enter your Password",
            obscureText: true,
          ),

          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              submitSignIn();
            },
            child: ContainerButtonWidget(
              color: Colors.deepOrange.withOpacity(.8),
              texto: "Login",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(context, PageConst.signUpPage, (route) => false);
            },

            child:
              ContainerButtonWidget(
                color: Colors.grey.withOpacity(.8),
                texto: "Sign Up",
              ),

          ),
        ],
      ),
    );
  }

  void submitSignIn() {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context).submitSignIn(user: UserEntity(
        email: _emailController.text,
        password: _passwordController.text,
      ));
    }
  }
}



