<script lang="ts" context="module">
	import * as t from 'io-ts';

	export enum ChallengeCategory {
		SCQ = 'ScqChallenge',
		MCQ = 'McqChallenge',
		CONNECT_BLOCKS = 'ConnectBlocksChallenge',
		CODE_OUTPUT = 'CodeOutputChallenge'
	}

	export enum ChallengeDifficulty {
		SIMPLE = 'SIMPLE',
		EASY = 'EASY',
		MEDIUM = 'MEDIUM',
		HARD = 'HARD',
		EXTREME = 'EXTREME'
	}

	export const ScqChallengeType = t.type({
		type: t.literal(ChallengeCategory.SCQ),
		answers: t.array(t.string),
		correct_answer: t.number
	});

	export const McqChallengeType = t.type({
		type: t.literal(ChallengeCategory.MCQ),
		answers: t.array(t.string),
		correct_answers: t.array(t.number)
	});

	export const ConnectBlocksChallengeType = t.type({
		type: t.literal(ChallengeCategory.CONNECT_BLOCKS),
		first_group: t.array(t.string),
		second_group: t.array(t.string),
		correct_answers: t.array(t.tuple([t.number, t.number]))
	});

	export const CodeOutputChallengeType = t.type({
		type: t.literal(ChallengeCategory.CODE_OUTPUT),
		code: t.string,
		question_array: t.array(
			t.type({
				question: t.string,
				select: t.union([
					t.undefined,
					t.type({
						startLineNumber: t.number,
						startColumn: t.number,
						endLineNumber: t.number,
						endColumn: t.number
					})
				])
			})
		),
		correct_answer_regex_array: t.array(t.string)
	});

	export const PlacementChallengeType = t.intersection([
		t.type({
			id: t.string,
			name: t.string,
			question_overview: t.string,
			difficulty: t.union([
				t.literal(ChallengeDifficulty.SIMPLE),
				t.literal(ChallengeDifficulty.EASY),
				t.literal(ChallengeDifficulty.MEDIUM),
				t.literal(ChallengeDifficulty.HARD),
				t.literal(ChallengeDifficulty.EXTREME)
			]),
			correct_answer_explanation: t.string,
			created_at: t.string
		}),
		t.union([
			ScqChallengeType,
			McqChallengeType,
			ConnectBlocksChallengeType,
			CodeOutputChallengeType
		])
	]);

	export const ChallengeType = t.intersection([
		PlacementChallengeType,
		t.type({
			date_when_available: t.string
		})
	]);

	export type Challenge = t.TypeOf<typeof ChallengeType>;
	export type PlacementChallenge = t.TypeOf<typeof PlacementChallengeType>;

	enum ViewMode {
		CHALLENGES = 'challenges',
		PLACEMENT_CHALLENGES = 'placementChallenges'
	}
</script>

<script lang="ts">
	import { onMount } from 'svelte';
	import ChallengeDataTable from './challenge-data-table/data-table.svelte';
	import PlacementChallengeDataTable from './placement-challenge-data-table/data-table.svelte';
	import * as Card from '$lib/components/ui/card';
	import * as Tabs from '$lib/components/ui/tabs';
	import { isRight } from 'fp-ts/lib/Either';
	import { toast } from 'svelte-sonner';
	import Button from '$lib/components/new-york/ui/button/button.svelte';
	import { Pencil1 } from 'radix-icons-svelte';

	let challengeData: {
		challenges: Challenge[];
		placementChallenges: PlacementChallenge[];
	} = { challenges: [], placementChallenges: [] };

	let loading = true;

	const getChallenges = async () => {
		loading = true;
		const response = await fetch('/api/admin/challenges');

		if (response.ok) {
			const data = await response.json();

			if (data.challenges === undefined || !Array.isArray(data.challenges)) {
				console.error('Invalid data received from API');
			} else {
				const dataIntermediate: Challenge[] = [];
				data.challenges.forEach((challenge: any) => {
					const validationResult = ChallengeType.decode(challenge);

					if (isRight(validationResult)) {
						const challengeValidated: Challenge = validationResult.right;
						dataIntermediate.push(challengeValidated);
					} else {
						console.error('Invalid challenge object received from API: ', validationResult.left);
					}

					challengeData.challenges = dataIntermediate;
				});
			}

			if (data.placement_challenges === undefined || !Array.isArray(data.placement_challenges)) {
				console.error('Invalid data received from API');
			} else {
				const dataIntermediate: PlacementChallenge[] = [];
				data.placement_challenges.forEach((challenge: any) => {
					const validationResult = PlacementChallengeType.decode(challenge);

					if (isRight(validationResult)) {
						const challengeValidated: PlacementChallenge = validationResult.right;
						dataIntermediate.push(challengeValidated);
					} else {
						console.error(
							'Invalid placement challenge object received from API: ',
							validationResult.left
						);
					}

					challengeData.placementChallenges = dataIntermediate;
				});
			}
			loading = false;
		}
	};

	onMount(getChallenges);

	const deleteChallenge = async (id: string) => {
		const response = await fetch(`/api/admin/challenges/${encodeURIComponent(id)}`, {
			method: 'DELETE'
		});
		if (response.ok) {
			getChallenges();
			toast.success('Challenge deleted successfully!');
		} else {
			toast.error('Challenge deletion failed!');
		}
	};

	let currentViewMode: ViewMode = ViewMode.CHALLENGES;
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
					<div class="flex justify-between items-start">
						<div class="flex flex-col">
							<Card.Title>Challenges</Card.Title>
							<Card.Description>List of all challenges.</Card.Description>
						</div>
						<Button class="h-8"
							><Pencil1 class="h-5 w-5 mr-2" />Create<span class="max-sm:hidden">
								&nbsp;New&nbsp;Challenge</span
							></Button
						>
					</div>
				</Card.Header>
				<Card.Content>
					<Tabs.Root bind:value={currentViewMode}>
						<Tabs.List class="w-full overflow-x-auto">
							<Tabs.Trigger class="grow basis-1/2" value={ViewMode.CHALLENGES}
								>Challenges</Tabs.Trigger
							>
							<Tabs.Trigger class="grow basis-1/2" value={ViewMode.PLACEMENT_CHALLENGES}
								>Placement Challenges</Tabs.Trigger
							>
						</Tabs.List>
						<Tabs.Content value={ViewMode.CHALLENGES}
							><ChallengeDataTable
								data={challengeData.challenges}
								{deleteChallenge}
							/></Tabs.Content
						>
						<Tabs.Content value={ViewMode.PLACEMENT_CHALLENGES}>
							<PlacementChallengeDataTable
								data={challengeData.placementChallenges}
								{deleteChallenge}
							/></Tabs.Content
						>
					</Tabs.Root>
				</Card.Content>
			</div>
		</Card.Root>
	</div>
{/if}
