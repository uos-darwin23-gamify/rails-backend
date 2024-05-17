<script lang="ts">
	import '../global.pcss';
	import { monaco } from '$lib/stores';
	import { onMount } from 'svelte';
	import { dev } from '$app/environment';
	import { PUBLIC_SENTRY_DSN } from '$env/static/public';

	// $: $socketConnection;
	$: $monaco;

	onMount(async () => {
		if (!dev) {
			const Sentry = await import('@sentry/svelte');
			Sentry.init({
				dsn: PUBLIC_SENTRY_DSN,

				// This sets the sample rate to be 10%. You may want this to be 100% while
				// in development and sample at a lower rate in production
				replaysSessionSampleRate: 0.0,

				// If the entire session is not sampled, use the below sample rate to sample
				// sessions when an error occurs.
				replaysOnErrorSampleRate: 1.0,

				integrations: [
					Sentry.replayIntegration({
						// Additional SDK configuration goes in here, for example:
						// maskAllText: true,
						// blockAllMedia: true,
						// maskAllInputs: true
						maskAllText: false,
						blockAllMedia: false,
						maskAllInputs: false
					})
				]
			});
		}
	});
</script>

<slot />
