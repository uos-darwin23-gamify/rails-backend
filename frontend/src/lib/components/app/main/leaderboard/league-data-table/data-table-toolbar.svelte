<script lang="ts">
	import { Input } from '$lib/components/new-york/ui/input';
	import type { LeagueLeaderboard } from './data/schemas';
	import type { TableViewModel } from 'svelte-headless-table';
	import Button from '$lib/components/new-york/ui/button/button.svelte';
	import { Cross2, PlusCircled } from 'radix-icons-svelte';
	import type { Writable } from 'svelte/store';

	export let tableModel: TableViewModel<LeagueLeaderboard>;

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
			username: string;
		}>;
	} = pluginStates.colFilter;

	$: showReset = Object.values({ ...$filterValues }).some(
		(v) => v.length > 0 || (typeof v === 'string' && v.length > 0)
	);

	// const dispatch = createEventDispatcher();
	// const handleNameFilterInput = (e: Event) => {
	// 	const inputEvent = e as InputEvent;
	// 	const target = inputEvent.target as HTMLInputElement;
	// 	const value = target.value;

	// 	if (value) {
	// 		$filterValues.name = [];
	// 		$filterValues.name[0] = value;
	// 	} else {
	// 		$filterValues.name = [];
	// 	}
	// };
</script>

<div class="flex items-center gap-2">
	<Input
		placeholder="Filter by username..."
		class="h-8 sm:w-[250px] lg:w-[350px] grow sm:grow-0 lg:grow-0 md:grow"
		type="search"
		bind:value={$filterValues.username}
	/>
	{#if showReset}
		<Button
			on:click={() => {
				$filterValues.username = '';
			}}
			variant="outline"
			class="h-8 px-2"
		>
			<Cross2 class="h-4 w-4" />
		</Button>
	{/if}

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
