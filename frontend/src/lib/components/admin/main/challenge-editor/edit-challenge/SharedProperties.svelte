<script lang="ts">
	import { Input } from '$lib/components/ui/input';
	import { Textarea } from '$lib/components/ui/textarea';
	import * as Select from '$lib/components/ui/select';
	import { Label } from '$lib/components/ui/label';
	import { challengeTypes, challengeDifficulties } from '../data/data';
	import { Separator } from '$lib/components/ui/separator';
	import * as Accordion from '$lib/components/ui/accordion';

	export let name: string;
	export let question_overview: string;
	export let difficulty: (typeof challengeDifficulties)[0] = challengeDifficulties[0];
	export let correct_answer_explanation: string;
	export let type: (typeof challengeTypes)[0] = challengeTypes[0];

	let accordionValue = 'overall-details';
</script>

<Accordion.Root bind:value={accordionValue} class="mt-4">
	<Accordion.Item value="overall-details" class="border-b-0">
		<Accordion.Trigger
			class="bg-accent/30 hover:no-underline hover:bg-accent hover:text-accent-foreground rounded-md h-10 py-2 px-2"
			>Overall Details:</Accordion.Trigger
		>
		<Accordion.Content class="*:p-0">
			<div class="flex max-sm:flex-col gap-4 pt-6">
				<div class="flex flex-col gap-6 grow basis-1/3">
					<div class="flex flex-col gap-2">
						<Label for="name">Challenge Name</Label>
						<Input id="name" bind:value={name} />
					</div>
					<div class="flex flex-col gap-2">
						<Label for="difficulty">Difficulty</Label>
						<Select.Root loop bind:selected={difficulty}>
							<Select.Trigger>
								<Select.Value placeholder="Choose difficulty…" />
							</Select.Trigger>
							<Select.Content>
								<Select.Item class="cursor-pointer" value={challengeDifficulties[0].value}
									>{challengeDifficulties[0].label}</Select.Item
								>
								<Select.Item class="cursor-pointer" value={challengeDifficulties[1].value}
									>{challengeDifficulties[1].label}</Select.Item
								>
								<Select.Item class="cursor-pointer" value={challengeDifficulties[2].value}
									>{challengeDifficulties[2].label}</Select.Item
								>
								<Select.Item class="cursor-pointer" value={challengeDifficulties[3].value}
									>{challengeDifficulties[3].label}</Select.Item
								>
								<Select.Item class="cursor-pointer" value={challengeDifficulties[4].value}
									>{challengeDifficulties[4].label}</Select.Item
								>
							</Select.Content>
						</Select.Root>
					</div>
					<div class="flex flex-col gap-2">
						<Label for="type">Type</Label>
						<Select.Root loop bind:selected={type}>
							<Select.Trigger>
								<Select.Value asChild placeholder="Choose difficulty…">
									<div class="flex items-center gap-3">
										<svelte:component this={type.icon} class="mr-1 my-1" />{type.label}
									</div>
								</Select.Value>
							</Select.Trigger>
							<Select.Content>
								<Select.Item class="cursor-pointer" value={challengeTypes[0].value}
									><svelte:component
										this={challengeTypes[0].icon}
										class="mr-1 my-1"
									/>{challengeTypes[0].label}</Select.Item
								>
								<Select.Item class="cursor-pointer" value={challengeTypes[1].value}
									><svelte:component
										this={challengeTypes[1].icon}
										class="mr-1 my-1"
									/>{challengeTypes[1].label}</Select.Item
								>
								<Select.Item class="cursor-pointer" value={challengeTypes[2].value}
									><svelte:component
										this={challengeTypes[2].icon}
										class="mr-1 my-1"
									/>{challengeTypes[2].label}</Select.Item
								>
								<Select.Item class="cursor-pointer" value={challengeTypes[3].value}
									><svelte:component
										this={challengeTypes[3].icon}
										class="mr-1 my-1"
									/>{challengeTypes[3].label}</Select.Item
								>
							</Select.Content>
						</Select.Root>
					</div>
				</div>
				<Separator orientation="vertical" class="max-sm:hidden mx-2 h-auto" />
				<Separator orientation="horizontal" class="sm:hidden my-2" />
				<div class="flex flex-col gap-6 grow basis-2/3">
					<div class="flex flex-col gap-2">
						<Label for="question-overview">Question Overview</Label>
						<Textarea id="question-overview" bind:value={question_overview} />
					</div>
					<div class="flex flex-col gap-2">
						<Label for="correct-answer-explanation">Correct Answer Explanation</Label>
						<Textarea id="correct-answer-explanation" bind:value={correct_answer_explanation} />
					</div>
				</div>
			</div>
		</Accordion.Content>
	</Accordion.Item>
</Accordion.Root>
