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
	import { onMount } from 'svelte';
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
					<div class="flex flex-col grow">
						<SharedProperties
							bind:name
							bind:question_overview
							bind:difficulty
							bind:correct_answer_explanation
							bind:type
						/>
						<Separator orientation="horizontal" class="my-6" />
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
							PLACEHOLDER
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
					<Button on:click={() => {}}>Save</Button>
				</Card.Footer>
			</div>
		</Card.Root>
	</div>
{/if}
