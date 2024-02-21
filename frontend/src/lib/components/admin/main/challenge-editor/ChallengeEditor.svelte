<script lang="ts">
	import { onMount } from 'svelte';
	import DataTable from './components/data-table.svelte';
	import Modal from './components/Modal.svelte';
	import * as Card from '$lib/components/ui/card';
	import type { ChallengeOverview } from './data/schemas';
	import { toggleMode } from 'mode-watcher';

	let data: ChallengeOverview[];
	let loading = true;
	let showModal = false;

	const getChallengeOverview = async () => {
			loading = true;
			const response = await fetch('/api/admin/challenge-editor-all');

			if (response.ok) {
					data = await response.json();
					loading = false;
			}


	};

	const toggleModal = () => {
				showModal = !showModal;
				console.log("Toggled showModal to:", showModal);
	};

	onMount(getChallengeOverview);
</script>

{#if loading}
	<div class="grow flex items-center justify-center">
		<span class="loading loading-ring loading-lg" />
	</div>
{:else}
	<div class="flex grow p-4 relative overflow-x-auto">
		<Card.Root class="flex grow relative overflow-x-auto">
			<div class="grow w-full">
				<Card.Header class="flex justify-between items-center">
					<div>
						<Card.Title>Challenges</Card.Title>
						<Card.Description>List of all challenges.</Card.Description>
					</div>
					<div>
						<button class="add-challenge-btn" on:click={toggleModal}>Show Modal</button>
					</div>
				</Card.Header>
				<Card.Content>
					<DataTable {data} />
				</Card.Content>
			</div>
		</Card.Root>
	</div>
{/if}
<Modal bind:showModal>
	<h2 slot="header">
		Select and Add questions
	</h2>

	<ol class="definition-list">
		<li>of or relating to modality in logic</li>
		<li>
			containing provisions as to the mode of procedure or the manner of taking effect —used of a
			contract or legacy
		</li>
		<li>of or relating to a musical mode</li>
		<li>of or relating to structure as opposed to substance</li>
		<li>
			of, relating to, or constituting a grammatical form or category characteristically indicating
			predication
		</li>
		<li>of or relating to a statistical mode</li>
	</ol>

</Modal>


<style>
	.add-challenge-btn {
			/* Style your button here */
			padding: 8px 16px;
			background-color: #007BFF;
			color: white;
			border: none;
			border-radius: 4px;
			cursor: pointer;
			font-weight: bold;
	}
	.add-challenge-btn:hover {
			background-color: #0056b3;
	}
</style>
