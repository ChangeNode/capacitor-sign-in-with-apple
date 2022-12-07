# capacitor-sign-in-with-apple

Native Sign In With Apple CapacitorJS Plugin

## Install

```bash
npm install capacitor-sign-in-with-apple
npx cap sync
```

## API

<docgen-index>

* [`auth()`](#auth)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### auth()

```typescript
auth() => Promise<{ response: SignInWithAppleSuccess | any; }>
```

**Returns:** <code>Promise&lt;{ response: any; }&gt;</code>

--------------------


### Interfaces


#### SignInWithAppleSuccess

| Prop                    | Type                |
| ----------------------- | ------------------- |
| **`user`**              | <code>string</code> |
| **`state`**             | <code>string</code> |
| **`email`**             | <code>string</code> |
| **`givenName`**         | <code>string</code> |
| **`familyName`**        | <code>string</code> |
| **`identityToken`**     | <code>string</code> |
| **`authorizationCode`** | <code>string</code> |

</docgen-api>
