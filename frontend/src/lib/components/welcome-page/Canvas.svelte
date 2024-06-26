<script lang="ts">
	import { onMount } from 'svelte';
	import { createNoise3D } from 'simplex-noise';
	import TypewriterEffectSmooth from '$lib/components/welcome-page/TypewriterEffectSmooth.svelte';
	import Cards from '$lib/components/welcome-page/Cards.svelte';

	const SPEED = 0.001;
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
		nt += SPEED;
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

	let container: HTMLDivElement;
	$: containerHeight = container?.scrollHeight ?? 0;
</script>

<svelte:window
	on:resize={() => {
		containerHeight = container?.scrollHeight ?? 0;
		w = ctx.canvas.width = window.innerWidth;
		h = ctx.canvas.height = window.innerHeight;
		ctx.filter = `blur(${blur}px)`;
	}}
/>

<div class="relative h-full w-full flex">
	<div class="flex grow items-center flex-col" bind:this={container}>
		<canvas
			class="absolute w-full"
			style={`height: max(${containerHeight}px, calc(100dvh - ${headerHeight}px));`}
			bind:this={canvas}
		></canvas>
		<div class="flex flex-col justify-center items-center grow relative">
			<TypewriterEffectSmooth
				word={{ text: 'Redefining C Teaching', className: 'text-xl sm:text-4xl' }}
				className="mx-2"
			/>
		</div>
		<Cards />
	</div>
</div>
