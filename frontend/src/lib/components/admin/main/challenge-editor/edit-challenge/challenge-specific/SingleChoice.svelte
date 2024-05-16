<script lang="ts">
	import * as RadioGroup from '$lib/components/ui/radio-group';
	import { Button } from '$lib/components/ui/button';
	import { Input } from '$lib/components/ui/input';
	import { Trash2, PlusCircle } from 'lucide-svelte';
	import { tick } from 'svelte';

	export let answers: string[];
	export let correct_answer: number;

	let answerIndex: string = correct_answer.toString();

	$: {
		const answerIndexParsed = parseInt(answerIndex ?? '');
		correct_answer = isNaN(answerIndexParsed) ? 0 : answerIndexParsed;
	}

	let rerendering = false;

	const forceRerender = async () => {
		rerendering = true;
		await tick();
		rerendering = false;
	};
</script>

<div class="flex justify-between items-center mb-4">
	<div class="flex flex-col">
		<p class="text-sm text-muted-foreground">
			Fill out the answers and click on the one that is correct.
		</p>
		<p class="text-sm text-muted-foreground">Order will be individually randomized for every user.</p>
	</div>
	<Button on:click={() => (answers = [...answers, ''])}
		><PlusCircle class="h-5 w-5 mr-2" />Add</Button
	>
</div>
{#if !rerendering}
	<RadioGroup.Root value={correct_answer?.toString()} class="flex grow flex-col gap-2 min-w-96">
		{#each Array(Math.ceil(answers.length / 2)) as _, index (index)}
			<div class="flex gap-2">
				<!-- svelte-ignore a11y-click-events-have-key-events -->
				<!-- svelte-ignore a11y-no-static-element-interactions -->
				<div
					class="flex cursor-pointer relative basis-1/2 items-center gap-2"
					on:click={() => (answerIndex = String(index * 2))}
				>
					<Button
						variant={index * 2 === correct_answer ? 'secondary' : 'outline'}
						class="flex justify-start gap-4 grow py-3 px-3 h-full w-full border"
						><RadioGroup.Item value={String(index * 2)} id={String(index * 2)} />
						<Input
							on:click={(e) => e.stopPropagation()}
							class="border-primary"
							placeholder="Answer…"
							bind:value={answers[index * 2]}
						/>
					</Button>
					{#if answers.length > 1}
						<Button
							size="icon"
							variant="outline"
							on:click={() => {
								if (correct_answer > index * 2) {
									correct_answer = correct_answer - 1;
								} else if (correct_answer === index * 2) {
									correct_answer = 0;
								}
								answers = answers.filter((_, i) => i !== index * 2);
								forceRerender();
							}}><Trash2 class="h-5 w-5" /></Button
						>
					{/if}
				</div>
				{#if answers[index * 2 + 1] !== undefined}
					<!-- svelte-ignore a11y-click-events-have-key-events -->
					<!-- svelte-ignore a11y-no-static-element-interactions -->
					<div
						class="flex cursor-pointer relative basis-1/2 items-center gap-2"
						on:click={() => (answerIndex = String(index * 2 + 1))}
					>
						<Button
							variant={index * 2 + 1 === correct_answer ? 'secondary' : 'outline'}
							class="flex justify-start gap-4 grow py-3 px-3 h-full w-full border"
							><RadioGroup.Item value={String(index * 2 + 1)} id={String(index * 2 + 1)} />
							<Input
								on:click={(e) => e.stopPropagation()}
								class="border-primary"
								placeholder="Answer…"
								bind:value={answers[index * 2 + 1]}
							/></Button
						>
						<Button
							size="icon"
							variant="outline"
							on:click={() => {
								if (correct_answer > index * 2 + 1) {
									correct_answer = correct_answer - 1;
								} else if (correct_answer === index * 2 + 1) {
									correct_answer = 0;
								}
								answers = answers.filter((_, i) => i !== index * 2 + 1);
								forceRerender();
							}}><Trash2 class="h-5 w-5" /></Button
						>
					</div>
				{/if}
			</div>
		{/each}
	</RadioGroup.Root>
{/if}
