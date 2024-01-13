<script lang="ts">
	import AdminDashboardUrls from '$lib/enums/adminDashboardUrls';
	import { createEventDispatcher } from 'svelte';
	import { Home, Users, Mails } from 'lucide-svelte';

	export let slug: string | undefined;

	const dispatch = createEventDispatcher();
</script>

<ul class="menu menu-lg p-4 min-h-full text-base-content flex-nowrap">
	<li>
		<a
			class:font-semibold={!slug}
			class:active={!slug}
			href={`/admin${AdminDashboardUrls.OVERVIEW ? '/' + AdminDashboardUrls.OVERVIEW : ''}`}
			data-testid="overview-button"
			on:click={() => dispatch('sideMenuItemClicked')}
			class="flex items-center text-sm"><Home class="h-5 w-5 mr-2" />Overview</a
		>
	</li>
	<div class="my-1" />
	<li>
		<a
			class:font-semibold={slug === AdminDashboardUrls.USERS}
			class:active={slug === AdminDashboardUrls.USERS}
			href={`/admin${AdminDashboardUrls.USERS ? '/' + AdminDashboardUrls.USERS : ''}`}
			data-testid="users-button"
			on:click={() => dispatch('sideMenuItemClicked')}
			class="flex items-center text-sm"><Users class="h-5 w-5 mr-2" />Users</a
		>
	</li>
	<div class="my-1" />
	<li>
		<a
			class:font-semibold={slug === AdminDashboardUrls.PRE_AUTHORIZED_EMAILS}
			class:active={slug === AdminDashboardUrls.PRE_AUTHORIZED_EMAILS}
			href={`/admin${
				AdminDashboardUrls.PRE_AUTHORIZED_EMAILS
					? '/' + AdminDashboardUrls.PRE_AUTHORIZED_EMAILS
					: ''
			}`}
			data-testid="pre-authorized-emails-button"
			on:click={() => dispatch('sideMenuItemClicked')}
			class="flex items-center text-sm"><Mails class="h-5 w-5 mr-2" />Pre-Authorized Emails</a
		>
	</li>
</ul>
