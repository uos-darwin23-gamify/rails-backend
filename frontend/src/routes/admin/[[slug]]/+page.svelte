<script lang="ts">
	import Header from '$lib/components/admin/header/Header.svelte';
	import SideMenu from '$lib/components/admin/sidemenu/SideMenu.svelte';
	import AdminDashboardUrls from '$lib/enums/adminDashboardUrls.js';
	import Overview from '$lib/components/admin/main/overview/Overview.svelte';
	import Users from '$lib/components/admin/main/users/Users.svelte';
	import PreAuthorizedEmails from '$lib/components/admin/main/preauthorizedemails/PreAuthorizedEmails.svelte';
	import type { SvelteComponent } from 'svelte';
	import { onMount } from 'svelte';

	export let data;
	let menuClosed = true;
	// eslint-disable-next-line @typescript-eslint/no-explicit-any
	let mainComponent: (new (...args: any[]) => SvelteComponent) | null = null;

	$: {
		switch (data.slug) {
			case AdminDashboardUrls.USERS:
				mainComponent = Users;
				break;
			case AdminDashboardUrls.PRE_AUTHORIZED_EMAILS:
				mainComponent = PreAuthorizedEmails;
				break;
			default:
				mainComponent = Overview;
				break;
		}
	}

	let headerHeight = 64;

	onMount(() => {
		const header = document.getElementById('admin-header');
		const height = header?.getBoundingClientRect().height;
		if (height !== undefined) {
			headerHeight = height;
		}
	});
</script>

<Header bind:menuClosed />
<div class="relative flex grow" style={`height: calc(100% - ${headerHeight}px);`}>
	<div class="overflow-y-auto">
		<SideMenu bind:menuClosed slug={data.slug} />
	</div>
	<!-- svelte-ignore a11y-no-static-element-interactions -->
	<!-- svelte-ignore a11y-click-events-have-key-events -->
	<div
		class="relative flex grow bg-base-200 md:brightness-100 overflow-x-hidden"
		class:brightness-50={!menuClosed}
		class:backdrop-blur={!menuClosed}
		on:click={() => (menuClosed = true)}
	>
		{#if !menuClosed}
			<div class="absolute w-full h-full md:hidden backdrop-blur" />
		{/if}
		<svelte:component this={mainComponent} />
	</div>
</div>
