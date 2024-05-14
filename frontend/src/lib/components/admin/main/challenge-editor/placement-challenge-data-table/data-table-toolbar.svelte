<script lang="ts">
	import { Input } from '$lib/components/new-york/ui/input';
	import { DataTableFacetedFilter, DataTableViewOptions } from '.';
	import type { PlacementChallenge } from '../ChallengeEditor.svelte';
	import type { TableViewModel } from 'svelte-headless-table';
	import Button from '$lib/components/new-york/ui/button/button.svelte';
	import { Cross2 } from 'radix-icons-svelte';
	import type { Writable } from 'svelte/store';
	import { challengeTypes, challengeDifficulties } from '../data/data';

	export let tableModel: TableViewModel<PlacementChallenge>;

	const { pluginStates } = tableModel;

	const {
		filterValues
	}: {
		filterValues: Writable<{
			Name: string;
			Type: string[];
			Difficulty: string[];
		}>;
	} = pluginStates.colFilter;

	$: showReset = Object.values({ ...$filterValues }).some(
		(v) => v.length > 0 || (typeof v === 'string' && v.length > 0)
	);
</script>

<div class="flex justify-between items-center gap-2 flex-wrap">
	<Input
		placeholder="Filter by name..."
		class="h-8 sm:w-[250px] lg:w-[350px] grow sm:grow-0 lg:grow-0 md:grow"
		type="search"
		bind:value={$filterValues.Name}
	/>
	<div
		class="flex sm:items-center grow justify-between gap-2 flex-col sm:flex-row relative overflow-x-auto sm:overflow-x-visible"
	>
		<div class="relative overflow-x-auto flex justify-between grow sm:overflow-x-visible">
			<div class="flex items-center gap-2 grow-0">
				<DataTableFacetedFilter
					bind:filterValues={$filterValues.Type}
					title="Type"
					options={challengeTypes}
				/>
				<DataTableFacetedFilter
					bind:filterValues={$filterValues.Difficulty}
					title="Difficulty"
					options={challengeDifficulties}
				/>
				{#if showReset}
					<Button
						on:click={() => {
							$filterValues.Name = '';
							$filterValues.Type = [];
							$filterValues.Difficulty = [];
						}}
						variant="outline"
						class="h-8 px-2 lg:px-3"
					>
						<Cross2 class="h-4 w-4" />
					</Button>
				{/if}
			</div>

			<DataTableViewOptions {tableModel} />
		</div>
	</div>
</div>
