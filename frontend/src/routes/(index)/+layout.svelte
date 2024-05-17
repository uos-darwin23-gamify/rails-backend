<script lang="ts">
	import { authenticated } from '$lib/stores';
	import { scale } from 'svelte/transition';
	import UserType from '$lib/enums/UserType';
	import { onMount } from 'svelte';
	// import { socketConnection } from '$lib/stores';
	import { Button } from '$lib/components/ui/button';

	onMount(async () => {
		await authenticated.verify();
		// socketConnection.reset();
		// $socketConnection.on('user-type', ({ userType }) => console.log(userType));
	});
	$: loading = $authenticated === null;
	$: {
		switch ($authenticated) {
			case UserType.USER:
				window.location.href = '/app';
				break;
			case UserType.ADMIN:
				window.location.href = '/admin';
				break;
			default:
				break;
		}
	}
</script>

<svelte:head>
	<title>GamifyCoding&#8482;</title>
</svelte:head>

<main class="h-dvh w-dvw flex">
	{#if loading}
		<div class="grow flex items-center justify-center">
			<span class="loading loading-infinity loading-lg" />
		</div>
	{:else}
		<div
			class="flex flex-col grow overflow-x-hidden relative"
			in:scale={{ start: 0.9, duration: 500, opacity: 0 }}
		>
			<header
				id="welcome-header"
				class="p-2 flex items-center justify-between sticky top-0 z-50 w-full border-b border-border/40 bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60"
			>
				<Button variant="outline" href="/">GamifyCoding&#8482;</Button>
				<Button href="/login">Open App</Button>
			</header>
			<slot />
		</div>
	{/if}
</main>
