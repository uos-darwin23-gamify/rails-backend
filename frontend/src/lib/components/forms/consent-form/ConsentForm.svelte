<script lang="ts">
	import { Checkbox } from '$lib/components/ui/checkbox';
	import * as Card from '$lib/components/ui/card';
	import { Button } from '$lib/components/ui/button';
	import * as Dialog from '$lib/components/ui/dialog';

	const formFieldsTakingPart = [
		{
			name: 'consent1',
			label:
				'I have read and understood the project information sheet dated 07.02.2024 or the project has been fully explained to me. (If you will answer No to this question please do not proceed with this consent form until you are fully aware of what your participation in the project will mean.)'
		},
		{
			name: 'consent2',
			label: 'I have been given the opportunity to ask questions about the project.'
		},
		{ name: 'consent3', label: 'I agree to take part in the project.' },
		{
			name: 'consent4',
			label:
				'I understand that taking part in the project will include completing a number of coding challenges in C (programming language) via an online tool over a period of 2 weeks which should take approximately 10 minutes / day.'
		},
		{
			name: 'consent5',
			label:
				'I understand that taking part in the project will involve filling out a short survey at the end of the experiment term.'
		},
		{
			name: 'consent6',
			label:
				'I understand that by choosing to participate as a volunteer in this research, this does not create a legally binding agreement nor is it intended to create an employment relationship with the University of Sheffield.'
		},
		{
			name: 'consent7',
			label:
				'I understand that my taking part is voluntary and that I can withdraw from the study before 01.05.2024; I do not have to give any reasons for why I no longer want to take part and there will be no adverse consequences if I choose to withdraw.'
		}
	];

	const formFieldsInfoUsage = [
		{
			name: 'consent8',
			label:
				'I understand my personal details such as name, phone number, address and email address etc. will not be revealed to people outside the project.'
		},
		{
			name: 'consent9',
			label:
				'I understand and agree that my words may be quoted in publications, reports, web pages, and other research outputs. I understand that I will not be named in these outputs unless I specifically request this.'
		},
		{
			name: 'consent10',
			label:
				'I understand and agree that other authorised researchers will have access to this data only if they agree to preserve the confidentiality of the information as requested in this form.'
		},
		{
			name: 'consent11',
			label:
				'I understand and agree that other authorised researchers may use my data in publications, reports, web pages, and other research outputs, only if they agree to preserve the confidentiality of the information as requested in this form.'
		},
		{
			name: 'consent12',
			label:
				'I give permission for survey data that I provide and behavioural and performance data collected while using the web application to be deposited in cloud and University Drive storage so it can be used for future research and learning.'
		}
	];

	const formFieldsCopyright = [
		{
			name: 'consent13',
			label:
				'I agree to assign the copyright I hold in any materials generated as part of this project to The University of Sheffield.'
		}
	];

	const headers = [
		{ headerIndex: 0, header: 'Taking Part in the Project' },
		{ headerIndex: formFieldsTakingPart.length, header: 'How my information will be used during and after the project' },
		{ headerIndex: formFieldsTakingPart.length + formFieldsInfoUsage.length, header: 'So that the information you provide can be used legally by the researchers' }
	];
	const allFields = [...formFieldsTakingPart, ...formFieldsInfoUsage, ...formFieldsCopyright];

	let checkboxes: boolean[] = new Array(allFields.length).fill(false);

	const findHeader = (index: number) => headers.find(({ headerIndex }) => headerIndex === index);

	$: allSelected = checkboxes.every((x) => x);

	const handleSelectAll = () => (checkboxes = checkboxes.map(() => !allSelected));

	let dialogOpen = false;

	const handleSubmit = () => {
		console.log('test');
		if (!allSelected) {
			dialogOpen = true;
		} else {
			fetch('/api/consent', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json'
				}
			});
		}
	};
</script>

<form class="p-6 flex grow relative bg-base-100" on:submit|preventDefault={handleSubmit}>
	<Card.Root class="h-full flex overflow-y-auto grow justify-center pb-10">
		<div class="basis-1/2 flex flex-col">
			<Card.Header>
				<Card.Title>Gamification of Coding Consent Form</Card.Title>
				<!-- <Card.Description>Card Description</Card.Description> -->
			</Card.Header>
			<Card.Content>
				<div class="flex justify-end gap-4">
					<p>Select All</p>
					<Checkbox checked={checkboxes.every((x) => x)} on:click={handleSelectAll} />
				</div>
				{#each allFields as field, index (index)}
					{#if findHeader(index) !== undefined}
						<h2>{findHeader(index)?.header}</h2>
					{/if}
					<div class="flex justify-between gap-12">
						<p>{field.label}</p>
						<Checkbox bind:checked={checkboxes[index]} />
					</div>
				{/each}
			</Card.Content>
			<Card.Footer>
				<Button type="submit">Submit</Button>
			</Card.Footer>
		</div>
	</Card.Root>
</form>
<Dialog.Root bind:open={dialogOpen}>
	<Dialog.Content>
		<Dialog.Header>
			<Dialog.Title class="flex justify-center items-center">Consent Needed to Proceed</Dialog.Title>
			<Dialog.Description class="text-left">
				All checkboxes must be selected in order to proceed.</Dialog.Description
			>
		</Dialog.Header>
		<Dialog.Footer class="mt-4">
			<Button on:click={() => (dialogOpen = false)}>Acknowledge</Button>
		</Dialog.Footer>
	</Dialog.Content>
</Dialog.Root>