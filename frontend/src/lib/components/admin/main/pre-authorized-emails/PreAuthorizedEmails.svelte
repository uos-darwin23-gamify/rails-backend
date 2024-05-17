<script lang="ts">
	import { onMount } from 'svelte';
	import DataTable from './components/data-table.svelte';
	import * as Card from '$lib/components/ui/card';
	import { Button } from '$lib/components/ui/button';
	import type { PreAuthorizedEmail } from './data/schemas';
	import * as Popover from '$lib/components/ui/popover';
	import { Info } from 'lucide-svelte';
	import * as Dialog from '$lib/components/ui/dialog';

	let data: PreAuthorizedEmail[];
	let loading = true;

	const getEmails = async () => {
		loading = true;
		const response = await fetch('/api/admin/pre-authorized-emails');

		if (response.ok) {
			data = (await response.json()).emails;
			loading = false;
		}
	};

	onMount(getEmails);

	let selectedRowIdsStore: any;
	$: selectedRowIds =
		$selectedRowIdsStore !== undefined && Object.keys($selectedRowIdsStore).map((x) => parseInt(x));

	const deleteSelectedEmails = async () => {
		loading = true;

		if (selectedRowIds !== false && selectedRowIds.length > 0) {
			const correspondingEmailIds = selectedRowIds.map((x) => data[x].id);

			const responses: Promise<Response>[] = [];

			correspondingEmailIds.forEach((emailId) => {
				responses.push(
					fetch('/api/admin/pre-authorized-emails', {
						method: 'DELETE',
						body: JSON.stringify({ id: emailId }),
						headers: {
							'Content-Type': 'application/json'
						}
					})
				);
			});

			try {
				await Promise.all(responses);
			} catch (error) {
				console.error(error);
			} finally {
				getEmails();
			}
		}
	};

	export const deleteEmail = async (id: number) => {
		loading = true;

		const correspondingEmailId = data[id].id;
		const response = await fetch('/api/admin/pre-authorized-emails', {
			method: 'DELETE',
			body: JSON.stringify({ id: correspondingEmailId }),
			headers: {
				'Content-Type': 'application/json'
			}
		});
		if (!response.ok) {
			console.error(await response.text);
		}

		getEmails();
	};

	export const editEmail = async (id: number, email: string, group: 'league' | 'global') => {
		loading = true;
		const correspondingEmailId = data[id].id;

		const response = await fetch('/api/admin/pre-authorized-emails', {
			method: 'PUT',
			body: JSON.stringify({ id: correspondingEmailId, email, group }),
			headers: {
				'Content-Type': 'application/json'
			}
		});

		if (!response.ok) {
			console.error(await response.json());
		}

		getEmails();
	};

	export const addNewEmails = async (emails: string[], groupType: 'league' | 'global') => {
		loading = true;

		if (emails.length > 0) {
			const responses: Promise<Response>[] = [];

			emails.forEach((email) => {
				responses.push(
					fetch('/api/admin/pre-authorized-emails', {
						method: 'POST',
						body: JSON.stringify({ email, group: groupType }),
						headers: {
							'Content-Type': 'application/json'
						}
					})
				);
			});

			try {
				await Promise.all(responses);
			} catch (error) {
				console.error(error);
			} finally {
				getEmails();
			}
		}
	};

	let dialogOpen = false;
</script>

{#if loading}
	<div class="grow flex items-center justify-center">
		<span class="loading loading-ring loading-lg" />
	</div>
{:else}
	<div class="flex grow p-4 relative overflow-x-auto">
		<Card.Root class="flex grow relative overflow-x-auto">
			<div class="grow w-full">
				<Card.Header>
					<Card.Title>Pre-authorized Emails</Card.Title>
					<Card.Description>Only these emails can be used by users for signup.</Card.Description>
				</Card.Header>
				<Card.Content>
					<DataTable {data} bind:selectedRowIdsStore {addNewEmails} {deleteEmail} {editEmail} />
				</Card.Content>
				<Card.Footer class="flex justify-end">
					{#if selectedRowIds !== false && selectedRowIds.length > 0}
						<Button variant="destructive" on:click={() => (dialogOpen = true)}>Delete</Button>
					{:else}
						<Popover.Root portal={null}>
							<Popover.Trigger asChild let:builder>
								<Button builders={[builder]} variant="secondary">Delete</Button>
							</Popover.Trigger>
							<Popover.Content class="w-80">
								<div class="flex justify-between space-x-4">
									<div class="shrink-0">
										<Info className="h-4 w-4" />
									</div>
									<div class="space-y-1">
										<h4 class="text-sm font-semibold">Note</h4>
										<p class="text-sm">Select rows from the table to perform a delete operation.</p>
									</div>
								</div>
							</Popover.Content>
						</Popover.Root>
					{/if}
				</Card.Footer>
			</div>
		</Card.Root>
	</div>
	<Dialog.Root bind:open={dialogOpen}>
		<Dialog.Content>
			<Dialog.Header>
				<Dialog.Title>Are you sure absolutely sure?</Dialog.Title>
				<Dialog.Description>
					This action cannot be undone. This will permanently delete the selected pre-authorized
					emails. If the users have already created accounts with these emails, then the accounts
					will still exist after the deletion.
				</Dialog.Description>
			</Dialog.Header>
			<Dialog.Footer class="mt-4 flex sm:justify-between gap-2">
				<Button
					variant="secondary"
					on:click={() => {
						dialogOpen = false;
					}}>Cancel</Button
				>
				<Button
					on:click={() => {
						deleteSelectedEmails();
						dialogOpen = false;
					}}>Delete Emails</Button
				>
			</Dialog.Footer>
		</Dialog.Content>
	</Dialog.Root>
{/if}
