<script lang="ts">
	import '../global.pcss';
	import { socketConnection } from '$lib/stores';

	$: $socketConnection;
</script>

<slot />
