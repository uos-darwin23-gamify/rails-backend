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
		DataTableTypeCell
	} from '.';

	import type { ChallengeOverview } from '../data/schemas';
	import { goto } from '$app/navigation';

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

	const goToChallenge = (row: any) =>
		goto('/app/challenges?id=' + encodeURIComponent(row.original.id));
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
						<Table.Row {...rowAttrs} class="cursor-pointer" on:click={() => goToChallenge(row)}>
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

<style>
	/* :global(.checkbox-custom-class) {
		width: 4rem;
	} */

	/* :global(.actions-custom-class) {
		width: 3rem;
	} */
</style>
