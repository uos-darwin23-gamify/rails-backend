<script lang="ts">
	import type { CodeOutputChallengeSolutionType } from '$lib/types/challenge-solution';
	import type { CodeOutputChallengeDataType } from '$lib/types/challenge-data';
	import { onMount, onDestroy, tick } from 'svelte';
	import type Monaco from 'monaco-editor';
	import * as Card from '$lib/components/ui/card';
	import { Input } from '$lib/components/ui/input';
	import { Button } from '$lib/components/ui/button';
	import { monaco } from '$lib/stores';

	export let data: CodeOutputChallengeDataType;
	export let solutionState: CodeOutputChallengeSolutionType;

	let answers: string[] = new Array(data.question_array.length).fill('');
	let loading = true;

	const lock = solutionState !== null;

	$: {
		if (!lock) {
			solutionState = answers;
		} else {
			answers = solutionState!;
		}
	}
	$: atLeastOneSelect = data.question_array.some(({ select }) => select);

	type IStandaloneCodeEditor = Monaco.editor.IStandaloneCodeEditor;

	let editorContainer: HTMLElement;
	let editor: IStandaloneCodeEditor;

	onMount(async () => {
		const monacoInstance = await $monaco;
		monacoInstance.editor.setTheme('vs-dark');

		loading = false;
		await tick();

		editor = monacoInstance.editor.create(editorContainer, {
			value: data.code,
			language: 'c',
			readOnly: true,
			domReadOnly: true,
			minimap: { enabled: false },
			scrollBeyondLastLine: false,
			quickSuggestions: false,
			suggestOnTriggerCharacters: false,
			hover: { enabled: false },
			contextmenu: false,
			tabSize: 2,
			lineNumbersMinChars: 3,
			lineDecorationsWidth: 0,
			automaticLayout: true,
			scrollbar: { vertical: 'visible', horizontal: 'visible', alwaysConsumeMouseWheel: false },
			smoothScrolling: true
		});
		editor.layout();
	});

	onDestroy(() => {
		if (editor) {
			editor.dispose();
		}
	});
</script>

<!-- <svelte:window on:resize={() => editor?.layout()} /> -->

<div class="flex flex-col grow relative w-full">
	<div class="flex grow basis-3/5 minimum-height">
		<Card.Root class="flex grow relative w-full h-full">
			{#if loading}
				<div class="grow flex items-center justify-center">
					<span class="loading loading-ring loading-lg" />
				</div>
			{:else}
				<div bind:this={editorContainer} class="h-full w-full" />
			{/if}
		</Card.Root>
	</div>
	<div class="flex grow basis-2/5 mt-4 overflow-x-auto w-full shrink-0 overflow-y-hidden">
		<div class="flex flex-col grow gap-4">
			{#each data.question_array as item, index (index)}
				<div class="flex gap-4">
					<div class="flex items-center">
						<div class="grow sm:text-sm min-w-44 text-xs text-left">
							{#if atLeastOneSelect}
								{#if item.select}
									<Button
										class="text-wrap h-fit flex"
										variant="outline"
										on:click={() => {
											if (item.select) {
												editor?.setSelection(item.select);
												editor?.revealLine(item.select.startLineNumber);
												editorContainer?.scrollIntoView({ behavior: 'smooth' });
											}
										}}><p class="sm:text-sm text-xs text-left">{item.question}</p></Button
									>
								{:else}
									<p class="px-4">{item.question}</p>
								{/if}
							{:else}
								<p>{item.question}</p>
							{/if}
						</div>
					</div>
					<div class="flex min-w-36 grow items-center">
						{#if index === data.question_array.length - 1 && index === 0}
							<Input
								disabled={lock}
								bind:value={answers[index]}
								class="focus-visible:mr-1 focus-visible:mb-1 focus-visible:mt-1"
							/>
						{:else if index === data.question_array.length - 1}
							<Input
								disabled={lock}
								bind:value={answers[index]}
								class="focus-visible:mr-1 focus-visible:mb-1"
							/>
						{:else if index === 0}
							<Input
								disabled={lock}
								bind:value={answers[index]}
								class="focus-visible:mr-1 focus-visible:mt-1"
							/>
						{:else}
							<Input disabled={lock} bind:value={answers[index]} class="focus-visible:mr-1" />
						{/if}
					</div>
				</div>
			{/each}
		</div>
	</div>
</div>

<style>
	.minimum-height {
		min-height: clamp(200px, 40%, 300px);
		max-height: 400px;
	}

	@media (min-height: 1000px) {
		.minimum-height {
			max-height: 600px;
		}
	}

	@media (min-height: 1500px) {
		.minimum-height {
			max-height: 900px;
		}
	}
</style>
