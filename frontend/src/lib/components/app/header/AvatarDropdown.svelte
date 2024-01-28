<script lang="ts">
	import * as DropdownMenu from '$lib/components/ui/dropdown-menu';
	import * as Avatar from '$lib/components/ui/avatar';
	import { Button } from '$lib/components/ui/button';
	import { goto } from '$app/navigation';
	import { logOut } from '$lib/auth';
	import { authenticated } from '$lib/stores';
	import AvatarSrc from './avatar.jpeg';

	const handleLogout = async () => {
		const logoutSuccessful = await logOut();
		logoutSuccessful && authenticated.verify();
	};
</script>

<DropdownMenu.Root>
	<DropdownMenu.Trigger asChild let:builder>
		<Button variant="ghost" builders={[builder]} class="relative h-8 w-8 rounded-full mx-1">
			<Avatar.Root class="h-10 w-10">
				<Avatar.Image src={AvatarSrc} alt="@shadcn" />
				<Avatar.Fallback>AN</Avatar.Fallback>
			</Avatar.Root>
		</Button>
	</DropdownMenu.Trigger>
	<DropdownMenu.Content class="w-56" align="end">
		<DropdownMenu.Label class="font-normal">
			<div class="flex flex-col space-y-1">
				<p class="text-sm font-medium leading-none">anonymous</p>
				<p class="text-xs leading-none text-muted-foreground">anonymous@wearelegion.com</p>
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
