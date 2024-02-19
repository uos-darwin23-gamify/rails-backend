<script lang="ts">
	import { Badge } from '$lib/components/new-york/ui/badge';

	export let value: string;
</script>

<Badge variant="outline" class="bg-card">{value}</Badge>
