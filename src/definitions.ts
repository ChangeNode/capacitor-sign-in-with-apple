export interface SignInWithApplePlugin {
  auth(): Promise<{response: SignInWithAppleSuccess | any}>;
}

interface SignInWithAppleSuccess {
  user: string | undefined;
  state: string | undefined;
  email: string | undefined;
  givenName: string | undefined;
  familyName: string | undefined;
  identityToken: string | undefined;
  authorizationCode: string | undefined;
}
