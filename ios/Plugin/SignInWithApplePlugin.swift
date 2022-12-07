import Foundation
import Capacitor
import AuthenticationServices

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(SignInWithApplePlugin)
public class SignInWithApplePlugin: CAPPlugin {
    var call: CAPPluginCall?

    @objc func auth(_ call: CAPPluginCall) {
        self.call = call

        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]

            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.performRequests()
        } else {
            call.reject("Sign in with Apple is available on iOS 13.0+ only.")
        }
    }
}

@available(iOS 13.0, *)
extension SignInWithApplePlugin: ASAuthorizationControllerDelegate {
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            call?.reject("Please, try again.")

            return
        }

        var result: [String: String] = [:]

        result["user"] = appleIDCredential.user;
        result["state"] = appleIDCredential.state;
        result["email"] = appleIDCredential.email;
        //result["realUserStatus"] = appleIDCredential.realUserStatus;
        result["givenName"] = appleIDCredential.fullName?.givenName;
        result["familyName"] = appleIDCredential.fullName?.familyName;
        result["identityToken"] = String(data: appleIDCredential.identityToken!, encoding: .utf8);
        result["authorizationCode"] =  String(data: appleIDCredential.authorizationCode!, encoding: .utf8);

        call?.resolve(result)
    }

    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        call?.reject(error.localizedDescription, nil, error)
    }
}
