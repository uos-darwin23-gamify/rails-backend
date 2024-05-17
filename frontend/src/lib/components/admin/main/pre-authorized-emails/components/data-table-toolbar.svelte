<script lang="ts">
	import { Input } from '$lib/components/new-york/ui/input';
	import { DataTableFacetedFilter, DataTableViewOptions } from '.';
	import type { PreAuthorizedEmail } from '../data/schemas';
	import type { TableViewModel } from 'svelte-headless-table';
	import Button from '$lib/components/new-york/ui/button/button.svelte';
	import { Cross2, PlusCircled } from 'radix-icons-svelte';
	// import { statuses, priorities } from "../data/data";
	import type { Writable } from 'svelte/store';
	// import { createEventDispatcher } from 'svelte';
	import * as Dialog from '$lib/components/ui/dialog';
	import * as Tabs from '$lib/components/ui/tabs';
	import * as Card from '$lib/components/ui/card';
	import { Label } from '$lib/components/ui/label';
	import { Textarea } from '$lib/components/ui/textarea';
	export let addNewEmails: (emails: string[], groupType: 'league' | 'global') => Promise<void>;

	export let tableModel: TableViewModel<PreAuthorizedEmail>;

	const { pluginStates } = tableModel;
	// const {
	// 	filterValue
	// }: {
	// 	filterValue: Writable<string>;
	// } = pluginStates.filter;

	const {
		filterValues
	}: {
		filterValues: Writable<{
			email: string;
			group: string[];
		}>;
	} = pluginStates.colFilter;

	$: showReset = Object.values({ ...$filterValues }).some(
		(v) => v.length > 0 || (typeof v === 'string' && v.length > 0)
	);

	// const dispatch = createEventDispatcher();
	let newEmails = '';
	const EMAIL_REGEX = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

	let errorMessage: string | undefined;

	const validateAndFormatNewEmails = (newEmails: string) => {
		const splitString = newEmails.trim().split(/\s+/);
		let error = false;
		if (splitString.length === 0) {
			errorMessage = 'Enter email(s)...';
			error = true;
		}

		if (!splitString.every((email) => EMAIL_REGEX.test(email))) {
			errorMessage = 'One or more entered emails is invalid...';
			error = true;
		}

		return { newEmails: splitString, error };
	};

	let tabValue: 'single' | 'bulk' = 'single';
	let groupTypeValue: 'league' | 'global' = 'league';
	$: {
		tabValue;
		newEmails = '';
		errorMessage = undefined;
	}

	let dialogOpen = false;
	const closeDialog = () => (dialogOpen = false);
</script>

<div class="flex items-center gap-2 flex-wrap">
	<Input
		placeholder="Filter emails..."
		class="h-8 sm:w-[250px] lg:w-[350px] grow sm:grow-0 xl:grow-0 md:grow basis-[200px]"
		type="search"
		bind:value={$filterValues.email}
	/>
	<div class="flex grow justify-between gap-2">
		<div class="flex sm:items-center gap-2">
			<DataTableFacetedFilter
				bind:filterValues={$filterValues.group}
				title="Group"
				options={[
					{ label: 'League', value: 'league' },
					{ label: 'Global', value: 'global' }
				]}
			/>
			{#if showReset}
				<Button
					on:click={() => {
						$filterValues.email = '';
						$filterValues.group = [];
					}}
					variant="outline"
					class="h-8 px-2 lg:px-3"
				>
					<Cross2 class="h-4 w-4" />
				</Button>
			{/if}
		</div>
		<Dialog.Root
			bind:open={dialogOpen}
			onOpenChange={() => {
				newEmails = '';
				errorMessage = undefined;
			}}
		>
			<Dialog.Trigger
				><Button class="h-8" on:click={() => (newEmails = '')}
					><PlusCircled class="h-5 w-5 mr-2" />Add</Button
				></Dialog.Trigger
			>
			<Dialog.Content class="sm:max-w-[425px]">
				<Tabs.Root bind:value={tabValue} class="mt-5">
					<Tabs.List class="grid w-full grid-cols-2">
						<Tabs.Trigger value="single">Single</Tabs.Trigger>
						<Tabs.Trigger value="bulk">Bulk</Tabs.Trigger>
					</Tabs.List>
					<Tabs.Root bind:value={groupTypeValue} class="mt-2">
						<Tabs.List class="grid w-full grid-cols-2">
							<Tabs.Trigger value="league">League</Tabs.Trigger>
							<Tabs.Trigger value="global">Global</Tabs.Trigger>
						</Tabs.List>
					</Tabs.Root>
					<Tabs.Content value="single">
						<form
							on:submit|preventDefault={() =>
								!validateAndFormatNewEmails(newEmails).error &&
								addNewEmails(validateAndFormatNewEmails(newEmails).newEmails, groupTypeValue)}
						>
							<Card.Root class="border-0">
								<Card.Header>
									<Card.Title>Add a single email</Card.Title>
								</Card.Header>
								<Card.Content class="space-y-2">
									<div class="space-y-1">
										<Label for="email">Email</Label>
										<Input
											id="email"
											bind:value={newEmails}
											on:input={() => (errorMessage = undefined)}
											placeholder="Enter email..."
										/>
									</div>
									{#if errorMessage}
										<Label class="text-error">{errorMessage}</Label>
									{/if}
								</Card.Content>
								<Card.Footer class="justify-between">
									<Button variant="secondary" on:click={closeDialog}>Cancel</Button>
									<Button type="submit">Submit</Button>
								</Card.Footer>
							</Card.Root>
						</form>
					</Tabs.Content>
					<Tabs.Content value="bulk">
						<form
							on:submit|preventDefault={() =>
								!validateAndFormatNewEmails(newEmails).error &&
								addNewEmails(validateAndFormatNewEmails(newEmails).newEmails, groupTypeValue)}
						>
							<Card.Root class="border-0">
								<Card.Header>
									<Card.Title>Add multiple emails in bulk</Card.Title>
									<Card.Description>Input each new email on a new line.</Card.Description>
								</Card.Header>
								<Card.Content class="space-y-2">
									<div class="space-y-1">
										<Label for="emails">Emails</Label>
										<Textarea
											id="emails"
											bind:value={newEmails}
											on:input={() => (errorMessage = undefined)}
											placeholder="Enter emails..."
										/>
									</div>
									{#if errorMessage}
										<Label class="text-error">{errorMessage}</Label>
									{/if}
								</Card.Content>
								<Card.Footer class="justify-between">
									<Button variant="secondary" on:click={closeDialog}>Cancel</Button>
									<Button type="submit">Submit</Button>
								</Card.Footer>
							</Card.Root>
						</form>
					</Tabs.Content>
				</Tabs.Root>
			</Dialog.Content>
		</Dialog.Root>
	</div>
	<!-- <DataTableViewOptions {tableModel} /> -->
</div>
