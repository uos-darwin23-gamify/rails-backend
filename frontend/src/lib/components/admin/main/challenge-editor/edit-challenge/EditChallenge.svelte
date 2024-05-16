<script lang="ts" context="module">
	export type SelectType =
		| {
				startLineNumber: number;
				startColumn: number;
				endLineNumber: number;
				endColumn: number;
		  }
		| undefined;

	export type QuestionArrayType = {
		question: string;
		select: SelectType;
	};
</script>

<script lang="ts">
	import { onMount, tick } from 'svelte';
	import * as Card from '$lib/components/ui/card';
	import * as Tabs from '$lib/components/ui/tabs';
	import { isRight } from 'fp-ts/lib/Either';
	import {
		ChallengeCategory,
		ChallengeType,
		PlacementChallengeType,
		type Challenge,
		type PlacementChallenge
	} from '../ChallengeEditor.svelte';
	import { goto } from '$app/navigation';
	import { page } from '$app/stores';
	import { Button } from '$lib/components/ui/button';
	import SharedProperties from './SharedProperties.svelte';
	import { challengeDifficulties, challengeTypes } from '../data/data';
	import { Label } from '$lib/components/ui/label';
	import * as Popover from '$lib/components/ui/popover';
	import { cn } from '$lib/utils/ui';
	import CalendarIcon from 'lucide-svelte/icons/calendar';
	import {
		DateFormatter,
		parseDate,
		type DateValue,
		getLocalTimeZone
	} from '@internationalized/date';
	import { Calendar } from '$lib/components/ui/calendar/index.js';
	import { Separator } from '$lib/components/ui/separator';
	import SingleChoice from './challenge-specific/SingleChoice.svelte';
	import MultipleChoice from './challenge-specific/MultipleChoice.svelte';
	import CodeOutput from './challenge-specific/CodeOutput.svelte';
	import ConnectBlocksChallenge from './challenge-specific/connect-blocks-challenge/ConnectBlocksChallenge.svelte';
	import { toast } from 'svelte-sonner';
	import * as Accordion from '$lib/components/ui/accordion';

	const INITIAL_CODE_EDITOR_CONTENT = `#include <stdio.h>

int main() {
    // TODO

    return 0;
}`;

	const df = new DateFormatter('en-US', {
		dateStyle: 'long'
	});

	const challengeId = $page.url.searchParams.get('id');
	let challengeData: Challenge | PlacementChallenge;
	let isPlacementChallenge: boolean;

	let name: string;
	let question_overview: string;
	let difficulty: (typeof challengeDifficulties)[0];
	let correct_answer_explanation: string;
	let type: (typeof challengeTypes)[0];
	let date_when_available: DateValue | undefined = undefined;

	let scqData: { answers: string[]; correct_answer: number };
	let mcqData: { answers: string[]; correct_answers: number[] };
	let connectBlocksData: {
		first_group: string[];
		second_group: string[];
		correct_answers: [number, number][];
	};

	let codeOutputData: {
		code: string;
		question_array: QuestionArrayType[];
		correct_answer_regex_array: string[];
	};

	$: {
		if (type?.value !== ChallengeCategory.SCQ) {
			scqData = { answers: [''], correct_answer: 0 };
		}
		if (type?.value !== ChallengeCategory.MCQ) {
			mcqData = { answers: [''], correct_answers: [0] };
		}
		if (type?.value !== ChallengeCategory.CONNECT_BLOCKS) {
			connectBlocksData = { first_group: [''], second_group: [''], correct_answers: [[0, 0]] };
		}
		if (type?.value !== ChallengeCategory.CODE_OUTPUT) {
			codeOutputData = {
				code: INITIAL_CODE_EDITOR_CONTENT,
				question_array: [{ question: '', select: undefined }],
				correct_answer_regex_array: ['']
			};
		}
	}

	let loading = true;

	const getChallenge = async () => {
		loading = true;

		if (challengeId === null) {
			goto('/admin/challenge-editor');
			return;
		}

		const response = await fetch(
			'/api/admin/challenges/single?id=' + encodeURIComponent(challengeId)
		);

		if (response.ok) {
			const data = await response.json();

			if (data.date_when_available === undefined) {
				const validationResult = PlacementChallengeType.decode(data);

				if (isRight(validationResult)) {
					isPlacementChallenge = true;
					challengeData = validationResult.right;
				} else {
					console.error(
						'Invalid placement challenge object received from API: ',
						validationResult.left
					);
					goto('/admin/challenge-editor');
				}
			} else {
				const validationResult = ChallengeType.decode(data);

				if (isRight(validationResult)) {
					isPlacementChallenge = false;
					challengeData = validationResult.right;
				} else {
					console.error('Invalid challenge object received from API: ', validationResult.left);
					goto('/admin/challenge-editor');
				}
			}

			({ name, question_overview, correct_answer_explanation } = {
				...challengeData
			});

			if (!isPlacementChallenge) {
				date_when_available = parseDate((challengeData as Challenge).date_when_available);
			}

			difficulty =
				challengeDifficulties.find(({ value }) => value === challengeData.difficulty) ??
				challengeDifficulties[0];

			type = challengeTypes.find(({ value }) => value === challengeData.type) ?? challengeTypes[0];

			switch (challengeData.type) {
				case ChallengeCategory.SCQ:
					scqData.answers = challengeData.answers;
					scqData.correct_answer = challengeData.correct_answer;
					break;
				case ChallengeCategory.MCQ:
					mcqData.answers = challengeData.answers;
					mcqData.correct_answers = challengeData.correct_answers;
					break;
				case ChallengeCategory.CONNECT_BLOCKS:
					connectBlocksData.first_group = challengeData.first_group;
					connectBlocksData.second_group = challengeData.second_group;
					connectBlocksData.correct_answers = challengeData.correct_answers;
					break;
				case ChallengeCategory.CODE_OUTPUT:
					codeOutputData.code = challengeData.code;
					codeOutputData.question_array = challengeData.question_array;
					codeOutputData.correct_answer_regex_array = challengeData.correct_answer_regex_array;
					break;
				default:
					goto('/admin/challenge-editor');
					break;
			}

			loading = false;
		} else {
			goto('/admin/challenge-editor');
		}
	};

	onMount(getChallenge);

	let rerenderingConnectBlocks = false;
	const forceRerenderConnectBlocks = async () => {
		rerenderingConnectBlocks = true;
		await tick();
		rerenderingConnectBlocks = false;
	};

	let errors: string[] | null = null;

	const validateData = () => {
		let isOk = true;
		errors = [];

		if (!isPlacementChallenge && date_when_available === undefined) {
			isOk = false;
			errors.push('Date not specified.');
		}

		if (name.length === 0) {
			isOk = false;
			errors.push('Challenge name not specified.');
		}

		if (question_overview.length === 0) {
			isOk = false;
			errors.push('Question overview not specified.');
		}

		if (challengeDifficulties.find(({ value }) => value === difficulty.value) === undefined) {
			isOk = false;
			errors.push('Challenge difficulty not specified.');
		}

		if (challengeTypes.find(({ value }) => value === type.value) === undefined) {
			isOk = false;
			errors.push('Challenge type not specified.');
		}

		if (correct_answer_explanation.length === 0) {
			isOk = false;
			errors.push('Correct answer explanation not specified.');
		}

		if (question_overview.length === 0) {
			isOk = false;
			errors.push('Question overview not specified.');
		}

		if (challengeTypes.find(({ value }) => value === type.value) !== undefined) {
			switch (type.value) {
				case ChallengeCategory.SCQ:
					if (typeof scqData.correct_answer !== 'number') {
						isOk = false;
						errors.push('Correct answer not specified.');
					}
					if (!Array.isArray(scqData.answers) || scqData.answers.length === 0) {
						isOk = false;
						errors.push('No answers specified.');
					}
					if (scqData.answers.some((answer) => answer.length === 0)) {
						isOk = false;
						errors.push('Answers for some fields are missing.');
					}
					break;
				case ChallengeCategory.MCQ:
					if (!Array.isArray(mcqData.correct_answers)) {
						isOk = false;
						errors.push('Correct answers not specified.');
					}
					if (!Array.isArray(mcqData.answers) || mcqData.answers.length === 0) {
						isOk = false;
						errors.push('No answers specified.');
					}
					if (mcqData.answers.some((answer) => answer.length === 0)) {
						isOk = false;
						errors.push('Answers for some fields are missing.');
					}
					break;
				case ChallengeCategory.CONNECT_BLOCKS:
					if (
						!Array.isArray(connectBlocksData.first_group) ||
						!Array.isArray(connectBlocksData.second_group) ||
						connectBlocksData.first_group.length === 0 ||
						connectBlocksData.second_group.length === 0
					) {
						isOk = false;
						errors.push('Specify answers for both categories.');
					}
					if (
						!Array.isArray(connectBlocksData.correct_answers) ||
						connectBlocksData.correct_answers.some((x) => x.length !== 2)
					) {
						isOk = false;
						errors.push('Invalid correct connections specification.');
					}
					if (
						!Array.isArray(connectBlocksData.first_group) ||
						!Array.isArray(connectBlocksData.second_group) ||
						connectBlocksData.first_group.some((answer) => answer.length === 0) ||
						connectBlocksData.second_group.some((answer) => answer.length === 0)
					) {
						isOk = false;
						errors.push('Answers for some fields are missing.');
					}
					if (
						Array.from(
							new Set(connectBlocksData.correct_answers.map((x) => JSON.stringify(x))),
							(json) => JSON.parse(json)
						).length !== connectBlocksData.correct_answers.length
					) {
						isOk = false;
						errors.push('Duplicate connections are present.');
					}
					break;
				case ChallengeCategory.CODE_OUTPUT:
					if (typeof codeOutputData.code !== 'string' || codeOutputData.code.length === 0) {
						isOk = false;
						errors.push('Code not specified.');
					}
					if (
						!Array.isArray(codeOutputData.correct_answer_regex_array) ||
						!Array.isArray(codeOutputData.question_array) ||
						codeOutputData.correct_answer_regex_array.some((x) => x.length === 0) ||
						codeOutputData.question_array.some((x) => x.question.length === 0)
					) {
						isOk = false;
						errors.push('Questions or regex predicate patterns for some fields are missing.');
					}
					if (
						Array.isArray(codeOutputData.question_array) &&
						codeOutputData.question_array.some((x) => {
							if (x.select && Array.isArray(errors)) {
								if (
									typeof x.select.startColumn !== 'number' ||
									typeof x.select.startLineNumber !== 'number' ||
									typeof x.select.endColumn !== 'number' ||
									typeof x.select.endLineNumber !== 'number'
								) {
									isOk = false;
									errors.push('Code selection parameters for some question fields are invalid.');
								}
							}
							return false;
						})
					) {
						isOk = false;
						errors.push('Questions or regex predicate patterns for some fields are missing.');
					}
					break;
				default:
					break;
			}
		}

		if (isOk) {
			errors = null;
		}
		errors = errors;
		return isOk;
	};

	const handleEdit = async () => {
		if (!validateData()) {
			toast.error('Provided data is invalid, look at errors for details!');
			return;
		}

		let params: Record<
			string,
			string | string[] | number | number[] | [number, number][] | QuestionArrayType[] | undefined
		> = {
			id: challengeId!,
			date_when_available:
				date_when_available === undefined ? undefined : date_when_available.toString(),
			name,
			question_overview,
			difficulty: difficulty.value,
			type: type.value,
			correct_answer_explanation
		};

		switch (type.value) {
			case ChallengeCategory.SCQ:
				params = { ...params, ...scqData };
				break;
			case ChallengeCategory.MCQ:
				params = { ...params, ...mcqData };
				break;
			case ChallengeCategory.CONNECT_BLOCKS:
				params = { ...params, ...connectBlocksData };
				break;
			case ChallengeCategory.CODE_OUTPUT:
				params = { ...params, ...codeOutputData };
				break;
			default:
				return;
		}

		const response = await fetch('/api/admin/challenges/edit', {
			method: 'PUT',
			body: JSON.stringify(params),
			headers: {
				'Content-Type': 'application/json'
			}
		});

		if (response.ok) {
			toast.success('Challenge updated successfully!');
			goto('/admin/challenge-editor');
		} else {
			toast.error('Internal server error!');
		}
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
				<Card.Header>
					<div class="flex justify-between items-start">
						<Card.Title>Edit Challenge</Card.Title>
						{#if !isPlacementChallenge}
							<div class="flex max-sm:flex-col sm:items-center gap-2 sm:gap-4">
								<Label for="release-date">Release Date</Label>
								<Popover.Root>
									<Popover.Trigger asChild let:builder>
										<Button
											variant="outline"
											class={cn(
												'justify-start text-left font-normal',
												!date_when_available && 'text-muted-foreground'
											)}
											builders={[builder]}
										>
											<CalendarIcon class="mr-2 h-4 w-4" />
											{date_when_available
												? df.format(date_when_available.toDate(getLocalTimeZone()))
												: 'Pick a date'}
										</Button>
									</Popover.Trigger>
									<Popover.Content class="w-auto p-0">
										<Calendar preventDeselect bind:value={date_when_available} initialFocus />
									</Popover.Content>
								</Popover.Root>
							</div>
						{/if}
					</div>
				</Card.Header>
				<Card.Content class="flex flex-col grow">
					<Tabs.Root value={isPlacementChallenge ? 'placement' : 'normal'}>
						<Tabs.List class="w-full overflow-x-auto">
							<Tabs.Trigger disabled class="grow basis-1/2" value="normal"
								>Daily Challenge</Tabs.Trigger
							>
							<Tabs.Trigger disabled class="grow basis-1/2" value="placement"
								>Placement Challenge</Tabs.Trigger
							>
						</Tabs.List>
					</Tabs.Root>
					{#if errors !== null}
						<Accordion.Root class="mt-4" value="errors">
							<Accordion.Item value="errors" class="border-b-0">
								<Accordion.Trigger
									class="bg-accent/30 hover:no-underline hover:bg-accent hover:text-accent-foreground rounded-md h-10 py-2 px-2"
									>Errors:</Accordion.Trigger
								>
								<Accordion.Content class="*:p-0">
									<ul class="list-disc text-red-500 pl-4 py-3">
										{#each errors as error}
											<li>
												{error}
											</li>
										{/each}
									</ul>
									<Separator class="mb-2" />
								</Accordion.Content>
							</Accordion.Item>
						</Accordion.Root>
					{/if}
					<div class="flex flex-col grow">
						<SharedProperties
							bind:name
							bind:question_overview
							bind:difficulty
							bind:correct_answer_explanation
							bind:type
						/>
						<Separator orientation="horizontal" class="mb-6 mt-5" />
						{#if type.value === ChallengeCategory.SCQ}
							<SingleChoice
								bind:answers={scqData.answers}
								bind:correct_answer={scqData.correct_answer}
							/>
						{:else if type.value === ChallengeCategory.MCQ}
							<MultipleChoice
								bind:answers={mcqData.answers}
								bind:correct_answers={mcqData.correct_answers}
							/>
						{:else if type.value === ChallengeCategory.CONNECT_BLOCKS}
							{#if !rerenderingConnectBlocks}
								<ConnectBlocksChallenge
									bind:first_group={connectBlocksData.first_group}
									bind:second_group={connectBlocksData.second_group}
									bind:correct_answers={connectBlocksData.correct_answers}
									{forceRerenderConnectBlocks}
								/>
							{/if}
						{:else if type.value === ChallengeCategory.CODE_OUTPUT}
							<CodeOutput
								bind:code={codeOutputData.code}
								bind:question_array={codeOutputData.question_array}
								bind:correct_answer_regex_array={codeOutputData.correct_answer_regex_array}
							/>
						{/if}
					</div>
				</Card.Content>
				<Card.Footer class="flex justify-between">
					<Button variant="secondary" on:click={() => goto('/admin/challenge-editor')}>Back</Button>
					<Button on:click={handleEdit}>Save</Button>
				</Card.Footer>
			</div>
		</Card.Root>
	</div>
{/if}
