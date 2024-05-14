<script lang="ts">
	import * as RadioGroup from '$lib/components/ui/radio-group';
	import { Button } from '$lib/components/ui/button';
	import { Input } from '$lib/components/ui/input';
	import { Trash2, PlusCircle } from 'lucide-svelte';
	import { onDestroy, onMount, tick } from 'svelte';
	import { monaco } from '$lib/stores';
	import type Monaco from 'monaco-editor';
	import type { QuestionArrayType } from '../EditChallenge.svelte';
	import * as Card from '$lib/components/ui/card';

	export let code: string;
	export let question_array: QuestionArrayType[];
	export let correct_answer_regex_array: string[];

	type IStandaloneCodeEditor = Monaco.editor.IStandaloneCodeEditor;

	let editorContainer: HTMLElement;
	let editor: IStandaloneCodeEditor;
	let loading = true;

	onMount(async () => {
		const monacoInstance = await $monaco;
		monacoInstance.editor.setTheme('vs-dark');

		loading = false;
		await tick();

		editor = monacoInstance.editor.create(editorContainer, {
			value: code,
			language: 'c',
			minimap: { enabled: false },
			scrollBeyondLastLine: false,
			hover: { enabled: false },
			tabSize: 2,
			lineNumbersMinChars: 3,
			lineDecorationsWidth: 0,
			automaticLayout: true,
			scrollbar: { vertical: 'visible', horizontal: 'visible', alwaysConsumeMouseWheel: false },
			smoothScrolling: true
		});
		editor.layout();
		editor.onDidChangeModelContent(() => {
			code = editor.getValue();
		});
	});

	onDestroy(() => {
		if (editor) {
			editor.dispose();
		}
	});

	const castSelect = (select: any) =>
		select as {
			startLineNumber: number;
			startColumn: number;
			endLineNumber: number;
			endColumn: number;
		};

	let rerendering = false;

	const forceRerender = async () => {
		rerendering = true;
		await tick();
		rerendering = false;
	};
</script>

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
	{#if !rerendering}
		<div class="flex grow basis-2/5 mt-4 overflow-x-auto w-full shrink-0 overflow-y-hidden">
			<div class="flex flex-col grow gap-4">
				<div class="flex justify-between mb-4">
					<div class="flex flex-col">
						<p class="text-sm text-muted-foreground">
							Fill out the questions and regular expressions for answer correctness matching.
						</p>
						<p class="text-sm text-muted-foreground">
							Order will be individually randomized for every user.
						</p>
					</div>
					<Button
						on:click={() => {
							question_array = [
								...question_array,
								{
									question: '',
									select: undefined
								}
							];
							correct_answer_regex_array = [...correct_answer_regex_array, ''];
						}}><PlusCircle class="h-5 w-5 mr-2" />Add</Button
					>
				</div>
				{#each question_array as _, index (index)}
					<div class="flex gap-4 mb-1 items-end p-1">
						<div class="grow sm:text-sm min-w-44 text-xs text-left">
							{#if index === 0}
								<p class="text-sm mb-2">Questions</p>
								<Input bind:value={question_array[index].question} />
							{:else}
								<Input bind:value={question_array[index].question} />
							{/if}
						</div>
						<div class="min-w-36 grow items-center">
							{#if index === 0}
								<p class="text-sm mb-2">Regex Predicates</p>
								<Input bind:value={correct_answer_regex_array[index]} />
							{:else}
								<Input bind:value={correct_answer_regex_array[index]} />
							{/if}
						</div>
						{#if question_array.length > 1 && correct_answer_regex_array.length > 1}
							<Button
								size="icon"
								variant="outline"
								on:click={() => {
									question_array = question_array.filter((_, i) => i !== index);
									correct_answer_regex_array = correct_answer_regex_array.filter(
										(_, i) => i !== index
									);
									forceRerender();
								}}><Trash2 class="h-5 w-5" /></Button
							>
						{/if}
					</div>
				{/each}
			</div>
		</div>
	{/if}
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
