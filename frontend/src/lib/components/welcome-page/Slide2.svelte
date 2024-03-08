<script lang="ts">
	import { onMount } from 'svelte';
	import { cn } from '$lib/utils/ui';
	import { Card, CardContent, CardTitle } from '$lib/components/ui/card';

	let headerHeight = 64;

	onMount(() => {
		const header = document.getElementById('welcome-header');
		const height = header?.offsetHeight;
		if (height !== undefined) {
			headerHeight = height;
		}
	});
</script>

<div class="md:mb-40 grid grid-cols-1 sm:grid-cols-3 gap-4">
	<Card class="m-4 my-2 flex flex-col justify-center items-center grow relative max-sm:mt-0">
		<div class="absolute h-full w-full overflow-hidden">
			{#each Array(40) as _, index (index)}
				<span
					class={cn(
						'meteor-effect absolute top-1/2 left-1/2 h-0.5 w-0.5 rounded-[9999px] bg-slate-500 shadow-[0_0_0_1px_#ffffff10] rotate-[215deg]',
						"before:content-[''] before:absolute before:top-1/2 before:transform before:-translate-y-[50%] before:w-[50px] before:h-[1px] before:bg-gradient-to-r before:from-[#64748b] before:to-transparent"
					)}
					style={`
			top: 0;
			left: ${Math.floor(Math.random() * 800 + -400)}px;
			animation-delay: ${Math.random() * (0.8 - 0.2) + 0.2}s;
			animation-duration: ${Math.floor(Math.random() * (10 - 2) + 2)}s;
		`}
				></span>
			{/each}
		</div>
		<CardTitle class="overflow-hidden relative max-w-xs pt-6 text-center mx-3"
			>Interactive Challenges</CardTitle
		>
		<CardContent class="overflow-hidden relative max-w-xs pt-6">
			<p>
				Our interactive challenges are designed to make learning fun and engaging, helping to
				sharpen your coding abilities.
			</p>
		</CardContent>
	</Card>

	<Card class="m-4 my-2 flex flex-col justify-center items-center grow relative">
		<div class="absolute h-full w-full overflow-hidden">
			{#each Array(40) as _, index (index)}
				<span
					class={cn(
						'meteor-effect absolute top-1/2 left-1/2 h-0.5 w-0.5 rounded-[9999px] bg-slate-500 shadow-[0_0_0_1px_#ffffff10] rotate-[215deg]',
						"before:content-[''] before:absolute before:top-1/2 before:transform before:-translate-y-[50%] before:w-[50px] before:h-[1px] before:bg-gradient-to-r before:from-[#64748b] before:to-transparent"
					)}
					style={`
			top: 0;
			left: ${Math.floor(Math.random() * 800 + -400)}px;
			animation-delay: ${Math.random() * (0.8 - 0.2) + 0.2}s;
			animation-duration: ${Math.floor(Math.random() * (10 - 2) + 2)}s;
		`}
				></span>
			{/each}
		</div>
		<CardTitle class="overflow-hidden relative max-w-xs pt-6 text-center mx-3"
			>Daily Releases</CardTitle
		>
		<CardContent class="overflow-hidden relative max-w-xs pt-6">
			<p>
				A new selection of curated challenges is released daily, ranging from simple all the way to
				extreme difficulty.
			</p>
		</CardContent>
	</Card>

	<Card class="m-4 my-2 flex flex-col justify-center items-center grow relative">
		<div class="absolute h-full w-full overflow-hidden">
			{#each Array(40) as _, index (index)}
				<span
					class={cn(
						'meteor-effect absolute top-1/2 left-1/2 h-0.5 w-0.5 rounded-[9999px] bg-slate-500 shadow-[0_0_0_1px_#ffffff10] rotate-[215deg]',
						"before:content-[''] before:absolute before:top-1/2 before:transform before:-translate-y-[50%] before:w-[50px] before:h-[1px] before:bg-gradient-to-r before:from-[#64748b] before:to-transparent"
					)}
					style={`
			top: 0;
			left: ${Math.floor(Math.random() * 800 + -400)}px;
			animation-delay: ${Math.random() * (0.8 - 0.2) + 0.2}s;
			animation-duration: ${Math.floor(Math.random() * (10 - 2) + 2)}s;
		`}
				></span>
			{/each}
		</div>
		<CardTitle class="overflow-hidden relative max-w-xs pt-6 text-center mx-3"
			>Competitive Leaderboards</CardTitle
		>
		<CardContent class="overflow-hidden relative max-w-xs pt-6">
			<p>
				Showcase your skills while working your way up to the top among your peers and conquer new
				coding heights.
			</p>
		</CardContent>
	</Card>
</div>

<div class="p-4 flex flex-col justify-center items-center relative">
	<p class="text-center">
		For any support questions contact: <a href="mailto:support@gamifycoding.me"
			>support@gamifycoding.me</a
		>
	</p>
</div>

<style>
	.meteor-effect {
		animation: meteor 5s linear infinite;
	}

	@keyframes meteor {
		0% {
			transform: rotate(215deg) translateX(0);
			opacity: 1;
		}
		70% {
			opacity: 1;
		}
		100% {
			transform: rotate(215deg) translateX(-500px);
			opacity: 0;
		}
	}
</style>
