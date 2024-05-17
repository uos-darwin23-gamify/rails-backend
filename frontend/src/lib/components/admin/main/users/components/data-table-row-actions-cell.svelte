<script lang="ts">
	import * as HoverCard from '$lib/components/ui/hover-card';
	import type { User } from '../Users.svelte';
	import { Button } from '$lib/components/ui/button';
	import { Group } from '../Users.svelte';
	import * as Dialog from '$lib/components/ui/dialog';
	import * as DropdownMenu from '$lib/components/ui/dropdown-menu';
	import { DotsHorizontal } from 'radix-icons-svelte';

	export let value: User;
	export let deleteUser: (id: number) => Promise<void>;
	export let promoteUser: (id: number) => Promise<void>;

	let deleteDialogOpen = false;
	let promoteDialogOpen = false;
</script>

<DropdownMenu.Root>
	<DropdownMenu.Trigger asChild let:builder>
		<Button
			variant="ghost"
			builders={[builder]}
			class="flex h-8 w-8 p-0 data-[state=open]:bg-muted"
		>
			<DotsHorizontal class="h-4 w-4" />
			<span class="sr-only">Open menu</span>
		</Button>
	</DropdownMenu.Trigger>
	<DropdownMenu.Content class="w-[160px]" align="end">
		{#if value.group !== Group.ADMIN}
			<HoverCard.Root>
				<HoverCard.Trigger>
					<DropdownMenu.Item
						class="cursor-pointer bg-destructive text-destructive-foreground hover:bg-destructive/90 data-[highlighted]:bg-destructive data-[highlighted]:text-destructive-foreground data-[highlighted]:bg-destructive/90"
						on:click={() => (promoteDialogOpen = true)}>Promote To Admin</DropdownMenu.Item
					>
				</HoverCard.Trigger>
				<HoverCard.Content class="w-fit h-fit py-2 px-2.5">
					<div class="text-xs flex items-center">Promote To Admin</div>
				</HoverCard.Content>
			</HoverCard.Root>
			<DropdownMenu.Separator />
		{/if}
		<HoverCard.Root>
			<HoverCard.Trigger>
				<DropdownMenu.Item
					class="cursor-pointer bg-destructive text-destructive-foreground hover:bg-destructive/90 data-[highlighted]:bg-destructive data-[highlighted]:text-destructive-foreground data-[highlighted]:bg-destructive/90"
					on:click={() => (deleteDialogOpen = true)}>Delete</DropdownMenu.Item
				>
			</HoverCard.Trigger>
			<HoverCard.Content class="w-fit h-fit py-2 px-2.5">
				<div class="text-xs flex items-center">Delete User</div>
			</HoverCard.Content>
		</HoverCard.Root>
	</DropdownMenu.Content>
</DropdownMenu.Root>

<Dialog.Root bind:open={deleteDialogOpen}>
	<Dialog.Content>
		<Dialog.Header>
			<Dialog.Title>Are you absolutely sure?</Dialog.Title>
			<Dialog.Description>
				This action cannot be undone. This will permanently delete user&nbsp;@{value.username}.
			</Dialog.Description>
		</Dialog.Header>
		<Dialog.Footer class="mt-4 flex sm:justify-between gap-2">
			<Button variant="secondary" on:click={() => (deleteDialogOpen = false)}>Cancel</Button>
			<Button
				on:click={() => {
					deleteUser(value.id);
					deleteDialogOpen = false;
				}}>Delete User</Button
			>
		</Dialog.Footer>
	</Dialog.Content>
</Dialog.Root>

<Dialog.Root bind:open={promoteDialogOpen}>
	<Dialog.Content>
		<Dialog.Header>
			<Dialog.Title>Are you absolutely sure?</Dialog.Title>
			<Dialog.Description>
				This action cannot be undone. This will permanently promote user&nbsp;@{value.username} to an
				admin.
			</Dialog.Description>
		</Dialog.Header>
		<Dialog.Footer class="mt-4 flex sm:justify-between gap-2">
			<Button variant="secondary" on:click={() => (promoteDialogOpen = false)}>Cancel</Button>
			<Button
				on:click={() => {
					promoteUser(value.id);
					promoteDialogOpen = false;
				}}>Promote User To Admin</Button
			>
		</Dialog.Footer>
	</Dialog.Content>
</Dialog.Root>
