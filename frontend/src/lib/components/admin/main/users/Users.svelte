<script lang="ts">
    import { onMount } from 'svelte';
    import * as Card from '$lib/components/ui/card';

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
                                <td>{user.rank}</td>
                                <td>{user.group}</td>
                                <td><button on:click={() => deleteUser(user.id)}>Delete</button></td>
                                {#if user.group !== 'admin_group'}
                                    <button on:click={() => promoteUser(user.id)}>Promote to Admin</button>
                                {/if}
                            </tr>
                        {/each}
                    </tbody>
                </table>
            </Card.Content>
        </div>
    </Card.Root>
</div>