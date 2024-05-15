<script lang="ts">
	import { Button } from '$lib/components/ui/button';
	import { Input } from '$lib/components/ui/input';
	import { Trash2, PlusCircle, Code2 } from 'lucide-svelte';
	import { onDestroy, onMount, tick } from 'svelte';
	import { monaco } from '$lib/stores';
	import type Monaco from 'monaco-editor';
	import type { QuestionArrayType, SelectType } from '../EditChallenge.svelte';
	import * as Card from '$lib/components/ui/card';
	import * as Popover from '$lib/components/ui/popover';
	import { Checkbox } from '$lib/components/ui/checkbox';
	import RegexMatchChecker from './RegexMatchChecker.svelte';

	export let code: string;
	export let question_array: QuestionArrayType[];
	export let correct_answer_regex_array: string[];

	type IStandaloneCodeEditor = Monaco.editor.IStandaloneCodeEditor;

	let editorContainer: HTMLElement;
	let editor: IStandaloneCodeEditor;
	let loading = true;

	let ignoreCursorSelectionChange = false;
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

		editor.onDidChangeCursorSelection(() => {
			const selection = editor.getSelection();
			if (selection) {
				const indexOfOpen = codeSelectPopoversOpen.findIndex((x) => x === true);
				if (indexOfOpen !== -1) {
					const startLineNumber = selection.startLineNumber;
					const startColumn = selection.startColumn;
					const endLineNumber = selection.endLineNumber;
					const endColumn = selection.endColumn;

					if (startColumn !== endColumn || startLineNumber !== endLineNumber) {
						question_array[indexOfOpen].select = {
							startLineNumber,
							startColumn,
							endLineNumber,
							endColumn
						};
					} else {
						if (ignoreCursorSelectionChange) {
							ignoreCursorSelectionChange = false;
						} else {
							question_array[indexOfOpen].select = undefined;
						}
					}
				}
			}
		});

		editor.onDidChangeModelContent(() => (code = editor.getValue()));
	});

	onDestroy(() => {
		if (editor) {
			editor.dispose();
		}
	});

	const castSelect = (select: SelectType) =>
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

	let codeSelectPopoversOpen: boolean[] = Array(question_array.length).fill(false);

	$: {
		const selection = editor?.getSelection();
		if (selection) {
			const indexOfOpen = codeSelectPopoversOpen.findIndex((x) => x === true);

			if (indexOfOpen !== -1) {
				if (!!question_array[indexOfOpen].select) {
					const startLineNumber = selection.startLineNumber;
					const startColumn = selection.startColumn;
					const endLineNumber = selection.endLineNumber;
					const endColumn = selection.endColumn;

					const select = question_array[indexOfOpen].select;

					(select?.startColumn !== startColumn ||
						select?.startLineNumber !== startLineNumber ||
						select?.endLineNumber !== endLineNumber ||
						select?.endColumn !== endColumn) &&
						editor?.setSelection(castSelect(question_array[indexOfOpen].select));
				}
			}
		}
	}

	const eventTargetToHTMLElement = (x: EventTarget) => x as HTMLElement;
</script>

<div class="flex flex-col grow relative w-full">
	<div class="flex grow basis-3/5 minimum-height">
		<Card.Root class="flex grow relative w-full h-full">
			{#if loading}
				<div class="grow flex items-center justify-center">
					<span class="loading loading-ring loading-lg" />
				</div>
			{:else}
				<div id="editor" bind:this={editorContainer} class="h-full w-full" />
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
							codeSelectPopoversOpen = [...codeSelectPopoversOpen, false];
						}}><PlusCircle class="h-5 w-5 mr-2" />Add</Button
					>
				</div>
				{#each question_array as _, index (index)}
					<div class="flex gap-4 mb-1 items-end p-1">
						<div class="basis-2/3 sm:text-sm min-w-44 text-xs text-left">
							{#if index === 0}
								<p class="text-sm mb-2">Questions</p>
								<div class="flex gap-4">
									<Input bind:value={question_array[index].question} />
									<Popover.Root
										bind:open={codeSelectPopoversOpen[index]}
										onOutsideClick={(e) => {
											if (
												e.target &&
												typeof eventTargetToHTMLElement(e.target).className === 'string' &&
												eventTargetToHTMLElement(e.target).className.includes(
													'monaco-mouse-cursor-text'
												)
											) {
												e.preventDefault();
											} else {
												ignoreCursorSelectionChange = false;
											}
										}}
									>
										<Popover.Trigger
											><Button
												variant={!!question_array[index].select ? 'secondary' : 'outline'}
												size="icon"><Code2 class="h-5 w-5" /></Button
											></Popover.Trigger
										>
										<Popover.Content>
											<Button
												variant={!!question_array[index].select ? 'secondary' : 'outline'}
												class="flex justify-start gap-4 grow py-3 px-3 h-full w-full border"
												on:click={() => {
													ignoreCursorSelectionChange = true;
													question_array[index].select = question_array[index].select
														? undefined
														: {
																startColumn: 1,
																startLineNumber: 1,
																endColumn:
																	code.split('\n').slice(-1)[0].replace('\t', '    ').length + 1,
																endLineNumber: code.split('\n').length
															};
												}}
											>
												<Checkbox checked={!!question_array[index].select} />
												<p>Select code on question click.</p>
											</Button>
											{#if !!question_array[index].select}
												<p class="text-sm text-muted-foreground py-2">
													Make the code selection in the code editor.
												</p>
												<div class="flex flex-col">
													<p>Start Column: {question_array[index].select?.startColumn}</p>
													<p>Start Line Number: {question_array[index].select?.startLineNumber}</p>
													<p>End Column: {question_array[index].select?.endColumn}</p>
													<p>End Line Number: {question_array[index].select?.endLineNumber}</p>
												</div>
											{/if}
										</Popover.Content>
									</Popover.Root>
								</div>
							{:else}
								<div class="flex gap-4">
									<Input bind:value={question_array[index].question} />
									<Popover.Root
										bind:open={codeSelectPopoversOpen[index]}
										onOutsideClick={(e) => {
											if (
												e.target &&
												typeof eventTargetToHTMLElement(e.target).className === 'string' &&
												eventTargetToHTMLElement(e.target).className.includes(
													'monaco-mouse-cursor-text'
												)
											) {
												e.preventDefault();
											} else {
												ignoreCursorSelectionChange = false;
											}
										}}
									>
										<Popover.Trigger
											><Button
												variant={!!question_array[index].select ? 'secondary' : 'outline'}
												size="icon"><Code2 class="h-5 w-5" /></Button
											></Popover.Trigger
										>
										<Popover.Content>
											<Button
												variant={!!question_array[index].select ? 'secondary' : 'outline'}
												class="flex justify-start gap-4 grow py-3 px-3 h-full w-full border"
												on:click={() => {
													ignoreCursorSelectionChange = true;
													question_array[index].select = question_array[index].select
														? undefined
														: {
																startColumn: 1,
																startLineNumber: 1,
																endColumn:
																	code.split('\n').slice(-1)[0].replace('\t', '    ').length + 1,
																endLineNumber: code.split('\n').length
															};
												}}
											>
												<Checkbox checked={!!question_array[index].select} />
												<p>Select code on question click.</p>
											</Button>
											{#if !!question_array[index].select}
												<p class="text-sm text-muted-foreground py-2">
													Make the code selection in the code editor.
												</p>
												<div class="flex flex-col">
													<p>Start Column: {question_array[index].select?.startColumn}</p>
													<p>Start Line Number: {question_array[index].select?.startLineNumber}</p>
													<p>End Column: {question_array[index].select?.endColumn}</p>
													<p>End Line Number: {question_array[index].select?.endLineNumber}</p>
												</div>
											{/if}
										</Popover.Content>
									</Popover.Root>
								</div>
							{/if}
						</div>
						<div class="min-w-36 basis-1/3 items-center">
							{#if index === 0}
								<p class="text-sm mb-2">Regex Predicates</p>
								<div class=""></div>
								<div class="flex gap-4">
									<Input bind:value={correct_answer_regex_array[index]} />
									<RegexMatchChecker bind:regexPattern={correct_answer_regex_array[index]} />
								</div>
							{:else}
								<div class="flex gap-4">
									<Input bind:value={correct_answer_regex_array[index]} />
									<RegexMatchChecker bind:regexPattern={correct_answer_regex_array[index]} />
								</div>
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
									codeSelectPopoversOpen = codeSelectPopoversOpen.filter((_, i) => i !== index);
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
