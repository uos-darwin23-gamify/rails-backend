<script lang="ts">
	import * as Card from '$lib/components/ui/card';
	import { Label } from '$lib/components/ui/label';
	import { onMount } from 'svelte';
	import LeagueProgression from '$lib/components/app/main/leaderboard/league-progression/LeagueProgression.svelte';
	import { ShieldHalf } from 'lucide-svelte';
	import * as Accordion from '$lib/components/ui/accordion';
	import LeagueDataTable from '$lib/components/app/main/leaderboard/league-data-table/data-table.svelte';
	import GlobalDataTable from '$lib/components/app/main/leaderboard/global-data-table/data-table.svelte';

	let username: string;
	let placementChallengesFinished: boolean;
	let group: 'league' | 'global' | 'admin_group' = 'admin_group';
	let stats: any;
	let error: string | undefined = undefined;
	let loading = true;

	const getLeaderboardData = async () => {
		const response = await fetch('/api/leaderboard/data');

		if (!response.ok) {
			error = 'Failed To Fetch Data';
			loading = false;
			return;
		}

		const data = await response.json();
		username = data.username;
		placementChallengesFinished = data.placement_challenges_finished;

		if (placementChallengesFinished) {
			if (data.group === 'league' || data.group === 'global') {
				group = data.group;
				stats = data.stats;
			}
		}

		if (!(data.group === 'league' || data.group === 'global')) {
			error = 'You are an Admin, leaderboard not available';
		}

		loading = false;
	};

	const leagueStateToElos = (leagueState: any) =>
		leagueState.map(({ elo }: { elo: number }) => elo);

	onMount(getLeaderboardData);
</script>

{#if loading}
	<div class="grow flex items-center justify-center">
		<span class="loading loading-ring loading-lg" />
	</div>
{:else if error === undefined}
	<div class="flex grow p-4 relative overflow-x-auto">
		<Card.Root class="flex grow relative overflow-x-auto">
			<div class="grow w-full flex flex-col">
				{#if placementChallengesFinished}
					<Card.Header class="flex flex-row justify-between space-y-0 gap-2 pb-3">
						<div class="flex flex-col gap-3 justify-between">
							<Card.Title>Leaderboard</Card.Title>
							{#if group === 'league'}
								<Card.Description>League Leaderboard</Card.Description>
							{:else}
								<Card.Description>Global Leaderboard</Card.Description>
							{/if}
							<div class="flex flex-col space-y-1.5">
								<Label>ELO:</Label>
								<p class="text-xs leading-none text-muted-foreground">
									{stats.elo}
								</p>
								{#if group === 'league'}
									<Label>Position in league:</Label>
									<p class="text-xs leading-none text-muted-foreground">
										{stats.user_position} out of {stats.total_players_in_league}
									</p>
								{:else}
									<Label>Position on leaderboard:</Label>
									<p class="text-xs leading-none text-muted-foreground">
										{stats.user_position} out of {stats.total_players}
									</p>
								{/if}
							</div>
						</div>
						{#if group === 'league'}
							<div class="flex flex-col gap-1.5 items-center">
								<Card.Title>Current League:</Card.Title>
								<div class="shrink-0">
									<ShieldHalf class="h-14 w-14 -ml-0.5" />
								</div>
								{stats.user_league}
							</div>
						{/if}
					</Card.Header>
					<Card.Content>
						{#if group === 'league'}
							<Accordion.Root>
								<Accordion.Item value="league-progression" class="border-0">
									<Accordion.Trigger class="pt-1 pb-3.5">League Progression</Accordion.Trigger>
									<Accordion.Content class="h-56">
										<div class="flex flex-col gap-4">
											<div class="mt-4">
												<LeagueProgression
													neighbouringLeagues={stats.neighbouring_leagues}
													lowestEloInNextLeague={stats.succeeding_league_lowest_elo_player}
													highestEloInPreviousLeague={stats.preceding_league_highest_elo_player}
													userElo={stats.elo}
												/>
											</div>
										</div>
									</Accordion.Content>
								</Accordion.Item>
							</Accordion.Root>
							<LeagueDataTable data={stats.league_state} {username} />
						{:else}
							<GlobalDataTable data={stats.leaderboard_state} {username} />
						{/if}
					</Card.Content>
				{:else}
					<Card.Header>
						<Card.Title>Leaderboard</Card.Title>
					</Card.Header>
					<div class="flex flex-col grow p-6 pt-0">
						<Card.Root class="flex flex-col grow">
							<Card.Content class="pt-6 grow flex justify-center items-center">
								<p class="leading-none text-muted-foreground">
									Finish all placement challenges to view the leaderboard and your statistics.
								</p>
							</Card.Content>
						</Card.Root>
					</div>
				{/if}
			</div>
		</Card.Root>
	</div>
{:else}
	<div class="p-4 relative flex grow">
		<div class="h-full flex grow overflow-y-auto">
			<Card.Root class="flex grow flex-col">
				<Card.Header>
					<Card.Title>Leaderboard</Card.Title>
				</Card.Header>
				<Card.Content class="flex justify-center items-center grow">
					<Label class="text-error">{error}</Label>
				</Card.Content>
			</Card.Root>
		</div>
	</div>
{/if}
