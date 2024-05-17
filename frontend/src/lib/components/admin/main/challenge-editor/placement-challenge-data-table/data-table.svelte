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
		DataTableValueCell,
		DataTableRowActions,
		DataTableColumnHeader,
		DataTableToolbar,
		DataTablePagination,
		DataTableDifficultyCell,
		DataTableTypeCell
	} from '.';
	import type { PlacementChallenge } from '../ChallengeEditor.svelte';

	export let data: PlacementChallenge[];
	export let deleteChallenge: (id: string) => Promise<void>;

	const difficultyOrder = {
		SIMPLE: 0,
		EASY: 1,
		MEDIUM: 2,
		HARD: 3,
		EXTREME: 4
	};

	const table = createTable(readable(data), {
		select: addSelectedRows(),
		sort: addSortBy({
			toggleOrder: ['asc', 'desc']
		}),
		page: addPagination(),
		//filter: addTableFilter({
		//	fn: ({ filterValue, value }) => {
		//		return value.toLowerCase().includes(filterValue.toLowerCase());
		//	}
		//}),
		colFilter: addColumnFilters(),
		hide: addHiddenColumns()
	});

	const columns = table.createColumns([
		table.column({
			accessor: 'name',
			header: 'Name',
			id: 'Name',
			cell: ({ value, row }) => {
				if (row.isData()) {
					return createRender(DataTableValueCell, {
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
			id: 'Type',
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
			id: 'Difficulty',
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
				},
				sort: {
					compareFn: (a: keyof typeof difficultyOrder, b: keyof typeof difficultyOrder) =>
						difficultyOrder[a] - difficultyOrder[b]
				}
			}
		}),
		table.display({
			id: 'actions',
			header: () => {
				return '';
			},
			cell: ({ row }) => {
				if (row.isData() && row.original) {
					return createRender(DataTableRowActions, {
						value: row.original,
						deleteChallenge
					});
				}
				return '';
			},
			plugins: {
				sort: {
					disable: true
				}
			}
		})
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
									<Table.Head {...attrs}>
										<DataTableColumnHeader {props}
											><Render of={cell.render()} /></DataTableColumnHeader
										>
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
						<Table.Row {...rowAttrs}>
							{#each row.cells as cell (cell.id)}
								<Subscribe attrs={cell.attrs()} let:attrs>
									{#if cell.id !== 'actions'}
										<Table.Cell {...attrs}>
											<Render of={cell.render()} />
										</Table.Cell>
									{:else}
										<Table.Cell class="w-12" {...attrs}>
											<Render of={cell.render()} />
										</Table.Cell>
									{/if}
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
