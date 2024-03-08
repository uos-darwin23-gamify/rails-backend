<script lang="ts">
	import * as Card from '$lib/components/ui/card';
	import {
		Timer,
		ShieldAlert,
		Home,
		Swords,
		Settings2,
		Shield,
		BookText,
		CheckCircle,
		HelpCircle,
		BellPlus
	} from 'lucide-svelte';
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
								<Swords class="h-7 w-7 -ml-0.5" />
							</div>
							<p>Compete in Challenges to earn points and climb the Leaderboard.</p>
						</div>
						<div class="flex items-center text-sm gap-4">
							<div class="shrink-0">
								<BellPlus class="h-7 w-7 -ml-0.5" />
							</div>
							<p>
								New Challenges are released regularly so keep an eye out for email notifications.
							</p>
						</div>
						<div class="flex items-center text-sm gap-4">
							<div class="shrink-0">
								<Shield class="h-7 w-7 -ml-0.5" />
							</div>
							<p>Keep track of your progress on the Leaderboard.</p>
						</div>
						<div class="flex items-center text-sm gap-4">
							<div class="shrink-0">
								<CheckCircle class="h-7 w-7 -ml-0.5" />
							</div>
							<p>The harder the question, the more points you can score!</p>
						</div>
						<div class="flex items-center text-sm gap-4">
							<div class="shrink-0">
								<ShieldAlert class="h-7 w-7 -ml-0.5" />
							</div>
							<p>
								You only get one attempt at a Challenge so verify your answers before submitting.
							</p>
						</div>
						<!-- <div class="flex items-center text-sm gap-4">
							<div class="shrink-0">
								<Timer class="h-7 w-7 -ml-0.5" />
							</div>
							<p>
								Challenges are time-based meaning the faster you complete a Challenge, the more
								points you will get.
							</p>
						</div> -->
						<div class="flex items-center text-sm gap-4">
							<div class="shrink-0">
								<HelpCircle class="h-7 w-7 -ml-0.5" />
							</div>
							<p>
								You can view and download the Consent Form and Participant Information Sheet at any
								time from the Help section.
							</p>
						</div>
					</div>
				{:else}
					<!-- Include info on global leaderboard... -->
					<div class="flex flex-col gap-4">
						<div class="flex items-center text-sm gap-4">
							<div class="shrink-0">
								<Swords class="h-7 w-7 -ml-0.5" />
							</div>
							<p>Compete in Challenges to earn points and climb the Leaderboard.</p>
						</div>
						<div class="flex items-center text-sm gap-4">
							<div class="shrink-0">
								<BellPlus class="h-7 w-7 -ml-0.5" />
							</div>
							<p>
								New Challenges are released regularly so keep an eye out for email notifications.
							</p>
						</div>
						<div class="flex items-center text-sm gap-4">
							<div class="shrink-0">
								<Shield class="h-7 w-7 -ml-0.5" />
							</div>
							<p>Keep track of your progress on the Leaderboard.</p>
						</div>
						<div class="flex items-center text-sm gap-4">
							<div class="shrink-0">
								<CheckCircle class="h-7 w-7 -ml-0.5" />
							</div>
							<p>The harder the question, the more points you can score!</p>
						</div>
						<div class="flex items-center text-sm gap-4">
							<div class="shrink-0">
								<ShieldAlert class="h-7 w-7 -ml-0.5" />
							</div>
							<p>
								You only get one attempt at a Challenge so verify your answers before submitting.
							</p>
						</div>
						<!-- <div class="flex items-center text-sm gap-4">
							<div class="shrink-0">
								<Timer class="h-7 w-7 -ml-0.5" />
							</div>
							<p>
								Challenges are time-based meaning the faster you complete a Challenge, the more
								points you will get.
							</p>
						</div> -->
						<div class="flex items-center text-sm gap-4">
							<div class="shrink-0">
								<HelpCircle class="h-7 w-7 -ml-0.5" />
							</div>
							<p>
								You can view and download the Consent Form and Participant Information Sheet at any
								time from the Help section.
							</p>
						</div>
					</div>
				{/if}
			</Card.Content>
		</div>
	</Card.Root>
</div>
