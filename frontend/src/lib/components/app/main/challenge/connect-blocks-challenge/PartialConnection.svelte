<script lang="ts">
	import { getOffsetTop, getOffsetLeft } from './ConnectBlocksChallenge.svelte';
	export let drawingConnectionOrigin: { x: number; y: number };
	export let cursorPosition: { x: number; y: number };
	export let canvas: HTMLDivElement;

	const canvasTop = getOffsetTop(canvas);
	const canvasLeft = getOffsetLeft(canvas);
	const canvasHeight = canvas.offsetHeight;
	const canvasWidth = canvas.offsetWidth;

	let x1: number, y1: number, x2: number, y2: number;

	$: {
		x1 = drawingConnectionOrigin.x;
		y1 = drawingConnectionOrigin.y;
		x2 = cursorPosition.x - canvasLeft - canvasWidth / 2;
		y2 = cursorPosition.y - canvasTop - canvasHeight / 2;
	}

	let angle: number;
	let length: number;

	$: angle = Math.atan2(y2 - y1, x2 - x1);
	$: length = Math.sqrt((y2 - y1) ** 2 + (x2 - x1) ** 2);

	let translationVector: { x: number; y: number };
	$: translationVector = {
		x: x1,
		y: y1
	};
</script>

<div
	class="absolute origin-left rounded-full bg-partial-connection"
	style={`transform: translate(${translationVector.x}px, ${translationVector.y}px) translateX(50%) rotate(${angle}rad); width: ${length}px; height: ${16}px;`}
/>

<style>
	.bg-partial-connection {
		background-color: oklch(var(--wa));
	}
</style>
