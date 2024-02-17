<script lang="ts">
	import type { McqChallengeSolutionType } from '$lib/types/challenge-solution';
	import type { McqChallengeDataType } from '$lib/types/challenge-data';
	import { Button } from '$lib/components/ui/button';
	import { Checkbox } from '$lib/components/ui/checkbox';
	import { Label } from '$lib/components/ui/label';

	export let data: McqChallengeDataType;
	export let solutionState: McqChallengeSolutionType;

	const lock = solutionState !== null;

	let checkboxState: boolean[] = new Array(data.answers.length).fill(false);

	$: {
		if (!lock) {
			solutionState = checkboxState
				.map((value, index) => (value ? index : undefined))
				.filter((index) => index !== undefined) as McqChallengeSolutionType;
		} else {
			checkboxState = checkboxState.map((_, index) => solutionState!.includes(index));
		}
	}
</script>

<div class="flex grow flex-col gap-2">
	{#each Array.from( { length: Math.ceil(data.answers.length / 2) }, (_, i) => data.answers.slice(i * 2, i * 2 + 2) ) as groupedAnswerPair, index (index)}
		<div class="flex gap-2">
			<!-- svelte-ignore a11y-click-events-have-key-events -->
			<!-- svelte-ignore a11y-no-static-element-interactions -->
			<div
				class="flex cursor-pointer relative basis-1/2"
				on:click={() => (checkboxState[index * 2] = !checkboxState[index * 2])}
			>
				<Button
					variant={checkboxState[index * 2] ? 'secondary' : 'outline'}
					class="flex justify-start gap-4 grow py-3 px-3 h-full w-full border"
					><Checkbox
						disabled={lock}
						bind:checked={checkboxState[index * 2]}
						id={String(index * 2)}
					/>
					<Label
						class="cursor-pointer text-wrap leading-5 text-left text-xs md:text-sm lg:text-base"
						for={String(index * 2)}>{groupedAnswerPair[0]}</Label
					></Button
				>
			</div>
			<!-- svelte-ignore a11y-click-events-have-key-events -->
			<!-- svelte-ignore a11y-no-static-element-interactions -->
			<div
				class="flex cursor-pointer relative basis-1/2"
				on:click={() => (checkboxState[index * 2 + 1] = !checkboxState[index * 2 + 1])}
			>
				<Button
					variant={checkboxState[index * 2 + 1] ? 'secondary' : 'outline'}
					class="flex justify-start gap-4 grow py-3 px-3 h-full w-full border"
					><Checkbox
						disabled={lock}
						bind:checked={checkboxState[index * 2 + 1]}
						id={String(index * 2 + 1)}
					/>
					<Label
						class="cursor-pointer text-wrap leading-5 text-left text-xs md:text-sm lg:text-base"
						for={String(index * 2 + 1)}>{groupedAnswerPair[1]}</Label
					></Button
				>
			</div>
		</div>
	{/each}
</div>
