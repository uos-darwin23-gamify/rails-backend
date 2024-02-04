<script lang="ts">
	import { page } from '$app/stores';
	import { goto } from '$app/navigation';
	import { onMount } from 'svelte';
	import ChallengeType from '$lib/enums/ChallengeType';
	import ScqChallenge from './scq-challenge/ScqChallenge.svelte';
	import McqChallenge from './mcq-challenge/McqChallenge.svelte';
	import ConnectBlocksChallenge from './connect-blocks-challenge/ConnectBlocksChallenge.svelte';
	import CodeOutputChallenge from './code-output-challenge/CodeOutputChallenge.svelte';
	import type { SvelteComponent } from 'svelte';
	import * as Card from '$lib/components/ui/card';
	import { Button } from '$lib/components/ui/button';
	import * as Dialog from '$lib/components/ui/dialog';
	import Badge from './Badge.svelte';
	import { Check, Cross2 } from 'radix-icons-svelte';
	import type { SolutionType } from '$lib/types/challenge-solution';
	import type { ChallengeDataType } from '$lib/types/challenge-data';

	let data: ChallengeDataType;
	let loading = true;
	const challengeId = $page.url.searchParams.get('id');
	let challengeType: ChallengeType;
	let mainComponent: (new (...args: any[]) => SvelteComponent) | null = null;
	let solutionState: SolutionType | null = null;

	let result: boolean | null = null;
	let explanation = '';
	$: dialogOpen = result !== null;
	$: {
		if (!dialogOpen && result !== null) {
			goto('/app/challenges');
		}
	}

	let submissionError = false;
	let challengeTypeDescription = '';
	$: {
		switch (challengeType) {
			case ChallengeType.SCQ:
				challengeTypeDescription = 'Choose the correct answer';
				break;
			case ChallengeType.MCQ:
				challengeTypeDescription = 'Choose all of the correct answers';
				break;
			case ChallengeType.CONNECT_BLOCKS:
				challengeTypeDescription = 'Connect all matching blocks';
				break;
			case ChallengeType.CODE_OUTPUT:
				challengeTypeDescription = 'Analyze the code';
				break;
			default:
				break;
		}
	}

	const getChallenge = async () => {
		if (challengeId !== null) {
			const response = await fetch('/api/challenge?id=' + encodeURIComponent(challengeId));
			if (!response.ok) {
				goto('/app/challenges');
			} else {
				data = await response.json();
				loading = false;

				switch (data.type) {
					case 'ScqChallenge':
						challengeType = ChallengeType.SCQ;
						mainComponent = ScqChallenge;
						break;
					case 'McqChallenge':
						challengeType = ChallengeType.MCQ;
						mainComponent = McqChallenge;
						break;
					case 'ConnectBlocksChallenge':
						challengeType = ChallengeType.CONNECT_BLOCKS;
						mainComponent = ConnectBlocksChallenge;
						break;
					case 'CodeOutputChallenge':
						challengeType = ChallengeType.CODE_OUTPUT;
						mainComponent = CodeOutputChallenge;
						break;
					default:
						goto('/app/challenges');
				}
			}
		} else {
			goto('/app/challenges');
		}
	};

	onMount(getChallenge);

	const submitSolution = async () => {
		if (solutionState === null) return;

		const response = await fetch('/api/challenge', {
			method: 'POST',
			body: JSON.stringify({ id: challengeId, solution: solutionState }),
			headers: {
				'Content-Type': 'application/json'
			}
		});

		// submissionError = response.status === 400;
		// if (submissionError) return;

		result = response.ok;
		submissionError = response.status === 400;
		explanation = (await response.json()).explanation;
	};
</script>

{#if loading}
	<div class="grow flex items-center justify-center">
		<span class="loading loading-ring loading-lg" />
	</div>
{:else}
	<div class="flex grow p-4 relative overflow-x-auto">
		<Card.Root class="flex grow relative overflow-x-auto">
			<div class="grow w-full flex flex-col">
				<Card.Header class="flex flex-row items-start justify-between space-y-0">
					<div class="flex flex-col gap-1.5">
						<Card.Title>{data.name}</Card.Title>
						<Card.Description>{challengeTypeDescription}</Card.Description>
					</div>
					<Badge value={data.difficulty} />
				</Card.Header>
				<Card.Content class="flex grow flex-col">
					<p class="text-wrap mb-4">{data.question_overview}</p>
					<div class="flex grow">
						<svelte:component this={mainComponent} {data} bind:solutionState />
					</div>
				</Card.Content>
				<Card.Footer class="flex justify-between">
					<Button variant="secondary" on:click={() => goto('/app/challenges')}>Back</Button>
					<Button on:click={submitSolution}>Submit Solution</Button>
				</Card.Footer>
			</div>
		</Card.Root>
	</div>
	<Dialog.Root bind:open={dialogOpen}>
		<Dialog.Content>
			<Dialog.Header>
				{#if !submissionError}
					<Dialog.Title class="flex justify-center items-center"
						>{#if result}
							<p>Correct</p>
							<Check class="h-7 w-7 ml-1" style="color: oklch(var(--su));" />
						{:else}
							<p>Incorrect</p>
							<Cross2 class="h-7 w-7 ml-1" style="color: oklch(var(--er));" />
						{/if}</Dialog.Title
					>
					<Dialog.Description class="text-left"
						><p class="text-base mb-1">Explanation:</p>
						{explanation}</Dialog.Description
					>
				{:else}
					<Dialog.Description
						>Error occurred during submission, contact admin for details.</Dialog.Description
					>
				{/if}
			</Dialog.Header>
			<Dialog.Footer class="mt-4">
				<Button on:click={() => goto('/app/challenges')}>Acknowledge</Button>
			</Dialog.Footer>
		</Dialog.Content>
	</Dialog.Root>
{/if}
