<script lang="ts">
	import Header from '$lib/components/app/header/Header.svelte';
	import SideMenu from '$lib/components/app/sidemenu/SideMenu.svelte';
	import AppUrls from '$lib/enums/AppUrls';
	import Home from '$lib/components/app/main/home/Home.svelte';
	import Challenges from '$lib/components/app/main/challenges/Challenges.svelte';
	import Challenge from '$lib/components/app/main/challenge/Challenge.svelte';
	import Settings from '$lib/components/app/main/settings/Settings.svelte';
	import type { SvelteComponent } from 'svelte';
	import { onMount } from 'svelte';
	import { page } from '$app/stores';

	export let data;
	let menuClosed = true;
	// eslint-disable-next-line @typescript-eslint/no-explicit-any
	let mainComponent: (new (...args: any[]) => SvelteComponent) | null = null;

	$: {
		switch (data.slug) {
			case AppUrls.CHALLENGES:
				const challengeId = $page.url.searchParams.get('id');
				if (challengeId !== null) {
					mainComponent = Challenge;
				} else {
					mainComponent = Challenges;
				}
				break;
			case AppUrls.SETTINGS:
				mainComponent = Settings;
				break;
			default:
				mainComponent = Home;
				break;
		}
	}

	let headerHeight = 64;

	onMount(() => {
		const header = document.getElementById('app-header');
		const height = header?.getBoundingClientRect().height;
		if (height !== undefined) {
			headerHeight = height;
		}
	});
</script>

<Header bind:menuClosed />
<div class="relative flex" style={`height: calc(100% - ${headerHeight}px);`}>
	<div class="overflow-y-auto shrink-0">
		<SideMenu bind:menuClosed slug={data.slug} />
	</div>
	<!-- svelte-ignore a11y-no-static-element-interactions -->
	<!-- svelte-ignore a11y-click-events-have-key-events -->
	<div
		class="relative flex grow bg-base-300 md:brightness-100 overflow-x-hidden"
		class:brightness-50={!menuClosed}
		on:click={() => (menuClosed = true)}
	>
		<svelte:component this={mainComponent} />
		{#if !menuClosed}
			<div class="absolute w-full h-full md:hidden backdrop-blur" />
		{/if}
	</div>
</div>
