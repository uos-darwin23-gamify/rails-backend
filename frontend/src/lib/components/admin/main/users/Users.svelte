<script lang="ts">
    import { onMount } from 'svelte';
    import * as Card from '$lib/components/ui/card';
    import { Button } from '$lib/components/ui/button';
    import * as Dialog from '$lib/components/ui/dialog';

    let users: any[] = [];  

    onMount(async () => {
        const response = await fetch('/api/admin/users');
        users = await response.json();
    });

    async function deleteUser(id: any) {
        const response = await fetch(`/api/admin/users/${id}`, {
            method: 'DELETE'
        });
        if (response.ok) {
            users = users.filter(user => user.id !== id);
        }
    }

    async function promoteUser(id: any) {
        const response = await fetch(`/api/admin/users/${id}`, {
            method: 'PUT'
        });
        if (response.ok) {

            users = users.map(user => user.id === id ? {...user, user_type: 'admin_group'} : user);
            const user = users.find(user => user.id === id);
            if (user) {
                user.group = 'admin_group';
            }
        }
    }
    let deleteDialogOpen = false;
    let userToDelete: null = null;

    let promoteDialogOpen = false;
    let userToPromote: null = null;
    //$: users = users;
</script>

<div class="flex grow p-4 relative overflow-x-auto">
    <Card.Root class="flex grow relative overflow-x-auto">
        <div class="grow w-full">
            <Card.Header>
                <Card.Title>Users</Card.Title>
            </Card.Header>
            <Card.Content>
                <table>
                    <thead>
                        <tr>
                            <th>Username</th>
                            <th>Rank</th>
                            <th>Group</th>
                        </tr>
                    </thead>
                    <tbody>
                        {#each users as user (user.id)}
                            <tr>
                                <td>{user.username}</td>

                                {#if user.group === 'admin_group'}
                                    <td>Admin</td>
                                {:else}
                                    <td>{user.rank}</td>
                                {/if}

                                {#if user.group === 'admin_group'}
                                    <td>Admin</td>
                                {:else if user.group == 'league_group'}
                                    <td>League</td>
                                {:else}
                                    <td>Global</td>
                                {/if}

                                <td><Button on:click={() => (deleteDialogOpen = true, userToDelete = user.id)}>Delete</Button></td>
                                
                                {#if user.group !== 'admin_group'}
                                    <td><Button on:click={() => (promoteDialogOpen = true, userToPromote = user.id)}>Promote to Admin</Button></td>
                                {/if}
                            </tr>
                        {/each}
                    </tbody>
                </table>
            </Card.Content>
        </div>
    </Card.Root>
</div>

<Dialog.Root bind:open={deleteDialogOpen}>
    <Dialog.Content>
        <Dialog.Header>
            <Dialog.Title>Are you absolutely sure?</Dialog.Title>
            <Dialog.Description>
                This action cannot be undone. This will permanently delete the selected user.
            </Dialog.Description>
        </Dialog.Header>
        <Dialog.Footer class="mt-4 flex sm:justify-between gap-2">
            <Button
                variant="secondary"
                on:click={() => {
                    deleteDialogOpen = false;
                }}>Cancel</Button
            >
            <Button
                on:click={() => {
                    deleteUser(userToDelete);
                    deleteDialogOpen = false;
                    userToDelete = null;
                }}>Delete User</Button
            >
        </Dialog.Footer>
    </Dialog.Content>
</Dialog.Root>

<Dialog.Root bind:open={promoteDialogOpen}>
    <Dialog.Content>
        <Dialog.Header>
            <Dialog.Title>Are you absolutely sure?</Dialog.Title>
            <Dialog.Description>
                This action cannot be undone. This will permanently promote the user to an admin.
            </Dialog.Description>
        </Dialog.Header>
        <Dialog.Footer class="mt-4 flex sm:justify-between gap-2">
            <Button
                variant="secondary"
                on:click={() => {
                    promoteDialogOpen = false;
                }}>Cancel</Button
            >
            <Button
                on:click={() => {
                    promoteUser(userToPromote)
                    promoteDialogOpen = false;
                    userToPromote = null;
                }}>Promote User</Button
            >
        </Dialog.Footer>
    </Dialog.Content>
</Dialog.Root>

<style>
    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        text-align: left;
    }
</style>