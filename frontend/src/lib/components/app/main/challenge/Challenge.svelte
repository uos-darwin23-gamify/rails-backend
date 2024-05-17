<script lang="ts">
	import { page } from '$app/stores';
	import { goto } from '$app/navigation';
	import { onMount, onDestroy } from 'svelte';
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

	let startTime: Date = new Date();
	let endTime: Date = new Date();
	let timeElapsedSeconds = 0;
	let interval: ReturnType<typeof setTimeout>;

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

				startTime = new Date(data.start_time);

				if (data.finished) {
					endTime = new Date(data.end_time);
				}

				timeElapsedSeconds = Math.ceil((new Date().getTime() - startTime.getTime()) / 1000);
				interval = setInterval(() => {
					timeElapsedSeconds = Math.ceil((new Date().getTime() - startTime.getTime()) / 1000);
				}, 1000);

				if (data.answer !== null) {
					const answer = JSON.parse(data.answer);
					solutionState = answer;
				}

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

	onDestroy(() => clearInterval(interval));

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

	const formatTime = (seconds: number): string => {
		const minutes = Math.floor(seconds / 60);
		const remainingSeconds = seconds % 60;
		return `${minutes.toString().padStart(2, '0')}:${remainingSeconds.toString().padStart(2, '0')}`;
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
				<Card.Header class="flex flex-row justify-between space-y-0 gap-2">
					<div class="flex flex-col gap-1.5 justify-between">
						<Card.Title>{data.name}</Card.Title>
						<Card.Description>{challengeTypeDescription}</Card.Description>
					</div>
					<div class="flex flex-col justify-between gap-1.5 items-end">
						<Badge value={data.difficulty} />
						{#if data.finished}
							<Card.Description
								>Completed In: {formatTime(
									Math.ceil((endTime.getTime() - startTime.getTime()) / 1000)
								)}</Card.Description
							>
						{:else}
							<Card.Description>Time Elapsed: {formatTime(timeElapsedSeconds)}</Card.Description>
						{/if}
					</div>
				</Card.Header>
				<Card.Content class="flex grow flex-col">
					<p class="text-wrap mb-4">{data.question_overview}</p>
					<div class="flex grow relative overflow-x-auto" id="challenge-container">
						{#if challengeType === ChallengeType.CONNECT_BLOCKS}
							<svelte:component this={mainComponent} dataIntermediate={data} bind:solutionState />
						{:else}
							<svelte:component this={mainComponent} {data} bind:solutionState />
						{/if}
					</div>
				</Card.Content>
				<Card.Footer class="flex justify-between">
					<Button variant="secondary" on:click={() => goto('/app/challenges')}>Back</Button>
					{#if !data.finished}
						<Button on:click={submitSolution}>Submit Solution</Button>
					{/if}
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
