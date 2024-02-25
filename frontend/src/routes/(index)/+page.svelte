<script lang="ts">
	import { buttonVariants } from '$lib/components/ui/button';
	import { onMount } from 'svelte';
	import { createNoise3D } from 'simplex-noise';
	// import { cn } from '$lib/utils/ui';
	// import * as Card from '$lib/components/ui/card';
	import { TypewriterEffectSmooth } from '$lib/components/ui/typewriter-effect';

	let speed: 'slow' | 'fast' = 'slow';
	let waveOpacity = 0.5;
	let waveWidth = 50;
	let blur = 10;
	let backgroundFill = 'black';

	let headerHeight = 64;
	let canvas: HTMLCanvasElement;

	onMount(() => {
		const header = document.getElementById('welcome-header');
		const height = header?.offsetHeight;
		if (height !== undefined) {
			headerHeight = height;
		}
	});

	const noise = createNoise3D();
	let w: number;
	let h: number;
	let nt: number;
	let i: number;
	let x: number;
	let ctx: any;

	const getSpeed = () => {
		switch (speed) {
			case 'slow':
				return 0.001;
			case 'fast':
				return 0.002;
			default:
				return 0.001;
		}
	};

	onMount(() => {
		ctx = canvas.getContext('2d');
		w = ctx.canvas.width = window.innerWidth;
		h = ctx.canvas.height = window.innerHeight;
		ctx.filter = `blur(${blur}px)`;
		nt = 0;

		render();

		return () => cancelAnimationFrame(animationId);
	});

	const waveColors = ['#38bdf8', '#818cf8', '#c084fc', '#e879f9', '#22d3ee'];
	const drawWave = (n: number) => {
		nt += getSpeed();
		for (i = 0; i < n; i++) {
			ctx.beginPath();
			ctx.lineWidth = waveWidth || 50;
			ctx.strokeStyle = waveColors[i % waveColors.length];
			for (x = 0; x < w; x += 5) {
				var y = noise(x / 800, 0.3 * i, nt) * 100;
				ctx.lineTo(x, y + h * 0.5); // adjust for height, currently at 50% of the container
			}
			ctx.stroke();
			ctx.closePath();
		}
	};

	let animationId: number;
	const render = () => {
		ctx.fillStyle = backgroundFill || 'black';
		ctx.globalAlpha = waveOpacity || 0.5;
		ctx.fillRect(0, 0, w, h);
		drawWave(5);
		animationId = requestAnimationFrame(render);
	};
</script>

<svelte:window
	on:resize={() => {
		w = ctx.canvas.width = window.innerWidth;
		h = ctx.canvas.height = window.innerHeight;
		ctx.filter = `blur(${blur}px)`;
	}}
/>

<header
	id="welcome-header"
	class="p-2 flex items-center justify-end sticky top-0 z-50 w-full border-b border-border/40 bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60"
>
	<a href="/login" class={buttonVariants()}>Open App</a>
</header>
<div class="relative flex overflow-y-auto" style={`height: calc(100% - ${headerHeight}px);`}>
	<div class="flex grow items-center flex-col">
		<canvas
			class="absolute w-full"
			style={`height: calc(100dvh - ${headerHeight}px);`}
			bind:this={canvas}
		></canvas>
		<div class="flex flex-col justify-center items-center grow relative">
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
			<TypewriterEffectSmooth words={[{ text: 'Welcome Page' }]} />
		</div>
	</div>
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
