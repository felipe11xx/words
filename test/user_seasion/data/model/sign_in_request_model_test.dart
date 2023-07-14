import 'package:flutter_test/flutter_test.dart';
import 'package:words/user_session/auth/data/model/sing_in_request.dart';

main(){

  late SignInRequest signInRequest;

  test("Should be return SignInRequest class Instance", () async
  {
    signInRequest = SignInRequest(password: '123456',email: 'user@user.com', );

    expect(signInRequest.email,'user@user.com');
    expect(signInRequest.password, '123456');
  });


}
