<script lang="ts">
	import * as Form from '$lib/components/ui/form';
	import { formSchema, type FormSchema } from './schema';
	import type { SuperValidated } from 'sveltekit-superforms';
	import ConsentFormField from './ConsentFormField.svelte';
	import Checkbox from '$lib/components/ui/checkbox/checkbox.svelte';

	export let form: SuperValidated<FormSchema>;

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

	let allChecked = false;

	function toggleAll(event: any) {
		if (event && event.target) {
			// get the current state of the "check all" checkbox
			allChecked = event.target.checked;

			// update the state of all of the checkboxes in the form
			formFieldsTakingPart.forEach((field) => ((form as any)[field.name] = allChecked));
			formFieldsInfoUsage.forEach((field) => ((form as any)[field.name] = allChecked));
			formFieldsCopyright.forEach((field) => ((form as any)[field.name] = allChecked));
		}
	}
</script>

<div class="flex justify-center pb-10">
	<div class="w-1/2">
		<h1 class="text-center text-2xl py-5">Gamification of Coding Consent Form</h1>
		<Form.Root
			method="POST"
			{form}
			schema={formSchema}
			let:config
			class="space-y-6"
		>
        <div class="flex justify-end items-center">
            <div class="flex flex-col items-end">
                <!-- svelte-ignore a11y-label-has-associated-control -->
                <label class="text-sm text-center">Check all</label>
                <div>
                    <Checkbox bind:checked={allChecked} on:click={toggleAll} />
                </div>
            </div>
        </div>


			<h2 class="text-xl">Taking Part in the Project</h2>


			{#each formFieldsTakingPart as { name, label }}
				<ConsentFormField {config} {name} {label} {allChecked} />
			{/each}

			<h2 class="text-xl">How my information will be used during and after the project</h2>
			{#each formFieldsInfoUsage as { name, label }}
				<ConsentFormField {config} {name} {label} {allChecked} />
			{/each}

			<h2 class="text-xl">
				So that the information you provide can be used legally by the researchers
			</h2>
			{#each formFieldsCopyright as { name, label }}
				<ConsentFormField {config} {name} {label} {allChecked} />
			{/each}
			<div class="flex justify-center">
				<Form.Button>Submit</Form.Button>
			</div>
		</Form.Root>
	</div>
</div>
