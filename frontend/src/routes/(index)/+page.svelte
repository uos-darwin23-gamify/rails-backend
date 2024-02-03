<script lang="ts">
	import { buttonVariants } from '$lib/components/ui/button';
	import { onMount } from 'svelte';

	let headerHeight = 64;

	onMount(() => {
		const header = document.getElementById('welcome-header');
		const height = header?.getBoundingClientRect().height;
		if (height !== undefined) {
			headerHeight = height;
		}
	});
</script>

<header
	id="welcome-header"
	class="p-2 flex items-center justify-end sticky top-0 z-50 w-full border-b border-border/40 bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60"
>
	<a href="/login" class={buttonVariants()}>Open App</a>
</header>
<div class="relative flex overflow-y-auto" style={`height: calc(100% - ${headerHeight}px);`}>
	<div class="flex grow items-center flex-col">
		<div class="flex flex-col justify-center items-center grow">Welcome Page</div>
	</div>
</div>
