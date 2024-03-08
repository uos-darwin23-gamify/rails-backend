<script lang="ts">
	import type { McqChallengeSolutionType } from '$lib/types/challenge-solution';
	import type { McqChallengeDataType } from '$lib/types/challenge-data';
	import { Button } from '$lib/components/ui/button';
	import { Checkbox } from '$lib/components/ui/checkbox';
	import { Label } from '$lib/components/ui/label';
	import { onMount } from 'svelte';

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

	let indices: number[] = Array.from({ length: data.answers.length }, (_, i) => i);

	// Fisher-Yates algorithm - uniform probability distribution
	onMount(() => {
		for (let i = indices.length - 1; i > 0; i--) {
			const j = Math.floor(Math.random() * (i + 1));
			[indices[i], indices[j]] = [indices[j], indices[i]];
		}
	});
</script>

<div class="flex grow flex-col gap-2">
	{#each Array(Math.ceil(data.answers.length / 2)) as _, index (index)}
		<div class="flex gap-2">
			<!-- svelte-ignore a11y-click-events-have-key-events -->
			<!-- svelte-ignore a11y-no-static-element-interactions -->
			<div
				class="flex cursor-pointer relative basis-1/2"
				on:click={() => (checkboxState[indices[index * 2]] = !checkboxState[indices[index * 2]])}
			>
				<Button
					variant={checkboxState[indices[index * 2]] ? 'secondary' : 'outline'}
					class="flex justify-start gap-4 grow py-3 px-3 h-full w-full border"
					><Checkbox
						disabled={lock}
						bind:checked={checkboxState[indices[index * 2]]}
						id={String(index * 2)}
					/>
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
					on:click={() =>
						(checkboxState[indices[index * 2 + 1]] = !checkboxState[indices[index * 2 + 1]])}
				>
					<Button
						variant={checkboxState[indices[index * 2 + 1]] ? 'secondary' : 'outline'}
						class="flex justify-start gap-4 grow py-3 px-3 h-full w-full border"
						><Checkbox
							disabled={lock}
							bind:checked={checkboxState[indices[index * 2 + 1]]}
							id={String(index * 2 + 1)}
						/>
						<Label
							class="cursor-pointer text-wrap leading-5 text-left text-xs md:text-sm lg:text-base"
							for={String(index * 2 + 1)}>{data.answers[indices[index * 2 + 1]]}</Label
						></Button
					>
				</div>
			{/if}
		</div>
	{/each}
</div>
