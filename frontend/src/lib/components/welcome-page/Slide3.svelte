<script lang="ts">
	import { onMount } from 'svelte';

	let headerHeight = 64;

	onMount(() => {
		const header = document.getElementById('welcome-header');
		const height = header?.offsetHeight;
		if (height !== undefined) {
			headerHeight = height;
		}
	});
</script>

<div class="snap-start relative h-full w-full overflow-hidden flex">
	<div class="flex grow items-center flex-col"></div>
</div>
