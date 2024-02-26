<script lang="ts">
	import { cn } from '$lib/utils/ui';
	import { Motion } from 'svelte-motion';
	export let word: { text: string; className?: string };
	export let className = '';
	export let cursorClassName = void 0;
</script>

<div class={cn('my-6 flex space-x-1', className)}>
	<Motion
		let:motion
		style={{
			width: 'fit-content'
		}}
		initial={{
			width: '0%'
		}}
		transition={{
			duration: 4,
			ease: 'linear',
			delay: 1,
			yoyo: Infinity,
			repeatDelay: 2
		}}
		animate={{
			width: '100%'
		}}
	>
		<div use:motion class="overflow-hidden">
			<div
				class="lg:text:3xl text-xs font-bold sm:text-base md:text-xl xl:text-5xl"
				style="white-space: nowrap;"
			>
				<h1 class="inline-block">
					{#each word.text as char, index (`char-${index}`)}
						<span class={cn(`text-black dark:text-white `, word.className)}>
							{char}
						</span>
					{/each}
					&nbsp;
				</h1>
			</div>
		</div>
	</Motion>
	<Motion
		let:motion
		initial={{
			opacity: 0
		}}
		animate={{
			opacity: 1
		}}
		transition={{
			duration: 0.8,

			repeat: Infinity,
			repeatType: 'reverse'
		}}
	>
		<span
			use:motion
			class={cn('block h-4 w-[4px]  rounded-sm bg-blue-500 sm:h-6 xl:h-12', cursorClassName)}
		></span>
	</Motion>
</div>
