<script lang="ts">
	import { OFFSET } from './config';

	export let blocks: {
		x: number;
		y: number;
		content: string;
		group: number;
		groupIndex: number;
		id: number;
	}[];
	export let connection: { id: number; firstBlockId: number; secondBlockId: number };
	export let blocksDOM: HTMLElement[];
	export let connectionSelected: number | null;

	let x1: number, y1: number, x2: number, y2: number;

	$: {
		const firstBlock = blocks[connection.firstBlockId];
		const secondBlock = blocks[connection.secondBlockId];
		const firstBlockDOM = blocksDOM[connection.firstBlockId];
		const secondBlockDOM = blocksDOM[connection.secondBlockId];

		if (firstBlock && secondBlock) {
			x1 = firstBlock.x + firstBlockDOM.offsetWidth / 2 + OFFSET;
			y1 = firstBlock.y;
			x2 = secondBlock.x - secondBlockDOM.offsetWidth / 2 - OFFSET;
			y2 = secondBlock.y;
		}
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

<svelte:window
	on:resize={() => {
		const firstBlock = blocks[connection.firstBlockId];
		const secondBlock = blocks[connection.secondBlockId];
		const firstBlockDOM = blocksDOM[connection.firstBlockId];
		const secondBlockDOM = blocksDOM[connection.secondBlockId];

		if (firstBlock && secondBlock) {
			x1 = firstBlock.x + firstBlockDOM.offsetWidth / 2 + OFFSET;
			y1 = firstBlock.y;
			x2 = secondBlock.x - secondBlockDOM.offsetWidth / 2 - OFFSET;
			y2 = secondBlock.y;
		}
	}}
/>

<!-- svelte-ignore a11y-click-events-have-key-events -->
<!-- svelte-ignore a11y-no-static-element-interactions -->
<div
	class="absolute origin-left rounded-full hover:brightness-75 active:brightness-50 bg-connection brightness-150 cursor-pointer"
	style={`transform: translate(${translationVector.x}px, ${translationVector.y}px) translateX(50%) rotate(${angle}rad); width: ${length}px; height: ${14}px;`}
	on:click|stopPropagation={() => (connectionSelected = connection.id)}
	class:selected={connectionSelected === connection.id}
/>

<style>
	.bg-connection {
		background-color: oklch(var(--p));
		border-style: solid;
		border-width: 2px;
		border-color: oklch(var(--s));
	}

	.bg-connection:hover {
		border-style: solid;
		border-width: 2px;
		box-sizing: content-box;
		border-color: white;
		background-color: oklch(var(--a));
	}

	.selected {
		border-style: solid;
		border-width: 2px;
		box-sizing: content-box;
		border-color: white;
		background-color: oklch(var(--a));
		filter: brightness(1);
	}

	.selected:hover {
		filter: brightness(0.75);
	}

	.selected:active {
		filter: brightness(0.5);
	}
</style>
