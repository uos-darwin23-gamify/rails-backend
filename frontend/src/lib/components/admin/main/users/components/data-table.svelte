<script lang="ts">
	import { readable } from 'svelte/store';
	import { Render, Subscribe, createRender, createTable } from 'svelte-headless-table';
	import * as Table from '$lib/components/new-york/ui/table';
	import {
		addHiddenColumns,
		addPagination,
		addSortBy,
		addTableFilter
	} from 'svelte-headless-table/plugins';
	import {
		DataTableValueCell,
		DataTableRowActionsCell,
		DataTableColumnHeader,
		DataTableToolbar,
		DataTablePagination
	} from '.';
	import { Group, type User } from '../Users.svelte';

	export let data: User[];
	export let deleteUser: (id: number) => Promise<void>;
	export let promoteUser: (id: number) => Promise<void>;

	const table = createTable(readable(data), {
		sort: addSortBy({
			toggleOrder: ['asc', 'desc']
		}),
		page: addPagination(),
		filter: addTableFilter({
			fn: ({ filterValue, value }) => {
				return value.toLowerCase().includes(filterValue.toLowerCase());
			}
		}),
		hide: addHiddenColumns()
	});

	const columns = table.createColumns([
		table.column({
			accessor: 'username',
			header: 'Username',
			id: 'Username',
			cell: ({ value, row }) => {
				if (row.isData()) {
					return createRender(DataTableValueCell, {
						value: '@' + value
					});
				}
				return value;
			}
		}),
		table.column({
			accessor: 'email',
			header: 'Email',
			id: 'Email',
			cell: ({ value, row }) => {
				if (row.isData()) {
					return createRender(DataTableValueCell, {
						value
					});
				}
				return value;
			}
		}),
		table.column({
			accessor: 'group',
			header: 'Group',
			id: 'Group',
			cell: ({ value, row }) => {
				if (row.isData()) {
					return createRender(DataTableValueCell, {
						value: value === Group.ADMIN ? 'Admin' : value.charAt(0).toUpperCase() + value.slice(1)
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
					return createRender(DataTableRowActionsCell, {
						value: row.original,
						deleteUser,
						promoteUser
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

	const rowToRowOriginal = (row: any) => row.original;

	const tableModel = table.createViewModel(columns);

	const { headerRows, pageRows, tableAttrs, tableBodyAttrs } = tableModel;
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
	{#if data.length === 0}
		<p class="text-center text-xl">No Users…</p>
	{:else}
		<DataTablePagination {tableModel} />
	{/if}
</div>
