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
		DataTableColumnHeader,
		DataTableToolbar,
		DataTablePagination,
		DataTableDifficultyCell,
		DataTableTypeCell
	} from '.';
	import type { ChallengeOverview } from '../data/schemas';


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
	]);

	const tableModel = table.createViewModel(columns);

	const { headerRows, pageRows, tableAttrs, tableBodyAttrs, pluginStates } = tableModel;

	const rowToRowOriginal = (row: any) => row.original;

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
							{...rowAttrs}>
							{#each row.cells as cell (cell.id)}
								<Subscribe attrs={cell.attrs()} let:attrs>
									<Table.Cell {...attrs}>
										<Render of={cell.render()} />
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

	:global(.bg-in-progress) {
		background-color: rgb(66 32 6 / 0.5);
	}
</style>
