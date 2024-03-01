<script lang="ts">
	import { onMount } from 'svelte';
	import Canvas from '$lib/components/welcome-page/Canvas.svelte';
	import Slide2 from '$lib/components/welcome-page/Slide2.svelte';
	import Slide3 from '$lib/components/welcome-page/Slide3.svelte';

	let headerHeight = 64;

	onMount(() => {
		const header = document.getElementById('welcome-header');
		const height = header?.offsetHeight;
		if (height !== undefined) {
			headerHeight = height;
		}
	});
</script>

<div
	class="grow relative overflow-y-auto snap-y snap-mandatory"
	style={`height: calc(100% - ${headerHeight}px);`}
>
	<Canvas />
	<Slide2 />
	<Slide3 />
</div>

<!-- <Card.Root>
				<Card.Content class="overflow-hidden relative max-w-xs pt-6">
					{#each Array(20) as _, index (index)}
						<span
							class={cn(
								'meteor-effect absolute top-1/2 left-1/2 h-0.5 w-0.5 rounded-[9999px] bg-slate-500 shadow-[0_0_0_1px_#ffffff10] rotate-[215deg]',
								"before:content-[''] before:absolute before:top-1/2 before:transform before:-translate-y-[50%] before:w-[50px] before:h-[1px] before:bg-gradient-to-r before:from-[#64748b] before:to-transparent"
							)}
							style={`
							top: 0;
							left: ${Math.floor(Math.random() * (400 - -400) + -400)}px;
							animation-delay: ${Math.random() * (0.8 - 0.2) + 0.2}s;
							animation-duration: ${Math.floor(Math.random() * (10 - 2) + 2)}s;
						`}
						></span>
					{/each}
					<p>
						Lorem ipsum dolor sit amet consectetur adipisicing elit. Inventore ratione et aliquam
						est. Optio sed possimus totam quibusdam architecto tenetur, eos alias ex maxime deserunt
						voluptatibus, at ab accusamus necessitatibus.
					</p>
				</Card.Content>
			</Card.Root> -->

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
