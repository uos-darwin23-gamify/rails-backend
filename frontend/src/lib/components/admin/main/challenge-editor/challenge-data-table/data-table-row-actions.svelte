<script lang="ts">
	import * as HoverCard from '$lib/components/ui/hover-card';
	import { Button } from '$lib/components/ui/button';
	import type { Challenge } from '../ChallengeEditor.svelte';
	import * as Dialog from '$lib/components/ui/dialog';
	import * as DropdownMenu from '$lib/components/ui/dropdown-menu';
	import { DotsHorizontal } from 'radix-icons-svelte';
	import { goto } from '$app/navigation';

	export let value: Challenge;
	export let deleteChallenge: (id: string) => Promise<void>;

	let deleteDialogOpen = false;
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
		<HoverCard.Root>
			<HoverCard.Trigger>
				<DropdownMenu.Item class="cursor-pointer" on:click={() => goto('/admin/TODO')}
					>Edit</DropdownMenu.Item
				>
			</HoverCard.Trigger>
			<HoverCard.Content class="w-fit h-fit py-2 px-2.5">
				<div class="text-xs flex items-center">Edit Challenge</div>
			</HoverCard.Content>
		</HoverCard.Root>
		<DropdownMenu.Separator />
		<HoverCard.Root>
			<HoverCard.Trigger>
				<DropdownMenu.Item
					class="cursor-pointer bg-destructive text-destructive-foreground hover:bg-destructive/90 data-[highlighted]:bg-destructive data-[highlighted]:text-destructive-foreground data-[highlighted]:bg-destructive/90"
					on:click={() => (deleteDialogOpen = true)}>Delete</DropdownMenu.Item
				>
			</HoverCard.Trigger>
			<HoverCard.Content class="w-fit h-fit py-2 px-2.5">
				<div class="text-xs flex items-center">Delete Challenge</div>
			</HoverCard.Content>
		</HoverCard.Root>
	</DropdownMenu.Content>
</DropdownMenu.Root>

<Dialog.Root bind:open={deleteDialogOpen}>
	<Dialog.Content>
		<Dialog.Header>
			<Dialog.Title>Are you absolutely sure?</Dialog.Title>
			<Dialog.Description>
				This action cannot be undone.
				<br />
				<br />
				This will permanently delete challenge:
				<br />
				{value.name}
				<br />
				<br />
				Note: The score of users who have already completed this challenge will remain unchanged.
			</Dialog.Description>
		</Dialog.Header>
		<Dialog.Footer class="mt-4 flex sm:justify-between gap-2">
			<Button variant="secondary" on:click={() => (deleteDialogOpen = false)}>Cancel</Button>
			<Button
				on:click={() => {
					deleteChallenge(value.id);
					deleteDialogOpen = false;
				}}>Delete Challenge</Button
			>
		</Dialog.Footer>
	</Dialog.Content>
</Dialog.Root>
