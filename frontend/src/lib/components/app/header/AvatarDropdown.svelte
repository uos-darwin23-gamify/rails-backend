<script lang="ts">
	import * as DropdownMenu from '$lib/components/ui/dropdown-menu';
	import * as Avatar from '$lib/components/ui/avatar';
	import { Button } from '$lib/components/ui/button';
	import { goto } from '$app/navigation';
	import { logOut } from '$lib/auth';
	import { authenticated } from '$lib/stores';
	import { onMount } from 'svelte';
	import { page } from '$app/stores';

	let username: string;
	let placementChallengesFinished: boolean;
	let group: 'league' | 'global' | 'admin_group' = 'admin_group';
	let stats: any;
	let error = false;
	let challengesAvailable = false;

	const handleLogout = async () => {
		const logoutSuccessful = await logOut();
		logoutSuccessful && authenticated.verify();
	};

	const getData = async () => {
		const response = await fetch('/api/leaderboard/avatar-dropdown-info');

		if (!response.ok) {
			username = 'Failed To Fetch';
			error = true;
		} else {
			const data = await response.json();
			username = data.username;
			placementChallengesFinished = data.placement_challenges_finished;
			group = data.group;

			if (placementChallengesFinished) {
				if (data.group === 'league' || data.group === 'global') {
					stats = data.stats;
				}
			}
		}
	};

	const getChallengesAvailable = async () => {
		const response = await fetch('/api/challenges-available');

		if (!response.ok) {
			error = true;
		} else {
			const data = await response.json();
			challengesAvailable = data.available;
		}
	};

	let unsubscribe: () => void;

	onMount(() => {
		getData();
		getChallengesAvailable();
		unsubscribe = page.subscribe(() => {
			getData();
			getChallengesAvailable();
		});

		return () => unsubscribe();
	});
</script>

<DropdownMenu.Root>
	<DropdownMenu.Trigger asChild let:builder>
		<Button variant="ghost" builders={[builder]} class="relative h-8 w-8 rounded-full mx-1">
			<Avatar.Root class="h-10 w-10">
				{#if !error}
					<Avatar.Fallback class={challengesAvailable ? 'bg-green-900' : ''}
						>{username?.replace(/[^A-Z]/g, '').slice(0, 2)}</Avatar.Fallback
					>
				{:else}
					<Avatar.Fallback>?</Avatar.Fallback>
				{/if}
			</Avatar.Root>
		</Button>
	</DropdownMenu.Trigger>
	<DropdownMenu.Content class="w-56" align="end">
		<DropdownMenu.Label class="font-normal">
			<div class="flex flex-col space-y-1">
				<p class="text-sm font-medium leading-none">{username}</p>
				<p class="text-xs leading-none text-muted-foreground">@{username}</p>
			</div>
		</DropdownMenu.Label>
		{#if challengesAvailable}
			<DropdownMenu.Separator />
			<DropdownMenu.Item
				class="font-normal cursor-pointer bg-green-900"
				on:click={() => goto('/app/challenges')}>New Challenges Available!</DropdownMenu.Item
			>
		{/if}
		<DropdownMenu.Separator />
		<DropdownMenu.Item class="font-normal cursor-pointer" on:click={() => goto('/app')}>
			{#if !error}
				{#if group !== 'admin_group'}
					{#if placementChallengesFinished}
						{#if group === 'league'}
							<div class="flex flex-col space-y-1">
								<p class="text-sm font-medium leading-none">Statistics</p>
								<p class="text-xs leading-none text-muted-foreground">
									Score:<br />{stats.elo}
								</p>
								<p class="text-xs leading-none text-muted-foreground">
									League:<br />{stats.user_league}
								</p>
								<p class="text-xs leading-none text-muted-foreground">
									Position in league:<br />{stats.user_position} out of {stats.total_players_in_league}
								</p>
							</div>
						{:else if group === 'global'}
							<div class="flex flex-col space-y-1">
								<p class="text-sm font-medium leading-none">Statistics</p>
								<p class="text-xs leading-none text-muted-foreground">
									ELO:<br />{stats.elo}
								</p>
								<p class="text-xs leading-none text-muted-foreground">
									Position on leaderboard:<br />{stats.user_position} out of {stats.total_players}
								</p>
							</div>
						{/if}
					{:else}
						<div class="flex flex-col space-y-1">
							<p class="text-sm font-medium leading-none">Statistics</p>
							<p class="text-xs leading-none text-muted-foreground">
								Finish all placement challenges to view your statistics.
							</p>
						</div>
					{/if}
				{:else}
					<div class="flex flex-col space-y-1">
						<p class="text-xs leading-none text-muted-foreground">
							Your are an admin<br />No statistics available
						</p>
					</div>
				{/if}
			{:else}
				<div class="flex flex-col space-y-1">
					<p class="text-xs leading-none text-muted-foreground">Failed To Fetch</p>
				</div>
			{/if}
		</DropdownMenu.Item>
		<DropdownMenu.Separator />
		<DropdownMenu.Group>
			<DropdownMenu.Item class="cursor-pointer" on:click={() => goto('/app/settings')}
				>Settings</DropdownMenu.Item
			>
			<DropdownMenu.Item class="cursor-pointer" on:click={handleLogout}>Log out</DropdownMenu.Item>
		</DropdownMenu.Group>
	</DropdownMenu.Content>
</DropdownMenu.Root>
