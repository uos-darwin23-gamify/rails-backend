<script lang="ts">
	import { page } from '$app/stores';
	import { goto } from '$app/navigation';
	import { onMount } from 'svelte';

	let data: any;
	let loading = true;
	const challengeId = $page.url.searchParams.get('id');

	const getChallenge = async () => {
		if (challengeId !== null) {
			const response = await fetch('/api/challenge?id=' + encodeURIComponent(challengeId));
			if (!response.ok) {
				goto('/app/challenges');
			} else {
				data = await response.json();
				loading = false;
			}
		} else {
			goto('/app/challenges');
		}
	};

	onMount(getChallenge);
</script>

{#if loading}
	<div class="grow flex items-center justify-center">
		<span class="loading loading-ring loading-lg" />
	</div>
{:else}
	{JSON.stringify(data)}
{/if}
