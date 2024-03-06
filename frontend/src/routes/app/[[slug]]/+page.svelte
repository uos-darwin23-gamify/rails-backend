<script lang="ts">
	import Header from '$lib/components/app/header/Header.svelte';
	import SideMenu from '$lib/components/app/sidemenu/SideMenu.svelte';
	import AppUrls from '$lib/enums/AppUrls';
	import Challenges from '$lib/components/app/main/challenges/Challenges.svelte';
	import Challenge from '$lib/components/app/main/challenge/Challenge.svelte';
	import Settings from '$lib/components/app/main/settings/Settings.svelte';
	import Leaderboard from '$lib/components/app/main/leaderboard/Leaderboard.svelte';
	import Guide from '$lib/components/app/main/guide/Guide.svelte';
	import Help from '$lib/components/app/main/help/Help.svelte';
	import type { SvelteComponent } from 'svelte';
	import { onMount } from 'svelte';
	import { page } from '$app/stores';
	import { goto } from '$app/navigation';

	export let data;
	let menuClosed = true;
	// eslint-disable-next-line @typescript-eslint/no-explicit-any
	let mainComponent: (new (...args: any[]) => SvelteComponent) | null = null;
	let pageTitle = '';

	onMount(async () => {
		const response = await fetch('/api/consent');

		if (response.ok) {
			const consent = (await response.json()).consent;
			!consent && goto('/app/consent');
		} else {
			console.error('Failed to fetch');
		}
	});

	$: {
		switch (data.slug) {
			case AppUrls.GUIDE:
				mainComponent = Guide;
				pageTitle = 'Guide';
				break;
			case AppUrls.HELP:
				mainComponent = Help;
				pageTitle = 'Help';
				break;
			case AppUrls.CHALLENGES:
				const challengeId = $page.url.searchParams.get('id');
				if (challengeId !== null) {
					mainComponent = Challenge;
					pageTitle = 'Challenge';
				} else {
					mainComponent = Challenges;
					pageTitle = 'Challenges';
				}
				break;
			case AppUrls.SETTINGS:
				mainComponent = Settings;
				pageTitle = 'Settings';
				break;
			default:
				mainComponent = Leaderboard;
				pageTitle = 'Leaderboard';
				break;
		}
	}

	let headerHeight = 64;

	onMount(() => {
		const header = document.getElementById('app-header');
		const height = header?.offsetHeight;
		if (height !== undefined) {
			headerHeight = height;
		}
	});
</script>

<svelte:head>
	<title>{pageTitle}</title>
</svelte:head>

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
