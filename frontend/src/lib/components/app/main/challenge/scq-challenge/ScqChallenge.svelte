<script lang="ts">
	import type { ScqChallengeSolutionType } from '$lib/types/challenge-solution';
	import type { ScqChallengeDataType } from '$lib/types/challenge-data';
	import { Button } from '$lib/components/ui/button';
	import * as RadioGroup from '$lib/components/ui/radio-group';
	import { Label } from '$lib/components/ui/label';
	import { onMount } from 'svelte';

	export let data: ScqChallengeDataType;
	export let solutionState: ScqChallengeSolutionType | null;
	let answerIndex: string | undefined = undefined;

	const lock = solutionState !== null;

	$: {
		if (!lock) {
			const answerIndexParsed = parseInt(answerIndex ?? '');
			solutionState = isNaN(answerIndexParsed) ? null : answerIndexParsed;
		} else {
			answerIndex = solutionState?.toString();
		}
	}

	let indices: number[] = Array.from({ length: data.answers.length }, (_, i) => i);

	// Fisher-Yates algorithm - uniform probability distribution
	onMount(() => {
		for (let i = indices.length - 1; i > 0; i--) {
			const j = Math.floor(Math.random() * (i + 1));
			[indices[i], indices[j]] = [indices[j], indices[i]];
		}
	});
</script>

<RadioGroup.Root
	value={indices.findIndex((value) => value === solutionState).toString()}
	class="flex grow flex-col gap-2"
>
	{#each Array(Math.ceil(data.answers.length / 2)) as _, index (index)}
		<div class="flex gap-2">
			<!-- svelte-ignore a11y-click-events-have-key-events -->
			<!-- svelte-ignore a11y-no-static-element-interactions -->
			<div
				class="flex cursor-pointer relative basis-1/2"
				on:click={() => (answerIndex = String(indices[index * 2]))}
			>
				<Button
					variant={indices[index * 2] === solutionState ? 'secondary' : 'outline'}
					class="flex justify-start gap-4 grow py-3 px-3 h-full w-full border"
					><RadioGroup.Item value={String(index * 2)} id={String(index * 2)} />
					<Label
						class="cursor-pointer text-wrap leading-5 text-left text-xs md:text-sm lg:text-base"
						for={String(index * 2)}>{data.answers[indices[index * 2]]}</Label
					></Button
				>
			</div>
			{#if data.answers[indices[index * 2 + 1]] !== undefined}
				<!-- svelte-ignore a11y-click-events-have-key-events -->
				<!-- svelte-ignore a11y-no-static-element-interactions -->
				<div
					class="flex cursor-pointer relative basis-1/2"
					on:click={() => (answerIndex = String(indices[index * 2 + 1]))}
				>
					<Button
						variant={indices[index * 2 + 1] === solutionState ? 'secondary' : 'outline'}
						class="flex justify-start gap-4 grow py-3 px-3 h-full w-full border"
						><RadioGroup.Item value={String(index * 2 + 1)} id={String(index * 2 + 1)} />
						<Label
							class="cursor-pointer text-wrap leading-5 text-left text-xs md:text-sm lg:text-base"
							for={String(index * 2 + 1)}>{data.answers[indices[index * 2 + 1]]}</Label
						></Button
					>
				</div>
			{/if}
		</div>
	{/each}
</RadioGroup.Root>
