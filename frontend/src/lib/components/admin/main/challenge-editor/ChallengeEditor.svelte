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
			console.log(data);
			loading = false;
		}
	};

	const toggleModal = () => {
		showModal = !showModal;
		console.log('Toggled showModal to:', showModal);
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
				</Card.Header>
				<Card.Content>
					<DataTable {data} />
				</Card.Content>
			</div>
		</Card.Root>
	</div>
{/if}

