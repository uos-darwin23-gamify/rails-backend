<script lang="ts">
	import { tick } from 'svelte';
	import { getScrollLeft, getScrollTop } from './ConnectBlocksChallenge.svelte';

	export let block: {
		x: number;
		y: number;
		content: string;
		group: number;
		groupIndex: number;
		id: number;
	};
	export let blocks: {
		x: number;
		y: number;
		content: string;
		group: number;
		groupIndex: number;
		id: number;
	}[];
	export let drawingConnection: boolean;
	export let drawingConnectionOrigin: { x: number; y: number };
	export let drawingConnectionBlockId: number;
	export let cursorPosition: { x: number; y: number };
	export let connections: { id: number; firstBlockId: number; secondBlockId: number }[];
	export let connectionIdGeneration: number;
	export let offset: { x: number; y: number };
	export let multiTouch: boolean;
	export let updateCursorPositionTouch: (e: TouchEvent) => void;

	const connectionAlreadyExists = (targetblockId: number, mobile: boolean) => {
		const foundConnection = connections.find(({ firstBlockId, secondBlockId }) => {
			if (mobile) {
				if (blocks[targetblockId].group === 1) {
					return drawingConnectionBlockId === secondBlockId && targetblockId === firstBlockId;
				} else if (blocks[targetblockId].group === 2) {
					return targetblockId === secondBlockId && drawingConnectionBlockId === firstBlockId;
				}
			} else {
				if (block.group === 1) {
					return drawingConnectionBlockId === secondBlockId && targetblockId === firstBlockId;
				} else if (block.group === 2) {
					return targetblockId === secondBlockId && drawingConnectionBlockId === firstBlockId;
				}
			}
		});

		return foundConnection !== undefined;
	};
</script>

<!-- svelte-ignore a11y-no-static-element-interactions -->
<div
	id={block.id.toString()}
	class="non-draggable border-color bg-base-100 absolute box-content h-5 w-5 rounded-full border-2 hover:brightness-75 active:brightness-100 touch-none"
	class:border-4={drawingConnection}
	style={`transform: translate(${offset.x}px, ${offset.y}px)`}
	on:mousedown={() => {
		drawingConnection = true;
		drawingConnectionOrigin.x = block.x + offset.x;
		drawingConnectionOrigin.y = block.y + offset.y;
		drawingConnectionBlockId = block.id;
	}}
	on:touchstart={async (e) => {
		updateCursorPositionTouch(e);
		await tick();

		if (multiTouch) {
			return;
		}

		drawingConnection = true;
		drawingConnectionOrigin.x = block.x + offset.x;
		drawingConnectionOrigin.y = block.y + offset.y;
		drawingConnectionBlockId = block.id;
	}}
	on:mouseup={() => {
		if (!drawingConnection) {
			return;
		}

		drawingConnection = false;

		if (
			drawingConnectionBlockId === block.id ||
			blocks[drawingConnectionBlockId].group === block.group
		) {
			return;
		}

		if (!connectionAlreadyExists(block.id, false)) {
			if (block.group === 1) {
				connections[connections.length] = {
					id: connectionIdGeneration,
					firstBlockId: block.id,
					secondBlockId: drawingConnectionBlockId
				};
			} else if (block.group === 2) {
				connections[connections.length] = {
					id: connectionIdGeneration,
					firstBlockId: drawingConnectionBlockId,
					secondBlockId: block.id
				};
			}

			connectionIdGeneration += 1;
		}
	}}
	on:touchend={(e) => {
		if (!drawingConnection) {
			return;
		}

		if (multiTouch && e.targetTouches.length !== 0) {
			return;
		}

		drawingConnection = false;

		const actualEventTarget = document
			?.elementsFromPoint(
				cursorPosition.x - getScrollLeft(document.getElementById('challenge-container')),
				cursorPosition.y - getScrollTop(document.getElementById('challenge-container'))
			)
			.find((element) => element.id.length > 0);

		let targetblockId = -1;
		if (actualEventTarget !== undefined) {
			const parsingResult = parseInt(actualEventTarget.id);
			if (!isNaN(parsingResult)) {
				targetblockId = parsingResult;
			} else {
				return;
			}
		} else {
			return;
		}

		if (targetblockId === block.id || blocks[targetblockId].group === block.group) {
			return;
		}

		if (!connectionAlreadyExists(targetblockId, true)) {
			if (blocks[targetblockId].group === 1) {
				connections[connections.length] = {
					id: connectionIdGeneration,
					firstBlockId: blocks[targetblockId].id,
					secondBlockId: drawingConnectionBlockId
				};
			} else if (blocks[targetblockId].group === 2) {
				connections[connections.length] = {
					id: connectionIdGeneration,
					firstBlockId: drawingConnectionBlockId,
					secondBlockId: blocks[targetblockId].id
				};
			}

			connectionIdGeneration += 1;
		}
	}}
/>

<style>
	.border-color {
		border-color: oklch(var(--a));
	}

	.border-color:hover:not(:active) {
		border-color: oklch(var(--a));
	}

	.border-color:active {
		border-color: hsl(var(--wa));
	}
</style>
