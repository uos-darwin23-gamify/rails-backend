<script lang="ts">
	import type { CodeOutputChallengeSolutionType } from '$lib/types/challenge-solution';
	import type { CodeOutputChallengeDataType } from '$lib/types/challenge-data';
	import { onMount, onDestroy } from 'svelte';
	import type { editor as monacoEditor } from 'monaco-editor';
	import type * as Monaco from 'monaco-editor';
	import loader from '@monaco-editor/loader';
	import * as Card from '$lib/components/ui/card';
	import { Input } from '$lib/components/ui/input';
	import { Button } from '$lib/components/ui/button';

	export let data: CodeOutputChallengeDataType;
	export let solutionState: CodeOutputChallengeSolutionType;

	let answers: string[] = new Array(data.question_array.length).fill('');

	$: solutionState = answers;
	$: atLeastOneSelect = data.question_array.some(({ select }) => select);

	type IStandaloneCodeEditor = monacoEditor.IStandaloneCodeEditor;

	let monaco: typeof Monaco;
	let editorContainer: HTMLElement;
	let editor: IStandaloneCodeEditor;

	onMount(async () => {
		const monacoEditor = await import('monaco-editor');
		loader.config({ monaco: monacoEditor.default });

		monaco = await loader.init();
		monaco.editor.setTheme('vs-dark');

		editor = monaco.editor.create(editorContainer, {
			value: data.code,
			language: 'c',
			readOnly: true,
			minimap: { enabled: false },
			scrollBeyondLastLine: false
		});
	});

	onDestroy(() => {
		if (editor) {
			editor.dispose();
		}
	});

	// function selectLines() {
	//     // Define the range of lines to select.
	//     // Here, we select lines 2 to 4 (1-indexed).
	//     const range = {
	//         startLineNumber: 2,
	//         startColumn: 1,
	//         endLineNumber: 4,
	//         endColumn: 1
	//     };

	//     // Set the selection in the editor.
	//     editor.setSelection(range);
	// }
</script>

<svelte:window on:resize={() => editor.layout()} />

<div class="flex flex-col grow relative">
	<div class="flex grow basis-2/3 relative minimum-height">
		<Card.Root class="relative w-full">
			<div bind:this={editorContainer} class="h-full w-full absolute" />
		</Card.Root>
	</div>
	<div class="flex flex-col grow basis-1/3 mt-4 gap-4 w-full">
		{#each data.question_array as item, index (index)}
			<div class="flex gap-4">
				<div class="flex items-center">
					<div class="grow text-sm">
						{#if atLeastOneSelect}
							{#if item.select}
								<Button
									variant="outline"
									on:click={() => item.select && editor.setSelection(item.select)}
									>{item.question}</Button
								>
							{:else}
								<p class="px-4">{item.question}</p>
							{/if}
						{:else}
							<p>{item.question}</p>
						{/if}
					</div>
				</div>
				<div class="flex min-w-20 grow items-center">
					<Input bind:value={answers[index]} />
				</div>
			</div>
		{/each}
	</div>
</div>

<style>
	.minimum-height {
		min-height: calc(max(40%, 200px));
	}
</style>
