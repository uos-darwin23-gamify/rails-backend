<script lang="ts">
	import { Button } from '$lib/components/ui/button';
	import { Input } from '$lib/components/ui/input';
	import { Trash2, PlusCircle } from 'lucide-svelte';
	import { Checkbox } from '$lib/components/ui/checkbox';
	import { tick } from 'svelte';

	export let answers: string[];
	export let correct_answers: number[];
	let checkboxState: boolean[] = Array(answers.length)
		.fill(false)
		.map((_, index) => correct_answers.includes(index));

	$: {
		correct_answers = checkboxState
			.map((value, index) => (value ? index : undefined))
			.filter((index) => index !== undefined) as number[];
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
			Fill out the answers and check the ones that are correct.
		</p>
		<p class="text-sm text-muted-foreground">
			Order will be individually randomized for every user.
		</p>
	</div>
	<Button
		on:click={() => {
			answers = [...answers, ''];
			checkboxState = [...checkboxState, false];
		}}><PlusCircle class="h-5 w-5 mr-2" />Add</Button
	>
</div>
{#if !rerendering}
	<div class="flex grow flex-col gap-2 min-w-96">
		{#each Array(Math.ceil(answers.length / 2)) as _, index (index)}
			<div class="flex gap-2">
				<!-- svelte-ignore a11y-click-events-have-key-events -->
				<!-- svelte-ignore a11y-no-static-element-interactions -->
				<div
					class="flex cursor-pointer relative basis-1/2 items-center gap-2"
					on:click={() => (checkboxState[index * 2] = !checkboxState[index * 2])}
				>
					<Button
						variant={checkboxState[index * 2] ? 'secondary' : 'outline'}
						class="flex justify-start gap-4 grow py-3 px-3 h-full w-full border"
						><Checkbox checked={checkboxState[index * 2]} id={String(index * 2)} />
						<Input
							on:click={(e) => e.stopPropagation()}
							class="border-primary"
							placeholder="Answer…"
							bind:value={answers[index * 2]}
						/></Button
					>{#if answers.length > 1}
						<Button
							size="icon"
							variant="outline"
							on:click={() => {
								answers = answers.filter((_, i) => i !== index * 2);
								checkboxState = checkboxState.filter((_, i) => i !== index * 2);
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
						on:click={() => (checkboxState[index * 2 + 1] = !checkboxState[index * 2 + 1])}
					>
						<Button
							variant={checkboxState[index * 2 + 1] ? 'secondary' : 'outline'}
							class="flex justify-start gap-4 grow py-3 px-3 h-full w-full border"
							><Checkbox checked={checkboxState[index * 2 + 1]} id={String(index * 2 + 1)} />
							<Input
								on:click={(e) => e.stopPropagation()}
								class="border-primary"
								placeholder="Answer…"
								bind:value={answers[index * 2 + 1]}
							/></Button
						><Button
							size="icon"
							variant="outline"
							on:click={() => {
								answers = answers.filter((_, i) => i !== index * 2 + 1);
								checkboxState = checkboxState.filter((_, i) => i !== index * 2 + 1);
								forceRerender();
							}}><Trash2 class="h-5 w-5" /></Button
						>
					</div>
				{/if}
			</div>
		{/each}
	</div>
{/if}
