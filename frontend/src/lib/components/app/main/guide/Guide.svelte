<script lang="ts">
	import * as Card from '$lib/components/ui/card';
	import { Timer, ShieldAlert } from 'lucide-svelte';
	import { onMount } from 'svelte';

	let userIsInLeagueGroup = true;

	onMount(async () => {
		const response = await fetch('/api/auth/info');
		const data = await response.json();
		if (!response.ok) {
			console.error(data);
		} else {
			userIsInLeagueGroup = data.group === 'league';
		}
	});
</script>

<div class="flex grow p-4 relative overflow-x-auto">
	<Card.Root class="flex grow relative overflow-x-auto"
		><div class="grow w-full">
			<Card.Header>
				<Card.Title>Guide</Card.Title>
				<Card.Description>Information on how to use the platform.</Card.Description>
			</Card.Header>
			<Card.Content>
				<!-- TODO -->
				<!-- To use icons, find icon: https://lucide.dev/icons/
                and then import with converted format e.g. shield-alert -> ShieldAlert -->
				{#if userIsInLeagueGroup}
					<!-- Include info on leagues & leaderboard... -->
					<div class="flex flex-col gap-4">
						<div class="flex items-center text-sm gap-4">
							<div class="shrink-0">
								<Timer class="h-7 w-7 -ml-0.5" />
							</div>
							<p>
								Challenges are time-based meaning the faster you complete a challenge, the more
								points you will get.
							</p>
						</div>
						<div class="flex items-center text-sm gap-4">
							<div class="shrink-0">
								<ShieldAlert class="h-7 w-7 -ml-0.5" />
							</div>
							<p>
								You only get one attempt at a challenge so verify your answers before submitting.
							</p>
						</div>
					</div>
				{:else}
					<!-- Include info on global leaderboard... -->
					<div class="flex flex-col gap-4">
						<div class="flex items-center text-sm gap-4">
							<div class="shrink-0">
								<Timer class="h-7 w-7 -ml-0.5" />
							</div>
							<p>
								Challenges are time-based meaning the faster you complete a challenge, the more
								points you will get.
							</p>
						</div>
						<div class="flex items-center text-sm gap-4">
							<div class="shrink-0">
								<ShieldAlert class="h-7 w-7 -ml-0.5" />
							</div>
							<p>
								You only get one attempt at a challenge so verify your answers before submitting.
							</p>
						</div>
					</div>
				{/if}
			</Card.Content>
		</div>
	</Card.Root>
</div>
