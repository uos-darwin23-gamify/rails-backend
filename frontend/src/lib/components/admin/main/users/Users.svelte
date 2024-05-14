<script lang="ts" context="module">
	import * as t from 'io-ts';

	export enum Group {
		LEAGUE = 'league',
		GLOBAL = 'global',
		ADMIN = 'admin_group'
	}

	export const UserType = t.type({
		id: t.number,
		username: t.string,
		email: t.string,
		group: t.union([t.literal(Group.LEAGUE), t.literal(Group.GLOBAL), t.literal(Group.ADMIN)])
	});

	export type User = t.TypeOf<typeof UserType>;
</script>

<script lang="ts">
	import { onMount } from 'svelte';
	import * as Card from '$lib/components/ui/card';
	import { isRight } from 'fp-ts/lib/Either';
	import DataTable from './components/data-table.svelte';
	import { toast } from 'svelte-sonner';
	import { authenticated } from '$lib/stores';

	let users: User[] = [];
	let loading = true;

	const getUsers = async () => {
		loading = true;
		const response = await fetch('/api/admin/users');

		if (response.ok) {
			const data = await response.json();

			const dataIntermediate: User[] = [];

			data.forEach((user: any) => {
				const validationResult = UserType.decode(user);

				if (isRight(validationResult)) {
					const userValidated: User = validationResult.right;
					dataIntermediate.push(userValidated);
				} else {
					console.error('Invalid user object received from API: ', validationResult.left);
				}
			});

			users = dataIntermediate;
			loading = false;
		}
	};

	const deleteUser = async (id: number) => {
		const response = await fetch(`/api/admin/users/${encodeURIComponent(id)}`, {
			method: 'DELETE'
		});
		if (response.ok) {
			authenticated.verify();
			getUsers();
			toast.success('User deleted successfully!');
		} else {
			toast.error('User deletion failed!');
		}
	};

	const promoteUser = async (id: number) => {
		const response = await fetch(`/api/admin/users/${encodeURIComponent(id)}`, {
			method: 'PUT'
		});
		if (response.ok) {
			getUsers();
			toast.success('User promoted successfully!');
		} else {
			toast.error('User promotion failed!');
		}
	};

	onMount(getUsers);
</script>

<div class="flex grow p-4 relative overflow-x-auto">
	{#if loading}
		<div class="grow flex items-center justify-center">
			<span class="loading loading-ring loading-lg" />
		</div>
	{:else}
		<Card.Root class="flex grow relative overflow-x-auto">
			<div class="grow w-full">
				<Card.Header>
					<Card.Title>Users</Card.Title>
				</Card.Header>
				<Card.Content>
					<DataTable data={users} {deleteUser} {promoteUser} />
				</Card.Content>
			</div>
		</Card.Root>
	{/if}
</div>
