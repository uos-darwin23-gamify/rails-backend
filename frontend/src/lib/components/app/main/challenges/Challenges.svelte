<script lang="ts">
	import { onMount } from 'svelte';
	import DataTable from './components/data-table.svelte';
	import * as Card from '$lib/components/ui/card';
	import type { ChallengeOverview } from './data/schemas';

	let data: ChallengeOverview[];
	let loading = true;

	let placementChallenges = false;

	const getChallengeOverviews = async () => {
		loading = true;
		const responseChallenges = await fetch('/api/challenges');
		const responsePlacementChallengesFinished = await fetch('/api/placement-challenges-finished');

		if (responseChallenges.ok && responsePlacementChallengesFinished.ok) {
			data = await responseChallenges.json();
			placementChallenges = !(await responsePlacementChallengesFinished.json())
				.placement_challenges_finished;
			loading = false;
		}
	};

	onMount(getChallengeOverviews);
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
					<Card.Title>{placementChallenges ? 'Placement Challenges' : 'Challenges'}</Card.Title>
					<Card.Description
						>{placementChallenges
							? 'Complete these challenges to get your initial ranking.'
							: 'Complete challenges to gain points and move up the leaderboard.'}</Card.Description
					>
				</Card.Header>
				<Card.Content>
					<DataTable {data} />
				</Card.Content>
				<!-- <Card.Footer class="flex justify-end">
					{#if selectedRowIds !== false && selectedRowIds.length > 0}
						<Button variant="destructive" on:click={deleteSelectedEmails}>Delete</Button>
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
				</Card.Footer> -->
			</div>
		</Card.Root>
	</div>
{/if}
