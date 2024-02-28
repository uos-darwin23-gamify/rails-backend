<script lang="ts">
	import { Trophy, ShieldHalf } from 'lucide-svelte';
	import { onMount } from 'svelte';
	import { cubicOut } from 'svelte/easing';
	export let neighbouringLeagues: string[];
	export let highestEloInPreviousLeague: number | null;
	export let lowestEloInNextLeague: number | null;
	export let userElo: number;

	let container: HTMLDivElement;
	let lowerLeague: HTMLDivElement;
	let upperLeague: HTMLDivElement;
	const progressBarValue =
		lowestEloInNextLeague === null || highestEloInPreviousLeague === null
			? 50
			: lowestEloInNextLeague - highestEloInPreviousLeague === 0
				? 50
				: Math.round(
						((userElo - highestEloInPreviousLeague) * 100) /
							(lowestEloInNextLeague - highestEloInPreviousLeague)
					);

	let animateProgressBarValue = 0;

	let interval: ReturnType<typeof setTimeout>;

	const zeroIfNaN = (value: number) => (isNaN(value) ? 0 : value);

	$: marginTop = Math.max(lowerLeague?.offsetHeight ?? 0, upperLeague?.offsetHeight ?? 0);
	$: marginHorizontalMax = Math.max(
		zeroIfNaN(container?.getBoundingClientRect().left - lowerLeague?.getBoundingClientRect().left),
		zeroIfNaN(upperLeague?.getBoundingClientRect().right - container?.getBoundingClientRect().right)
	);
	$: marginLeft = marginHorizontalMax;
	$: marginRight = marginHorizontalMax;

	let startTime: number;
	let duration = 2000;

	onMount(() => {
		startTime = Date.now();
		interval = setInterval(() => {
			const now = Date.now();
			const elapsed = now - startTime;
			if (elapsed < duration) {
				const t = elapsed / duration;
				animateProgressBarValue = progressBarValue * cubicOut(t);
			} else {
				animateProgressBarValue = progressBarValue;
				clearInterval(interval);
			}
		}, 2);

		return () => clearInterval(interval);
	});
</script>

<div
	class="flex relative items-center justify-center"
	style={`margin-top: ${marginTop}px; margin-left: ${marginLeft}px; margin-right: ${marginRight}px;`}
	bind:this={container}
>
	<progress class="progress progress-error" value={animateProgressBarValue} max="100"></progress>
	<div
		class="h-8 w-8 rounded-full absolute left-0 progress-background flex justify-center items-center"
	>
		<div class="shrink-0">
			<Trophy class="h-4 w-4" />
		</div>
		<div
			class="absolute top-0 -translate-y-full flex flex-col items-center"
			bind:this={lowerLeague}
		>
			<div class="shrink-0">
				<ShieldHalf class="h-8 w-8 -ml-0.5" />
			</div>
			{neighbouringLeagues[0]}
		</div>
	</div>
	<div
		class="h-8 w-8 rounded-full absolute right-0 progress-background flex justify-center items-center"
	>
		<div class="shrink-0">
			<Trophy class="h-4 w-4" />
		</div>
		<div
			class="absolute top-0 -translate-y-full flex flex-col items-center"
			bind:this={upperLeague}
		>
			<div class="shrink-0">
				<ShieldHalf class="h-8 w-8 -ml-0.5" />
			</div>
			{neighbouringLeagues[2]}
		</div>
	</div>
	<div class="absolute mt-32 flex justify-center current-league-fork">
		<div class="flex justify-between w-full absolute -translate-y-full top-0">
			<div class="h-5 w-0.5 current-league-fork-background-color">
				<div class="absolute -translate-x-1/2 bottom-5">
					<p
						class="text-center max-w-14 leading-none"
						class:text-xs={highestEloInPreviousLeague === null}
						class:mb-1={highestEloInPreviousLeague !== null && lowestEloInNextLeague === null}
					>
						{highestEloInPreviousLeague ?? 'Min. League'}
					</p>
				</div>
			</div>
			<div class="h-5 w-0.5 current-league-fork-background-color">
				<div class="absolute -translate-x-1/2 bottom-5">
					<p
						class="text-center max-w-14 leading-none"
						class:text-xs={lowestEloInNextLeague === null}
						class:mb-1={lowestEloInNextLeague !== null && highestEloInPreviousLeague === null}
					>
						{lowestEloInNextLeague ?? 'Max. League'}
					</p>
				</div>
			</div>
		</div>
		<div class="h-0.5 w-full current-league-fork-background-color"></div>
		<div class="h-5 w-0.5 current-league-fork-background-color absolute mt-0.5 fork-center"></div>
		<div class="absolute mt-7 flex flex-col items-center">
			<div class="shrink-0">
				<ShieldHalf class="h-8 w-8 -ml-0.5" />
			</div>
			{neighbouringLeagues[1]}
		</div>
	</div>
</div>

<style>
	.progress-background {
		background-color: var(--fallback-er, oklch(var(--er) / var(--tw-bg-opacity)));
	}

	.current-league-fork {
		width: calc(100% - 2rem + 0.125rem);
	}

	.current-league-fork-background-color {
		background-color: var(--fallback-bc, oklch(var(--bc) / 0.2));
	}

	.fork-center {
		margin-left: -0.0625rem;
	}
</style>
