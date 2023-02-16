
As of 2/15/2023, here is the test setup I'm using to create and validate the app.

# NPM

Install npm.

# SvelteKit

Create a SvelteKit project.

https://kit.svelte.dev/

```bash
npm create svelte@latest my-app
cd my-app
npm install
npm run dev -- --open
```

I chose Skeleton project, TypeScript, ESLint, and Prettier.

# Configure SvelteKit to act as SPA Only

https://changenode.com/articles/sveltekit-wcapacitorjs

`npm add @sveltejs/adapter-static@latest`

Update the svelte.config.js file to:

```js
import adapter from '@sveltejs/adapter-static';
import { vitePreprocess } from '@sveltejs/kit/vite';

/** @type {import('@sveltejs/kit').Config} */
const config = {
	// Consult https://kit.svelte.dev/docs/integrations#preprocessors
	// for more information about preprocessors
	preprocess: vitePreprocess(),

	kit: {
		adapter: adapter(
			{
				// default options are shown. On some platforms
				// these options are set automatically — see below
				pages: 'build',
				assets: 'build',
				fallback: null,
				precompress: false,
				strict: true
			  }
		)
	}
};

export default config;
```

Add a /src/routes/+layout.js file:

```js
export const prerender = true;
```

Verify static is working by running `npm run build`. You should see output that finishes with:

```
> Using @sveltejs/adapter-static
Wrote site to "build"
✔ done
```

# Capacitor

https://capacitorjs.com/solution/svelte

`npx cap init TestApp com.example.testapp --web-dir=build`

This will setup the capactior.config.ts file.

`npm i @capacitor/ios @capacitor/android`

Adds both targets to the package.json file.

`npx cap add android`

Adds configuration and initial Android build.

`npx cap add ios`

Adds configuration and initial iOS build.

# Add ChangeNode Sign In With Apple

https://github.com/ChangeNode/capacitor-sign-in-with-apple

```
npm install @changenode/capacitor-sign-in-with-apple
npx cap sync
```

Verify that the app builds and runs with `npx cap run ios`.

Change the contents of /src/routes/+page.svelte to as follows:

```html
<script lang="ts">
	import { Capacitor } from '@capacitor/core';
	
	import { SignInWithApple } from '@changenode/capacitor-sign-in-with-apple';
	
	let device: any;
	let r: any;
	let e: any;
	
	async function auth() {
		device = Capacitor.getPlatform();
		
		SignInWithApple.auth()
		.then((response: any) => {
			console.log(response);
			r = response;
		})
		.catch((response: any) => {
			console.error(response);
			e = response;
		});
	}
	
	auth();
</script>

<h1>Fancy App</h1>
<p>This is pretty darn fancy.</p>
<button on:click={auth}>Sign In With Apple</button>
<textarea bind:value={r} />
<textarea bind:value={e} />
		
<style>
	button {display: block; width: 100%;}
	textarea {display: block; width: 100%;}
</style>

```

npm run build
npx cap run ios

Now, you should see the following error in the error box:

```
Error: The operation couldn’t be completed. (com.apple.AuthenticationServices.AuthorizationError error 1000.)
```
