<script lang="ts">
	import type { PageData } from './$types';
	import ConsentForm from './ConsentForm.svelte';
	export let data: PageData;
</script>

<ConsentForm form={data.form} />
