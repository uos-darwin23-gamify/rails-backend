<script lang="ts">
	import { authenticated } from '$lib/stores';
	import { onMount } from 'svelte';
	import { scale } from 'svelte/transition';
	import UserType from '$lib/enums/UserType';
	import { socketConnection } from '$lib/stores';

	onMount(async () => {
		await authenticated.verify();
		socketConnection.reset();
		$socketConnection.on('user-type', ({ userType }) => console.log(userType));
	});
	$: loading = $authenticated === null;
	$: {
		switch ($authenticated) {
			case false:
				window.location.href = '/login';
				break;
			case UserType.USER:
				window.location.href = '/app';
				break;
			default:
				break;
		}
	}
</script>

<svelte:head>
	<title>Admin Dashboard</title>
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
			<slot />
		</div>
	{/if}
</main>
