<script lang="ts">
	import * as Card from '$lib/components/ui/card';
	import { Label } from '$lib/components/ui/label';
	import { onMount } from 'svelte';

	let error: string | undefined = undefined;
	let loading = true;
	let currentElo: number;

	const getElo = async () => {
		const response = await fetch('/api/elo');

		if (!response.ok) {
			error = 'Failed to fetch elo.';
			return;
		}

		currentElo = (await response.json()).elo;
		error = undefined;
		loading = false;
	};

	onMount(getElo);
</script>

{#if loading}
	<div class="grow flex items-center justify-center">
		<span class="loading loading-ring loading-lg" />
	</div>
{:else}
	<div class="p-4 relative flex grow">
		<div class="h-full flex grow overflow-y-auto">
			<Card.Root class="flex grow flex-col">
				<Card.Header>
					<Card.Title>Leaderboard</Card.Title>
				</Card.Header>
				<Card.Content class="flex justify-center items-center">
					{#if error !== undefined}
						<Label class="text-error">{error}</Label>
					{:else}
						<div class="flex flex-col">
							<p>Current ELO:</p>
							<p>{currentElo}</p>
						</div>
					{/if}
				</Card.Content>
			</Card.Root>
		</div>
	</div>
{/if}
