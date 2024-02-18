<script lang="ts">
	import { get, readable } from 'svelte/store';
	import { BodyRow, Render, Subscribe, createRender, createTable } from 'svelte-headless-table';
	import * as Table from '$lib/components/new-york/ui/table';
	import {
		addColumnFilters,
		addHiddenColumns,
		addPagination,
		addSelectedRows,
		addSortBy,
		addTableFilter
	} from 'svelte-headless-table/plugins';
	import {
		DataTableCheckbox,
		DataTableNameCell,
		DataTableRowActions,
		// DataTablePriorityCell,
		DataTableColumnHeader,
		DataTableToolbar,
		DataTablePagination,
		DataTableDifficultyCell,
		DataTableStatusCell,
		DataTableTypeCell
	} from '.';
	import * as Dialog from '$lib/components/ui/dialog';
	import type { ChallengeOverview } from '../data/schemas';
	import { goto } from '$app/navigation';
	import { Button } from '$lib/components/ui/button';
	import { Timer, ShieldAlert } from 'lucide-svelte';

	export let data: ChallengeOverview[];

	const table = createTable(readable(data), {
		select: addSelectedRows(),
		sort: addSortBy({
			toggleOrder: ['asc', 'desc']
		}),
		page: addPagination(),
		// filter: addTableFilter({
		// 	fn: ({ filterValue, value }) => {
		// 		return value.toLowerCase().includes(filterValue.toLowerCase());
		// 	}
		// }),
		colFilter: addColumnFilters(),
		hide: addHiddenColumns()
	});

	const columns = table.createColumns([
		// table.display({
		// 	id: 'select',
		// 	header: (_, { pluginStates }) => {
		// 		const { allPageRowsSelected } = pluginStates.select;
		// 		return createRender(DataTableCheckbox, {
		// 			checked: allPageRowsSelected,
		// 			'aria-label': 'Select all'
		// 		});
		// 	},
		// 	cell: ({ row }, { pluginStates }) => {
		// 		const { getRowState } = pluginStates.select;
		// 		const { isSelected } = getRowState(row);
		// 		return createRender(DataTableCheckbox, {
		// 			checked: isSelected,
		// 			'aria-label': 'Select row',
		// 			class: 'translate-y-[2px]'
		// 		});
		// 	},
		// 	plugins: {
		// 		sort: {
		// 			disable: true
		// 		}
		// 	}
		// }),
		table.column({
			accessor: 'name',
			header: 'Name',
			id: 'name',
			cell: ({ value, row }) => {
				if (row.isData()) {
					return createRender(DataTableNameCell, {
						value
					});
				}
				return value;
			},
			plugins: {
				colFilter: {
					fn: ({ filterValue, value }) => {
						return value.toLowerCase().includes(filterValue.toLowerCase());
					},
					initialFilterValue: '',
					render: ({ filterValue }) => {
						return get(filterValue);
					}
				}
			}
		}),
		table.column({
			accessor: 'type',
			header: 'Type',
			id: 'type',
			cell: ({ value, row }) => {
				if (row.isData()) {
					return createRender(DataTableTypeCell, {
						value
					});
				}
				return value;
			},
			plugins: {
				colFilter: {
					fn: ({ filterValue, value }) => {
						if (filterValue.length === 0) return true;
						if (!Array.isArray(filterValue) || typeof value !== 'string') return true;

						return filterValue.some((filter) => {
							return value.includes(filter);
						});
					},
					initialFilterValue: [],
					render: ({ filterValue }) => {
						return get(filterValue);
					}
				}
			}
		}),
		table.column({
			accessor: 'difficulty',
			header: 'Difficulty',
			id: 'difficulty',
			cell: ({ value, row }) => {
				if (row.isData()) {
					return createRender(DataTableDifficultyCell, {
						value
					});
				}
				return value;
			},
			plugins: {
				colFilter: {
					fn: ({ filterValue, value }) => {
						if (filterValue.length === 0) return true;
						if (!Array.isArray(filterValue) || typeof value !== 'string') return true;

						return filterValue.some((filter) => {
							return value.includes(filter);
						});
					},
					initialFilterValue: [],
					render: ({ filterValue }) => {
						return get(filterValue);
					}
				}
			}
		}),
		table.column({
			accessor: (row: ChallengeOverview) => {
				if (!row.started) return 'New';
				if (row.finished) return 'Finished';
				return 'In Progress';
			},
			header: 'Status',
			id: 'status',
			cell: ({ value, row }) => {
				if (row.isData()) {
					return createRender(DataTableStatusCell, {
						value
					});
				}
				return value;
			},
			plugins: {
				colFilter: {
					fn: ({ filterValue, value }) => {
						if (filterValue.length === 0) return true;
						if (!Array.isArray(filterValue) || typeof value !== 'string') return true;

						return filterValue.some((filter) => {
							return value.includes(filter);
						});
					},
					initialFilterValue: [],
					render: ({ filterValue }) => {
						return get(filterValue);
					}
				}
			}
		})
		// table.display({
		// 	id: 'actions',
		// 	header: () => {
		// 		return '';
		// 	},
		// 	cell: ({ row }) => {
		// 		if (row.isData() && row.original) {
		// 			return createRender(DataTableRowActions, {
		// 				row: row.original,
		// 				rowId: parseInt(row.id)
		// 			});
		// 		}
		// 		return '';
		// 	}
		// })
	]);

	const tableModel = table.createViewModel(columns);

	const { headerRows, pageRows, tableAttrs, tableBodyAttrs, pluginStates } = tableModel;

	const rowToRowOriginal = (row: any) => row.original;

	const goToChallenge = (row: any) => {
		if (!row.original.started) {
			challengeToStart = row.original.id;
			dialogOpen = true;
		} else {
			goto('/app/challenges?id=' + encodeURIComponent(row.original.id));
		}
	};

	let challengeToStart: string | null = null;
	let dialogOpen = false;
	$: {
		if (!dialogOpen) {
			challengeToStart = null;
		}
		// if (challengeToStart !== null) {
		// 	dialogOpen = true;
		// }
	}
</script>

<div class="space-y-4">
	<DataTableToolbar {tableModel} />
	<div class="rounded-md border">
		<Table.Root {...$tableAttrs}>
			<Table.Header>
				{#each $headerRows as headerRow}
					<Subscribe rowAttrs={headerRow.attrs()}>
						<Table.Row>
							{#each headerRow.cells as cell (cell.id)}
								<Subscribe attrs={cell.attrs()} let:attrs props={cell.props()} let:props>
									<Table.Head
										{...attrs}
										class={cell.id === 'actions' ? 'actions-custom-class' : ''}
									>
										<!-- {#if cell.id !== 'actions'} -->
										<DataTableColumnHeader {props}
											><Render of={cell.render()} /></DataTableColumnHeader
										>
										<!-- {:else}
											<Render of={cell.render()} />
										{/if} -->
									</Table.Head>
								</Subscribe>
							{/each}
						</Table.Row>
					</Subscribe>
				{/each}
			</Table.Header>
			<Table.Body {...$tableBodyAttrs}>
				{#each $pageRows as row (row.id)}
					<Subscribe rowAttrs={row.attrs()} let:rowAttrs>
						<Table.Row
							{...rowAttrs}
							class={'cursor-pointer' +
								(rowToRowOriginal(row).started === true && rowToRowOriginal(row).finished === false
									? ' bg-in-progress'
									: '')}
							on:click={() => goToChallenge(row)}
						>
							{#each row.cells as cell (cell.id)}
								<Subscribe attrs={cell.attrs()} let:attrs>
									<Table.Cell {...attrs}>
										<!-- {#if cell.id === 'email'}
											<div class="w-[80px]">
												<Render of={cell.render()} />
											</div>
										{:else} -->
										<Render of={cell.render()} />
										<!-- {/if} -->
									</Table.Cell>
								</Subscribe>
							{/each}
						</Table.Row>
					</Subscribe>
				{/each}
			</Table.Body>
		</Table.Root>
	</div>
	<DataTablePagination {tableModel} />
</div>
<Dialog.Root bind:open={dialogOpen}>
	<Dialog.Content>
		<Dialog.Header>
			<Dialog.Title class="flex justify-center items-center">Start Challenge</Dialog.Title>
			<Dialog.Description class="text-left pt-3 flex flex-col gap-2">
				<div class="flex items-center text-base gap-2">
					<p class="text-center grow">You are about to start this challenge.</p>
				</div>
				<div class="flex items-center text-sm gap-2 mt-2">
					<div class="shrink-0">
						<Timer class="h-7 w-7 -ml-0.5" />
					</div>
					<p>
						Challenges are time-based meaning the faster you complete a challenge, the more points
						you will get.
					</p>
				</div>
				<div class="flex items-center text-sm gap-2">
					<div class="shrink-0">
						<ShieldAlert class="h-7 w-7 -ml-0.5" />
					</div>
					<p>You only get one attempt at a challenge so verify your answers before submitting.</p>
				</div>
			</Dialog.Description>
		</Dialog.Header>
		<Dialog.Footer class="mt-4 flex sm:justify-between gap-2">
			<Button
				variant="secondary"
				on:click={() => {
					challengeToStart = null;
					dialogOpen = false;
				}}>Cancel</Button
			>
			<Button
				on:click={() =>
					typeof challengeToStart === 'string' &&
					goto('/app/challenges?id=' + encodeURIComponent(challengeToStart))}
				>Start Challenge</Button
			>
		</Dialog.Footer>
	</Dialog.Content>
</Dialog.Root>

<style>
	/* :global(.checkbox-custom-class) {
		width: 4rem;
	} */

	/* :global(.actions-custom-class) {
		width: 3rem;
	} */

	:global(.bg-in-progress) {
		background-color: rgb(66 32 6 / 0.5);
	}
</style>
