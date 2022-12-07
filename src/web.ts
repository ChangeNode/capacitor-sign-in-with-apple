import { WebPlugin } from '@capacitor/core';

import type { SignInWithApplePlugin } from './definitions';

export class SignInWithAppleWeb
  extends WebPlugin
  implements SignInWithApplePlugin
{
  async auth(): Promise<{ response: any }> {
    console.log('ECHO', 'Not available for web');
    return new Promise(resolve => {
      resolve({ response: null })
    });
  }
}
