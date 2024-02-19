<script lang="ts">
	import * as Card from '$lib/components/ui/card';
	import { Button } from '$lib/components/ui/button';
	import * as Dialog from '$lib/components/ui/dialog';

	let consentDialogOpen = false;

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
		{
			headerIndex: formFieldsTakingPart.length,
			header: 'How my information will be used during and after the project'
		},
		{
			headerIndex: formFieldsTakingPart.length + formFieldsInfoUsage.length,
			header: 'So that the information you provide can be used legally by the researchers'
		}
	];
	const allFields = [...formFieldsTakingPart, ...formFieldsInfoUsage, ...formFieldsCopyright];

	const findHeader = (index: number) => headers.find(({ headerIndex }) => headerIndex === index);
</script>

<div class="flex grow p-4 relative overflow-x-auto" id="form-container">
	<Card.Root class="flex grow relative overflow-x-auto"
		><div class="grow w-full">
			<Card.Header>
				<Card.Title>Help &amp; Support</Card.Title>
				<!-- <Card.Description></Card.Description> -->
			</Card.Header>
			<Card.Content>
				<div class="flex flex-col gap-4 items-start">
					<p>
						Email to contact in case of any issues or queries: <a
							href="mailto:support@gamifycoding.me">support@gamifycoding.me</a
						>
					</p>
					<Button on:click={() => (consentDialogOpen = true)}>View Consent Form</Button>
				</div></Card.Content
			>
		</div>
	</Card.Root>
</div>
<Dialog.Root bind:open={consentDialogOpen}>
	<Dialog.Content class="flex grow flex-col max-w-none overflow-y-auto h-full-dialog-custom">
		<Card.Header>
			<Card.Title class="text-center">Gamification of Coding Consent Form</Card.Title>
			<!-- <Card.Description>Card Description</Card.Description> -->
		</Card.Header>
		<Card.Content class="flex grow flex-col">
			{#each allFields as field, index (index)}
				{#if findHeader(index) !== undefined}
					<h2 class="font-bold mb-2 text-sm sm:text-base">{findHeader(index)?.header}</h2>
				{/if}
				<div class="flex justify-between gap-12 mb-4">
					<p class="font-thin text-xs sm:text-sm">{field.label}</p>
				</div>
			{/each}
		</Card.Content>
		<Card.Footer class="flex justify-end">
			<Button class="grow sm:grow-0" on:click={() => (consentDialogOpen = false)}>Close</Button>
		</Card.Footer>
	</Dialog.Content>
</Dialog.Root>

<style>
	:global(.h-full-dialog-custom) {
		height: calc(100% - 16px) !important;
	}
</style>
