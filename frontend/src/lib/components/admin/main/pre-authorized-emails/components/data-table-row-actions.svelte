<script lang="ts">
	import { DotsHorizontal } from 'radix-icons-svelte';
	import { Button } from '$lib/components/new-york/ui/button';
	import * as DropdownMenu from '$lib/components/new-york/ui/dropdown-menu';
	// import { labels } from "../data/data";
	import { preAuthorizedEmailsSchema, type PreAuthorizedEmail } from '../data/schemas';
	import * as Dialog from '$lib/components/ui/dialog';
	import * as Card from '$lib/components/ui/card';
	import { Label } from '$lib/components/ui/label';
	import { Input } from '$lib/components/ui/input';
	import * as Tabs from '$lib/components/ui/tabs';

	export let row: PreAuthorizedEmail;
	// const email = preAuthorizedEmailsSchema.parse(row);
	export let deleteEmail: (id: number) => Promise<void>;
	export let editEmail: (id: number, email: string, group: 'league' | 'global') => Promise<void>;
	export let rowId: number;

	let dialogOpen = false;
	let editDialogOpen = false;
	// let groupTypeValue: 'league' | 'global' = 'league';
	const currentEmail = preAuthorizedEmailsSchema.parse(row).email;
	const currentGroup = preAuthorizedEmailsSchema.parse(row).group as 'league' | 'global';
	let email = currentEmail;
	let group = currentGroup;

	let errorMessage: string | undefined;
	const EMAIL_REGEX = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

	const validateAndFormatEmail = (email: string) => {
		const splitString = email.trim().split(/\s+/);
		let error = false;
		if (splitString.length === 0) {
			errorMessage = 'Enter email...';
			error = true;
		}

		if (!splitString.every((email) => EMAIL_REGEX.test(email))) {
			errorMessage = 'Entered email is invalid...';
			error = true;
		}

		return { email: splitString, error };
	};
	$: {
		if (!dialogOpen && !editDialogOpen) {
			email = currentEmail;
			group = currentGroup;
			errorMessage = undefined;
		}
	}
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
		<!-- <DropdownMenu.Item>Edit</DropdownMenu.Item>
		<DropdownMenu.Item>Make a copy</DropdownMenu.Item>
		<DropdownMenu.Item>Favorite</DropdownMenu.Item> -->
		<DropdownMenu.Item class="cursor-pointer" on:click={() => (editDialogOpen = true)}
			>Edit</DropdownMenu.Item
		>
		<DropdownMenu.Separator />
		<DropdownMenu.Item
			class="cursor-pointer bg-destructive text-destructive-foreground hover:bg-destructive/90 data-[highlighted]:bg-destructive data-[highlighted]:text-destructive-foreground data-[highlighted]:bg-destructive/90"
			on:click={() => (dialogOpen = true)}>Delete</DropdownMenu.Item
		>
		<!-- <DropdownMenu.Separator />
		<DropdownMenu.Sub>
			<DropdownMenu.SubTrigger>Labels</DropdownMenu.SubTrigger>
			<DropdownMenu.SubContent>
				<DropdownMenu.RadioGroup value={email.email}>
					{#each labels as label}
						<DropdownMenu.RadioItem value={label.value}>
							{label.label}
						</DropdownMenu.RadioItem>
					{/each}
				</DropdownMenu.RadioGroup>
			</DropdownMenu.SubContent>
		</DropdownMenu.Sub>
		<DropdownMenu.Separator />
		<DropdownMenu.Item>
			Delete
			<DropdownMenu.Shortcut>⌘⌫</DropdownMenu.Shortcut>
		</DropdownMenu.Item> -->
	</DropdownMenu.Content>
</DropdownMenu.Root>
<Dialog.Root bind:open={dialogOpen}>
	<Dialog.Content>
		<Dialog.Header>
			<Dialog.Title>Are you sure absolutely sure?</Dialog.Title>
			<Dialog.Description>
				This action cannot be undone. This will permanently delete the pre-authorized email. If the
				user has already created an account with this email, then the account will still exist after
				the deletion.
			</Dialog.Description>
		</Dialog.Header>
		<Dialog.Footer class="mt-4 flex sm:justify-between gap-2">
			<Button
				variant="secondary"
				on:click={() => {
					dialogOpen = false;
				}}>Cancel</Button
			>
			<Button
				on:click={() => {
					deleteEmail(rowId);
					dialogOpen = false;
				}}>Delete Email</Button
			>
		</Dialog.Footer>
	</Dialog.Content>
</Dialog.Root>
<Dialog.Root bind:open={editDialogOpen}>
	<Dialog.Content>
		<form
			on:submit|preventDefault={() => {
				if (!validateAndFormatEmail(email).error) {
					editEmail(rowId, validateAndFormatEmail(email).email[0], group);
					editDialogOpen = false;
				}
			}}
		>
			<Dialog.Header>
				<Dialog.Title>Edit Email</Dialog.Title>
				<Dialog.Description class="pt-2 pb-3">
					If the user has already created an account with this email, their account email and group
					will remain unchanged.
				</Dialog.Description>
			</Dialog.Header>
			<Tabs.Root bind:value={group} class="mt-2">
				<Tabs.List class="grid w-full grid-cols-2">
					<Tabs.Trigger value="league">League</Tabs.Trigger>
					<Tabs.Trigger value="global">Global</Tabs.Trigger>
				</Tabs.List>
			</Tabs.Root>
			<div class="space-y-1 mt-4">
				<Label for="email">Email</Label>
				<Input
					id="email"
					bind:value={email}
					on:input={() => (errorMessage = undefined)}
					placeholder="Enter email..."
				/>
			</div>
			{#if errorMessage}
				<Label class="text-error">{errorMessage}</Label>
			{/if}
			<Dialog.Footer class="mt-4 flex sm:justify-between gap-2">
				<Button
					variant="secondary"
					on:click={() => {
						editDialogOpen = false;
					}}>Cancel</Button
				>
				<Button type="submit">Save</Button>
			</Dialog.Footer>
		</form>
	</Dialog.Content>
</Dialog.Root>
