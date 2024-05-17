<script lang="ts" context="module">
	export const getOffsetTop = (element: HTMLElement | null) => {
		let offsetTop = 0;
		while (element) {
			offsetTop += element.offsetTop;
			element = element.offsetParent as HTMLElement;
		}
		return offsetTop;
	};

	export const getOffsetLeft = (element: HTMLElement | null) => {
		let offsetTop = 0;
		while (element) {
			offsetTop += element.offsetLeft;
			element = element.offsetParent as HTMLElement;
		}
		return offsetTop;
	};

	export const getScrollLeft = (element: HTMLElement | null) => {
		let scrollLeft = 0;
		while (element) {
			scrollLeft += element.scrollLeft;
			element = element.parentElement;
		}
		return scrollLeft;
	};

	export const getScrollTop = (element: HTMLElement | null) => {
		let scrollTop = 0;
		while (element) {
			scrollTop += element.scrollTop;
			element = element.parentElement;
		}
		return scrollTop;
	};
</script>

<script lang="ts">
	import * as Card from '$lib/components/ui/card';
	import ConnectionPoint from './ConnectionPoint.svelte';
	import PartialConnection from './PartialConnection.svelte';
	import Connection from './Connection.svelte';
	import { onMount } from 'svelte';
	import { OFFSET } from './config';
	import { Button } from '$lib/components/ui/button';
	import * as Popover from '$lib/components/ui/popover';
	import { Info, PlusCircle, Trash2 } from 'lucide-svelte';
	import { Input } from '$lib/components/ui/input';

	export let first_group: string[];
	export let second_group: string[];
	export let correct_answers: [number, number][];
	export let forceRerenderConnectBlocks: () => Promise<void>;

	const groupToBlockIntermediate = (group: string[], groupId: number) =>
		group.map((block, index) => ({ content: block, group: groupId, groupIndex: index }));

	let blocks = [
		...groupToBlockIntermediate(first_group, 1),
		...groupToBlockIntermediate(second_group, 2)
	].map((block, index) => ({
		id: index,
		...block,
		x: 0,
		y: 0
	}));

	$: {
		blocks.forEach(({ content, group, groupIndex }) => {
			if (group === 1) {
				first_group[groupIndex] = content;
			} else if (group === 2) {
				second_group[groupIndex] = content;
			}
		});
	}

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

	let lock = true;

	$: {
		if (!lock) {
			const partial: [number, number][] = [];

			connections.forEach(({ firstBlockId, secondBlockId }) => {
				const firstBlock = blocks[firstBlockId];
				const secondBlock = blocks[secondBlockId];

				partial.push([firstBlock.groupIndex, secondBlock.groupIndex]);
			});

			const uniquePartial: [number, number][] = Array.from(
				new Set(partial.map((value) => JSON.stringify(value))),
				(json) => JSON.parse(json)
			);

			correct_answers = uniquePartial;
		} else {
			drawingConnection = false;
		}
	}

	const updateCursorPositionMouse = (e: MouseEvent) => {
		// cursorPosition.x = e.x;
		// cursorPosition.y = e.y;
		cursorPosition.x = e.x + getScrollLeft(document.getElementById('challenge-container'));
		cursorPosition.y = e.y + getScrollTop(document.getElementById('challenge-container'));

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
				e.touches[0].clientX + getScrollLeft(document.getElementById('challenge-container'));
			cursorPosition.y =
				e.touches[0].clientY + getScrollTop(document.getElementById('challenge-container'));

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

	onMount(() => {
		updateLayout();

		correct_answers.forEach(([first, second]) => {
			const firstBlock = blocks.find(
				({ group, groupIndex }) => group === 1 && groupIndex === first
			)!;
			const secondBlock = blocks.find(
				({ group, groupIndex }) => group === 2 && groupIndex === second
			)!;
			connections[connections.length] = {
				id: connectionIdGeneration,
				firstBlockId: firstBlock.id,
				secondBlockId: secondBlock.id
			};
			connectionIdGeneration++;
		});

		canvasObserver.observe(canvas);
		lock = false;

		return () => canvasObserver.unobserve(canvas);
	});

	const updateLayout = () => {
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
	};

	const canvasObserver = new ResizeObserver(updateLayout);
</script>

<svelte:window
	on:mousemove={updateCursorPositionMouse}
	on:touchmove|preventDefault={updateCursorPositionTouch}
	on:mousedown={updateCursorPositionMouse}
	on:touchstart={updateCursorPositionTouch}
	on:touchend={(e) => {
		if (!multiTouch) {
			drawingConnection = false;
		}
		updateCursorPositionTouch(e);
	}}
	on:mouseup={() => (drawingConnection = false)}
	on:resize={updateLayout}
/>

<!-- svelte-ignore a11y-no-static-element-interactions -->
<!-- svelte-ignore a11y-click-events-have-key-events -->
<div class="flex grow" on:click={() => (connectionSelected = null)}>
	<Card.Root class="flex grow select-none flex-col">
		{#if !lock}
			<div class="flex justify-between gap-2 p-2 pb-0">
				<div class="flex flex-col">
					<p class="text-sm text-muted-foreground">
						Fill out the answers and create the correct connections.
					</p>
					<p class="text-sm text-muted-foreground">
						Order will be individually randomized for every user.
					</p>
				</div>
				<div class="flex gap-2">
					{#if connectionSelected === null}
						<Popover.Root preventScroll>
							<Popover.Trigger asChild let:builder>
								<Button builders={[builder]} variant="secondary">Delete Connection</Button>
							</Popover.Trigger>
							<Popover.Content class="w-80">
								<div class="flex justify-between space-x-4">
									<div class="shrink-0">
										<Info className="h-4 w-4" />
									</div>
									<div class="space-y-1">
										<h4 class="text-sm font-semibold">Note</h4>
										<p class="text-sm">Select a drawn connection by clicking on it.</p>
									</div>
								</div>
							</Popover.Content>
						</Popover.Root>
					{:else}
						<Button
							variant="destructive"
							on:click={() => {
								connections = connections.filter(({ id }) => id !== connectionSelected);
							}}>Delete Connection</Button
						>
					{/if}
					{#if connections.length === 0}
						<Popover.Root preventScroll>
							<Popover.Trigger asChild let:builder>
								<Button builders={[builder]} variant="secondary">Reset</Button>
							</Popover.Trigger>
							<Popover.Content class="w-80">
								<div class="flex justify-between space-x-4">
									<div class="shrink-0">
										<Info className="h-4 w-4" />
									</div>
									<div class="space-y-1">
										<h4 class="text-sm font-semibold">Note</h4>
										<p class="text-sm">You need to draw at least one connection.</p>
									</div>
								</div>
							</Popover.Content>
						</Popover.Root>{:else}
						<Button
							variant="destructive"
							on:click={() => {
								connections = [];
								connectionSelected = null;
							}}>Reset</Button
						>
					{/if}
				</div>
			</div>
		{/if}
		<Card.Content class="p-6 flex grow relative overflow-hidden">
			<!-- svelte-ignore a11y-click-events-have-key-events -->
			<div bind:this={canvas} class="flex items-center justify-center grow">
				<div class="flex gap-32 justify-between grow items-center relative">
					<div class="flex flex-col basis-1/2 gap-2">
						{#each blocks.filter(({ group }) => group === 1) as block, index (index)}
							<div bind:this={blocksDOM[block.id]}>
								<Card.Root>
									<Card.Content
										class="flex justify-center items-center gap-4 grow py-3 px-3 h-full w-full z-10 relative bg-card"
									>
										{#if first_group.length > 1}
											<Button
												size="icon"
												variant="outline"
												on:click={() => {
													first_group = first_group.filter(
														(_, index) => index !== block.groupIndex
													);
													correct_answers = correct_answers.filter(
														([first]) => first !== block.groupIndex
													);
													correct_answers = correct_answers.map(([first, second]) =>
														first > block.groupIndex ? [first - 1, second] : [first, second]
													);
													forceRerenderConnectBlocks();
												}}><Trash2 class="h-5 w-5" /></Button
											>
										{/if}
										<Input class="flex grow justify-start" bind:value={block.content} />
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
											{updateCursorPositionTouch}
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
										<Input class="flex grow justify-start" bind:value={block.content} />
										{#if second_group.length > 1}
											<Button
												size="icon"
												variant="outline"
												on:click={() => {
													second_group = second_group.filter(
														(_, index) => index !== block.groupIndex
													);
													correct_answers = correct_answers.filter(
														([_, second]) => second !== block.groupIndex
													);
													correct_answers = correct_answers.map(([first, second]) =>
														second > block.groupIndex ? [first, second - 1] : [first, second]
													);
													forceRerenderConnectBlocks();
												}}><Trash2 class="h-5 w-5" /></Button
											>
										{/if}
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
											{updateCursorPositionTouch}
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
		<div class="flex justify-between p-2 pt-0 gap-2">
			<Button
				on:click={() => {
					first_group = [...first_group, ''];
					forceRerenderConnectBlocks();
				}}><PlusCircle class="h-5 w-5 mr-2" />Add Left</Button
			>
			<Button
				on:click={() => {
					second_group = [...second_group, ''];
					forceRerenderConnectBlocks();
				}}><PlusCircle class="h-5 w-5 mr-2" />Add Right</Button
			>
		</div>
	</Card.Root>
</div>
