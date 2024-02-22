<script lang="ts">
	import * as THREE from 'three';
	import WAVES from 'vanta/dist/vanta.waves.min';
	import { onMount } from 'svelte';
	import { browser } from '$app/environment';

	let container: HTMLDivElement;

	onMount(async () => {
		if (browser) {
			const p5 = await import('p5');
			WAVES({
				el: container,
				mouseControls: true,
				touchControls: true,
				gyroControls: false,
				minHeight: 200.0,
				minWidth: 200.0,
				scale: 1.0,
				scaleMobile: 1.0,
				p5,
				THREE
			});
		}
	});
</script>

<!-- <svelte:head>
<script src="three.r134.min.js"></script>
<script src="vanta.waves.min.jss"></script>
<script>
VANTA.WAVES({
  el: "#waves",
  mouseControls: true,
  touchControls: true,
  gyroControls: false,
  minHeight: 200.00,
  minWidth: 200.00,
  scale: 1.00,
  scaleMobile: 1.00,
  shininess: 11.00,
  waveHeight: 8.00,
  waveSpeed: 0.90,
  zoom: 0.88
})
</script>
</svelte:head> -->

<div class="flex grow items-center flex-col">
	<div class="flex flex-col justify-center items-center grow" bind:this={container}></div>
</div>
