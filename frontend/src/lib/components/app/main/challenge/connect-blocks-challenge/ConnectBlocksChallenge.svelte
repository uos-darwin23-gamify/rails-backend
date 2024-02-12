<script lang="ts" context="module">
	export const getOffsetTop = (element: HTMLElement) => {
		let offsetTop = 0;
		while (element) {
			offsetTop += element.offsetTop;
			element = element.offsetParent as HTMLElement;
		}
		return offsetTop;
	};

	export const getOffsetLeft = (element: HTMLElement) => {
		let offsetTop = 0;
		while (element) {
			offsetTop += element.offsetLeft;
			element = element.offsetParent as HTMLElement;
		}
		return offsetTop;
	};
</script>

<script lang="ts">
	import type { ConnectBlocksChallengeSolutionType } from '$lib/types/challenge-solution';
	import type { ConnectBlocksChallengeDataType } from '$lib/types/challenge-data';
	import * as Card from '$lib/components/ui/card';
	import ConnectionPoint from './ConnectionPoint.svelte';
	import PartialConnection from './PartialConnection.svelte';
	import Connection from './Connection.svelte';
	import { onMount } from 'svelte';
	import { OFFSET } from './config';

	export let data: ConnectBlocksChallengeDataType;
	export let solutionState: ConnectBlocksChallengeSolutionType;

	const groupToBlockIntermediate = (group: string[], groupId: number) =>
		group.map((block, index) => ({ content: block, group: groupId, groupIndex: index }));

	const blocks = [
		...groupToBlockIntermediate(data.first_group, 1),
		...groupToBlockIntermediate(data.second_group, 2)
	].map((block, index) => ({
		id: index,
		...block,
		x: 0,
		y: 0
	}));
	let canvas: HTMLDivElement;
	let drawingConnection = false;
	let drawingConnectionOrigin = { x: 0, y: 0 };
	let drawingConnectionBlockId = -1;
	let connections: { id: number; firstBlockId: number; secondBlockId: number }[] = [];
	let multiTouch = false;
	let numberOfTouchPoints = 0;
	let connectionIdGeneration = 0;
	let offsets: { x: number; y: number }[] = new Array(blocks.length).fill({ x: 0, y: 0 });
	let cursorPosition = { x: 0, y: 0 };
	let blocksDOM: HTMLElement[] = new Array(blocks.length).fill(null);
	let connectionSelected: number | null = null;

	$: {
		const partial: ConnectBlocksChallengeSolutionType = [];

		connections.forEach(({ firstBlockId, secondBlockId }) => {
			const firstBlock = blocks[firstBlockId];
			const secondBlock = blocks[secondBlockId];

			partial.push([firstBlock.groupIndex, secondBlock.groupIndex]);
		});

		const uniquePartial = Array.from(
			new Set(partial.map((value) => JSON.stringify(value))),
			(json) => JSON.parse(json)
		);

		solutionState = uniquePartial;
	}

	const updateCursorPositionMouse = (e: MouseEvent) => {
		// cursorPosition.x = e.x;
		// cursorPosition.y = e.y;
		cursorPosition.x = e.x + (document.getElementById('challenge-container')?.scrollLeft ?? 0);
		cursorPosition.y = e.y + (document.getElementById('challenge-container')?.scrollTop ?? 0);

		if (multiTouch) {
			multiTouch = false;
		}

		if (numberOfTouchPoints > 0) {
			numberOfTouchPoints = 0;
		}
	};
	const updateCursorPositionTouch = (e: TouchEvent) => {
		if (e.touches.length > 0) {
			cursorPosition.x =
				e.touches[0].clientX + (document.getElementById('challenge-container')?.scrollLeft ?? 0);
			cursorPosition.y =
				e.touches[0].clientY + (document.getElementById('challenge-container')?.scrollTop ?? 0);

			handleMultiTouch(e);
		} else {
			numberOfTouchPoints = 0;
		}
	};
	const handleMultiTouch = (e: TouchEvent) => {
		if (e.touches.length > 1) {
			if (!multiTouch) {
				multiTouch = true;
			}
		} else if (multiTouch) {
			multiTouch = false;
		}
	};

	onMount(async () => {
		const canvasTop = getOffsetTop(canvas);
		const canvasLeft = getOffsetLeft(canvas);
		const canvasHeight = canvas.offsetHeight;
		const canvasWidth = canvas.offsetWidth;

		blocksDOM.forEach((blockDOM, index) => {
			const blockTop = getOffsetTop(blockDOM);
			const blockLeft = getOffsetLeft(blockDOM);
			const blockHeight = blockDOM.offsetHeight;
			const blockWidth = blockDOM.offsetWidth;
			blocks[index].x = blockLeft + blockWidth / 2 - canvasLeft - canvasWidth / 2;
			blocks[index].y = blockTop + blockHeight / 2 - canvasTop - canvasHeight / 2;

			offsets[blocks[index].id] = {
				x:
					blocks[index].group === 1
						? blockDOM?.offsetWidth / 2 + OFFSET
						: -blockDOM?.offsetWidth / 2 - OFFSET,
				y: 0
			};
		});
	});
</script>

<svelte:window
	on:resize={() => {
		const canvasTop = getOffsetTop(canvas);
		const canvasLeft = getOffsetLeft(canvas);
		const canvasHeight = canvas.offsetHeight;
		const canvasWidth = canvas.offsetWidth;

		blocksDOM.forEach((blockDOM, index) => {
			const blockTop = getOffsetTop(blockDOM);
			const blockLeft = getOffsetLeft(blockDOM);
			const blockHeight = blockDOM.offsetHeight;
			const blockWidth = blockDOM.offsetWidth;
			blocks[index].x = blockLeft + blockWidth / 2 - canvasLeft - canvasWidth / 2;
			blocks[index].y = blockTop + blockHeight / 2 - canvasTop - canvasHeight / 2;
			offsets[index] = {
				x:
					blocks[index].group === 1
						? blockDOM?.offsetWidth / 2 + OFFSET
						: -blockDOM?.offsetWidth / 2 - OFFSET,
				y: 0
			};
			if (drawingConnectionBlockId === blocks[index].id && drawingConnection) {
				drawingConnectionOrigin.x =
					blocks[index].x + offsets[index].x * (blocks[index].group === 2 ? -1 : 1);
				drawingConnectionOrigin.y = blocks[index].y + offsets[index].y;
			}
		});
	}}
/>

<!-- svelte-ignore a11y-no-static-element-interactions -->
<Card.Root class="flex grow select-none">
	<Card.Content class="p-6 flex grow relative overflow-hidden">
		<!-- svelte-ignore a11y-click-events-have-key-events -->
		<div
			bind:this={canvas}
			class="flex items-center justify-center grow"
			on:mousemove={updateCursorPositionMouse}
			on:touchmove|preventDefault={updateCursorPositionTouch}
			on:mousedown={updateCursorPositionMouse}
			on:touchstart={updateCursorPositionTouch}
			on:touchend={updateCursorPositionTouch}
			on:mouseup={() => (drawingConnection = false)}
			on:touchend={() => {
				if (!multiTouch) {
					drawingConnection = false;
				}
			}}
			on:click={() => (connectionSelected = null)}
		>
			<div class="flex gap-32 justify-between grow items-center relative">
				<div class="flex flex-col basis-1/2 gap-2">
					{#each blocks.filter(({ group }) => group === 1) as block, index (index)}
						<div bind:this={blocksDOM[block.id]}>
							<Card.Root>
								<Card.Content
									class="flex justify-center items-center gap-4 grow py-3 px-3 h-full w-full z-10 relative bg-card"
								>
									<div class="flex grow justify-start">
										<p>{block.content}</p>
									</div>
									<ConnectionPoint
										{block}
										{blocks}
										{cursorPosition}
										bind:drawingConnection
										bind:drawingConnectionOrigin
										bind:drawingConnectionBlockId
										bind:connectionIdGeneration
										bind:connections
										offset={offsets[block.id]}
										{multiTouch}
									/>
								</Card.Content>
							</Card.Root>
						</div>
					{/each}
				</div>
				<div class="flex flex-col basis-1/2 gap-2">
					{#each blocks.filter(({ group }) => group === 2) as block, index (index)}
						<div bind:this={blocksDOM[block.id]}>
							<Card.Root>
								<Card.Content
									class="flex justify-center items-center gap-4 grow py-3 px-3 h-full w-full z-10 relative bg-card"
								>
									<div class="flex grow justify-start">
										<p>{block.content}</p>
									</div>
									<ConnectionPoint
										{block}
										{blocks}
										{cursorPosition}
										bind:drawingConnection
										bind:drawingConnectionOrigin
										bind:drawingConnectionBlockId
										bind:connectionIdGeneration
										bind:connections
										offset={offsets[block.id]}
										{multiTouch}
									/>
								</Card.Content>
							</Card.Root>
						</div>
					{/each}
				</div>
			</div>
			{#each connections as connection (connection.id)}
				<Connection {connection} {blocks} {blocksDOM} bind:connectionSelected />
			{/each}
			{#if drawingConnection}
				<PartialConnection {canvas} {cursorPosition} {drawingConnectionOrigin} />
			{/if}
		</div>
	</Card.Content>
</Card.Root>
