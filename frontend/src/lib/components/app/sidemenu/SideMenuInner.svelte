<script lang="ts">
	import AppUrls from '$lib/enums/AppUrls';
	import { createEventDispatcher } from 'svelte';
	import { Home, Swords, Settings2 } from 'lucide-svelte';
	import { Button } from '$lib/components/ui/button';
	import LogoutButton from '$lib/components/LogoutButton.svelte';

	export let slug: string | undefined;

	const dispatch = createEventDispatcher();
</script>

<ul class="menu menu-lg p-4 min-h-full text-base-content flex-nowrap">
	<li>
		<Button
			variant={!slug ? 'secondary' : 'outline'}
			href={`/app${AppUrls.HOME ? '/' + AppUrls.HOME : ''}`}
			data-testid="home-button"
			on:click={() => dispatch('sideMenuItemClicked')}
			class="flex items-center text-sm justify-start"><Home class="h-5 w-5 mr-2" />Home</Button
		>
	</li>
	<div class="my-1" />
	<li>
		<Button
			variant={slug === AppUrls.CHALLENGES ? 'secondary' : 'outline'}
			href={`/app${AppUrls.CHALLENGES ? '/' + AppUrls.CHALLENGES : ''}`}
			data-testid="challenges-button"
			on:click={() => dispatch('sideMenuItemClicked')}
			class="flex items-center text-sm justify-start"
			><Swords class="h-5 w-5 mr-2" />Challenges</Button
		>
	</li>
	<div class="my-1" />
	<li>
		<Button
			variant={slug === AppUrls.SETTINGS ? 'secondary' : 'outline'}
			href={`/app${AppUrls.SETTINGS ? '/' + AppUrls.SETTINGS : ''}`}
			data-testid="settings-button"
			on:click={() => dispatch('sideMenuItemClicked')}
			class="flex items-center text-sm justify-start"
			><Settings2 class="h-5 w-5 mr-2" />Settings</Button
		>
	</li>
	<div class="grow"></div>
	<li>
		<LogoutButton variant="secondary" />
	</li>
</ul>
