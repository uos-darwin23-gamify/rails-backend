<script lang="ts">
	import { get, readable } from 'svelte/store';
	import { Render, Subscribe, createRender, createTable } from 'svelte-headless-table';
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
		DataTableTitleCell,
		DataTableRowActions,
		// DataTablePriorityCell,
		DataTableColumnHeader,
		DataTableToolbar,
		DataTablePagination
	} from '.';

	import type { PreAuthorizedEmail } from '../data/schemas';

	export let data: PreAuthorizedEmail[];

	const table = createTable(readable(data), {
		select: addSelectedRows(),
		sort: addSortBy({
			toggleOrder: ['asc', 'desc']
		}),
		page: addPagination(),
		filter: addTableFilter({
			fn: ({ filterValue, value }) => {
				return value.toLowerCase().includes(filterValue.toLowerCase());
			}
		}),
		colFilter: addColumnFilters(),
		hide: addHiddenColumns()
	});

	export let deleteEmail: (id: number) => Promise<void>;

	const columns = table.createColumns([
		table.display({
			id: 'select',
			header: (_, { pluginStates }) => {
				const { allPageRowsSelected } = pluginStates.select;
				return createRender(DataTableCheckbox, {
					checked: allPageRowsSelected,
					'aria-label': 'Select all'
				});
			},
			cell: ({ row }, { pluginStates }) => {
				const { getRowState } = pluginStates.select;
				const { isSelected } = getRowState(row);
				return createRender(DataTableCheckbox, {
					checked: isSelected,
					'aria-label': 'Select row',
					class: 'translate-y-[2px]'
				});
			},
			plugins: {
				sort: {
					disable: true
				}
			}
		}),
		table.column({
			accessor: 'email',
			header: 'Email',
			id: 'email',
			cell: ({ value, row }) => {
				if (row.isData()) {
					return createRender(DataTableTitleCell, {
						value
						// ,labelValue: row.original.email
					});
				}
				return value;
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
						row: row.original,
						deleteEmail,
						rowId: parseInt(row.id)
					});
				}
				return '';
			}
		})
	]);

	const tableModel = table.createViewModel(columns);

	const { headerRows, pageRows, tableAttrs, tableBodyAttrs, pluginStates } = tableModel;

	export const selectedRowIdsStore = pluginStates.select.selectedDataIds;
	export let addNewEmails: (emails: string[]) => Promise<void>;
</script>

<div class="space-y-4">
	<DataTableToolbar {tableModel} {addNewEmails} />
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
										class={cell.id === 'select'
											? 'checkbox-custom-class'
											: cell.id === 'actions'
												? 'actions-custom-class'
												: ''}
									>
										{#if cell.id !== 'select' && cell.id !== 'actions'}
											<DataTableColumnHeader {props}
												><Render of={cell.render()} /></DataTableColumnHeader
											>
										{:else}
											<Render of={cell.render()} />
										{/if}
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
	:global(.checkbox-custom-class) {
		width: 4rem;
	}

	:global(.actions-custom-class) {
		width: 3rem;
	}
</style>
