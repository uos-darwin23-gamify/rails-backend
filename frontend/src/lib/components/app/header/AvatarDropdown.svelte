<script lang="ts">
	import * as DropdownMenu from '$lib/components/ui/dropdown-menu';
	import * as Avatar from '$lib/components/ui/avatar';
	import { Button } from '$lib/components/ui/button';
	import { goto } from '$app/navigation';
	import { logOut } from '$lib/auth';
	import { authenticated } from '$lib/stores';
	import { onMount } from 'svelte';

	let username: string;
	let error = false;

	const handleLogout = async () => {
		const logoutSuccessful = await logOut();
		logoutSuccessful && authenticated.verify();
	};

	onMount(async () => {
		const response = await fetch('/api/auth/info');

		if (!response.ok) {
			username = 'Failed To Fetch';
			error = true;
		} else {
			const data = await response.json();
			username = data.username;
		}
	});
</script>

<DropdownMenu.Root>
	<DropdownMenu.Trigger asChild let:builder>
		<Button variant="ghost" builders={[builder]} class="relative h-8 w-8 rounded-full mx-1">
			<Avatar.Root class="h-10 w-10">
				{#if !error}
					<Avatar.Fallback>{username?.replace(/[^A-Z]/g, '').slice(0, 2)}</Avatar.Fallback>
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
		<DropdownMenu.Separator />
		<DropdownMenu.Item class="font-normal" on:click={() => goto('/app')}>
			<div class="flex flex-col space-y-1">
				<p class="text-sm font-medium leading-none">Statistics</p>
				<p class="text-xs leading-none text-muted-foreground">
					Position on leaderboard:<br />1 out of 1
				</p>
				<p class="text-xs leading-none text-muted-foreground">League:<br />Global Elite</p>
				<p class="text-xs leading-none text-muted-foreground">
					Avg. time per solved challenge:<br />2min&nbsp;54s
				</p>
			</div>
		</DropdownMenu.Item>
		<DropdownMenu.Separator />
		<DropdownMenu.Group>
			<DropdownMenu.Item on:click={() => goto('/app/settings')}>Settings</DropdownMenu.Item>
			<DropdownMenu.Item on:click={handleLogout}>Log out</DropdownMenu.Item>
		</DropdownMenu.Group>
	</DropdownMenu.Content>
</DropdownMenu.Root>
