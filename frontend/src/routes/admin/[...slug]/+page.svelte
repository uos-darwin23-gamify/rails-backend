<script lang="ts">
	import Header from '$lib/components/admin/header/Header.svelte';
	import SideMenu from '$lib/components/admin/sidemenu/SideMenu.svelte';
	import AdminDashboardUrls from '$lib/enums/AdminDashboardUrls.js';
	import ChallengeEditor from '$lib/components/admin/main/challenge-editor/ChallengeEditor.svelte';
	import Users from '$lib/components/admin/main/users/Users.svelte';
	import PreAuthorizedEmails from '$lib/components/admin/main/pre-authorized-emails/PreAuthorizedEmails.svelte';
	import type { SvelteComponent } from 'svelte';
	import { onMount } from 'svelte';
	import { goto } from '$app/navigation';
	import NewChallenge from '$lib/components/admin/main/challenge-editor/new-challenge/NewChallenge.svelte';
	import EditChallenge from '$lib/components/admin/main/challenge-editor/edit-challenge/EditChallenge.svelte';

	export let data;
	let menuClosed = true;
	// eslint-disable-next-line @typescript-eslint/no-explicit-any
	let mainComponent: (new (...args: any[]) => SvelteComponent) | null = null;

	$: {
		switch (data.slug) {
			case AdminDashboardUrls.CHALLENGE_EDITOR:
				mainComponent = ChallengeEditor;
				break;
			case AdminDashboardUrls.CHALLENGE_EDITOR_NEW_CHALLENGE:
				mainComponent = NewChallenge;
				break;
			case AdminDashboardUrls.CHALLENGE_EDITOR_EDIT_CHALLENGE:
				mainComponent = EditChallenge;
				break;
			case AdminDashboardUrls.USERS:
				mainComponent = Users;
				break;
			case AdminDashboardUrls.PRE_AUTHORIZED_EMAILS:
				mainComponent = PreAuthorizedEmails;
				break;
			default:
				goto('/admin/' + AdminDashboardUrls.CHALLENGE_EDITOR);
				break;
		}
	}

	let headerHeight = 64;

	onMount(() => {
		const header = document.getElementById('admin-header');
		const height = header?.offsetHeight;
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
