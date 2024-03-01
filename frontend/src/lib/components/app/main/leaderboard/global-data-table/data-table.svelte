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
		DataTableUsernameCell,
		DataTableEloCell,
		DataTableColumnHeader,
		DataTableToolbar,
		DataTablePagination
	} from '.';
	import type { GlobalLeaderboard } from './data/schemas';

	export let data: GlobalLeaderboard[];
	export let username: string;

	const table = createTable(readable(data), {
		sort: addSortBy({
			toggleOrder: ['asc', 'desc']
		}),
		page: addPagination(),
		colFilter: addColumnFilters(),
		hide: addHiddenColumns()
	});

	const columns = table.createColumns([
		table.column({
			accessor: 'username',
			header: 'Username',
			id: 'username',
			cell: ({ value, row }) => {
				if (row.isData()) {
					return createRender(DataTableUsernameCell, {
						value
					});
				}
				return value;
			},
			plugins: {
				colFilter: {
					fn: ({ filterValue, value }) => {
						const cleanedFilterValue = filterValue.startsWith('@')
							? filterValue.slice(1)
							: filterValue;
						return value.toLowerCase().includes(cleanedFilterValue.toLowerCase());
					},
					initialFilterValue: '',
					render: ({ filterValue }) => {
						return get(filterValue);
					}
				},
				sort: { disable: true }
			}
		}),
		table.column({
			accessor: 'elo',
			header: 'ELO',
			id: 'elo',
			cell: ({ value, row }) => {
				if (row.isData()) {
					return createRender(DataTableEloCell, {
						value
					});
				}
				return value;
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
						<Table.Row
							{...rowAttrs}
							class={rowToRowOriginal(row).username === username ? 'highlight-username' : ''}
						>
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

	:global(.highlight-username) {
		background-color: rgb(66 32 6 / 0.5);
	}
</style>
