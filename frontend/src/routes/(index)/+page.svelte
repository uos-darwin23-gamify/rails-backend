<script lang="ts">
	import { onMount } from 'svelte';
	import Canvas from '$lib/components/welcome-page/Canvas.svelte';

	let headerHeight = 64;

	onMount(() => {
		const header = document.getElementById('welcome-header');
		const height = header?.offsetHeight;
		if (height !== undefined) {
			headerHeight = height;
		}
	});
</script>

<div class="grow relative overflow-y-auto" style={`height: calc(100% - ${headerHeight}px);`}>
	<Canvas />
</div>
