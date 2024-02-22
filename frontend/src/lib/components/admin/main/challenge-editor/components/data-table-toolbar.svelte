<script lang="ts">
	import { Input } from '$lib/components/new-york/ui/input';
	import { DataTableFacetedFilter, DataTableViewOptions } from '.';
	import type { ChallengeOverview } from '../data/schemas';
	import type { TableViewModel } from 'svelte-headless-table';
	import Button from '$lib/components/new-york/ui/button/button.svelte';
	import { Cross2, PlusCircled } from 'radix-icons-svelte';
	// import { statuses, priorities } from "../data/data";
	import type { Writable } from 'svelte/store';
	import { get } from 'svelte/store';
	// import { createEventDispatcher } from 'svelte';
	import * as Dialog from '$lib/components/ui/dialog';
	import * as Tabs from '$lib/components/ui/tabs';
	import * as Card from '$lib/components/ui/card';
	import { Label } from '$lib/components/ui/label';
	import { Textarea } from '$lib/components/ui/textarea';
	import { challengeTypes, challengeDiffuculties, challengeStatuses } from '../data/data';
	// export let addNewEmails: (emails: string[]) => Promise<void>;

	export let tableModel: TableViewModel<ChallengeOverview>;

	let selectedForm = 'Option 1'; // This will hold the value of the selected option
	const forms = {
		form1: 'Single Choice Question',
		form2: 'Mutiple Choice Question',
		form3: 'Code',
		form4: 'Connect Blocks',
	};

	const { pluginStates } = tableModel;

	const {
		filterValues
	}: {
		filterValues: Writable<{
			name: string;
			type: string[];
			difficulty: string[];
			status: string[];
		}>;
	} = pluginStates.colFilter;

	$: showReset = Object.values({ ...$filterValues }).some(
		(v) => v.length > 0 || (typeof v === 'string' && v.length > 0)
	);

	let dialogOpen = false;
	const closeDialog = () => (dialogOpen = false);
</script>

<div class="flex items-center gap-2 flex-wrap">
	<Input
		placeholder="Filter by name..."
		class="h-8 sm:w-[250px] lg:w-[350px] grow sm:grow-0 lg:grow-0 md:grow"
		type="search"
		bind:value={$filterValues.name}
	/>
	<div
		class="flex flex-1 sm:items-center grow justify-between gap-2 flex-col sm:flex-row relative overflow-x-auto sm:overflow-x-visible"
	>
		<div class="relative overflow-x-auto flex sm:overflow-x-visible">
			<div class="flex items-center gap-2 w-full">
				<DataTableFacetedFilter
					bind:filterValues={$filterValues.type}
					title="Type"
					options={challengeTypes}
				/>
				<DataTableFacetedFilter
					bind:filterValues={$filterValues.difficulty}
					title="Difficulty"
					options={challengeDiffuculties}
				/>
				<DataTableFacetedFilter
					bind:filterValues={$filterValues.status}
					title="Status"
					options={challengeStatuses}
				/>
				{#if showReset}
					<Button
						on:click={() => {
							$filterValues.name = '';
							$filterValues.type = [];
							$filterValues.difficulty = [];
						}}
						variant="outline"
						class="h-8 px-2 lg:px-3"
					>
						<Cross2 class="h-4 w-4" />
					</Button>
				{/if}
			</div> 
			<Button class="h-8" on:click={() => {dialogOpen=true}}
					><PlusCircled class="h-5 w-5 mr-2" />Add</Button
				>
				
		</div>
		<DataTableViewOptions {tableModel} />
	</div>
	<Dialog.Root
	bind:open={dialogOpen}>
	<Dialog.Content class="sm:max-w-[425px]">
		<select bind:value={selectedForm}>
		</select>
		<Card.Footer class="justify-between">
			<Button variant="secondary" on:click={closeDialog}>Cancel</Button>
		</Card.Footer>
</Dialog.Content>
</Dialog.Root>


<!--
	<dialog bind:this={dialog} on:close={() => (showModal = false)} on:click|self={() => dialog.close()}>
	<div on:click|stopPropagation>
		<slot name="header" />
		<hr />
		<select bind:value={selectedForm}>
			<option value="">Please select</option>
			{#each Object.entries(forms) as [formKey, formValue]}
				<option value={formKey}>{formValue}</option>
			{/each}
		</select>
		{#if selectedForm === 'form1'}
			<ScqForm/>
		{:else if selectedForm === 'form2'}
			<McqForm/>
		{:else if selectedForm === 'form3'}
			<CodeOutputForm/>
		{:else if selectedForm === 'form4'}
			<ConnectBlocksForm/>
		{/if}
		<hr />
		<button autofocus on:click={() => dialog.close()}>close modal</button>
	</div>
</dialog>
-->


	<!-- <div class="flex">
		<Dialog.Root
			onOpenChange={() => {
				newEmails = '';
				errorMessage = undefined;
			}}
		>
			<Dialog.Trigger
				><Button on:click={() => (newEmails = '')}><PlusCircled class="h-5 w-5 mr-2" />Add</Button
				></Dialog.Trigger
			>
			<Dialog.Content class="sm:max-w-[425px]">
				<Tabs.Root bind:value={tabValue} class="mt-5">
					<Tabs.List class="grid w-full grid-cols-2">
						<Tabs.Trigger value="single">Single</Tabs.Trigger>
						<Tabs.Trigger value="bulk">Bulk</Tabs.Trigger>
					</Tabs.List>
					<Tabs.Content value="single">
						<form
							on:submit|preventDefault={() =>
								!validateAndFormatNewEmails(newEmails).error &&
								addNewEmails(validateAndFormatNewEmails(newEmails).newEmails)}
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
								addNewEmails(validateAndFormatNewEmails(newEmails).newEmails)}
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
	</div> -->
</div>
