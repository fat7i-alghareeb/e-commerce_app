import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthServices {
  Future<User> logInWithEmailAndPassword({
    required String emailAddress,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      } else {
        throw Exception("An error occurred. Please try again");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User> createUserWithEmailAndPassword({
    required String emailAddress,
    required String password,
    required String userName,
  }) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      await credential.user?.updateDisplayName(userName);
      credential.user?.reload();
      final user = FirebaseAuth.instance.currentUser;
      await sendVerificationEmail();
      return user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      } else {
        throw Exception("An error occurred. Please try again");
      }
    } catch (e) {
      throw Exception("An unexpected error occurred: ${e.toString()}");
    }
  }

  Future<User> signInWithGoogle() async {
    await GoogleSignIn().signOut();
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return userCredential.user!;
  }

  Future<void> sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      } else {
        throw Exception("User is already verified or not logged in.");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'too-many-requests') {
        throw Exception("Too many requests. Please try again later.");
      } else {
        throw Exception("Failed to send verification email. Please try again.");
      }
    } catch (e) {
      throw Exception("An unexpected error occurred: ${e.toString()}");
    }
  }
}
