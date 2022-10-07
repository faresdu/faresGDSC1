import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stacked/stacked.dart';
import 'login_viewmodel.dart';

class LoginView extends HookConsumerWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, viewmodel, _) => _getContentWidget(),
    );
  }

  Widget _getContentWidget() {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              const SizedBox(height: 90),
              Image.asset('assets/images/logo.png'),
              const SizedBox(height: 65),
              TextField(
                style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'الإيميل الجامعي أو الرقم الجامعي',
                  hintStyle: TextStyle(
                    fontFamily: GoogleFonts.mada().fontFamily,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'كلمة المرور',
                  hintStyle: TextStyle(
                    fontFamily: GoogleFonts.mada().fontFamily,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                ),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment(-1, 0),
                child: Text('نسيت كلمة المرور', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
              ),
              const SizedBox(height: 100),
              Container(
                width: double.infinity,
                height: 45,
                margin: const EdgeInsets.symmetric(horizontal: 90),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF4081EC)),
                  child: const Text('سجل الدخول'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
