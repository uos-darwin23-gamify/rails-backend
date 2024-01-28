<script lang="ts">
	import AdminDashboardUrls from '$lib/enums/AdminDashboardUrls';
	import { createEventDispatcher } from 'svelte';
	import { Home, Swords, Users, Mails } from 'lucide-svelte';
	import { Button } from '$lib/components/ui/button';

	export let slug: string | undefined;

	const dispatch = createEventDispatcher();
</script>

<ul class="menu menu-lg p-4 min-h-full text-base-content flex-nowrap">
	<li>
		<Button
			variant={!slug ? 'secondary' : 'outline'}
			href={`/admin${AdminDashboardUrls.OVERVIEW ? '/' + AdminDashboardUrls.OVERVIEW : ''}`}
			data-testid="overview-button"
			on:click={() => dispatch('sideMenuItemClicked')}
			class="flex items-center text-sm justify-start"><Home class="h-5 w-5 mr-2" />Overview</Button
		>
	</li>
	<div class="my-1" />
	<li>
		<Button
			variant={slug === AdminDashboardUrls.CHALLENGE_EDITOR ? 'secondary' : 'outline'}
			href={`/admin${
				AdminDashboardUrls.CHALLENGE_EDITOR ? '/' + AdminDashboardUrls.CHALLENGE_EDITOR : ''
			}`}
			data-testid="challenge-editor-button"
			on:click={() => dispatch('sideMenuItemClicked')}
			class="flex items-center text-sm justify-start"
			><Swords class="h-5 w-5 mr-2" />Challenge Editor</Button
		>
	</li>
	<div class="my-1" />
	<li>
		<Button
			variant={slug === AdminDashboardUrls.USERS ? 'secondary' : 'outline'}
			href={`/admin${AdminDashboardUrls.USERS ? '/' + AdminDashboardUrls.USERS : ''}`}
			data-testid="users-button"
			on:click={() => dispatch('sideMenuItemClicked')}
			class="flex items-center text-sm justify-start"><Users class="h-5 w-5 mr-2" />Users</Button
		>
	</li>
	<div class="my-1" />
	<li>
		<Button
			variant={slug === AdminDashboardUrls.PRE_AUTHORIZED_EMAILS ? 'secondary' : 'outline'}
			href={`/admin${
				AdminDashboardUrls.PRE_AUTHORIZED_EMAILS
					? '/' + AdminDashboardUrls.PRE_AUTHORIZED_EMAILS
					: ''
			}`}
			data-testid="pre-authorized-emails-button"
			on:click={() => dispatch('sideMenuItemClicked')}
			class="flex items-center text-sm justify-start"
			><Mails class="h-5 w-5 mr-2" />Pre-Authorized Emails</Button
		>
	</li>
</ul>
