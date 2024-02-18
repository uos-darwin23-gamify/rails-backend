<script lang="ts">
	import { Badge } from '$lib/components/new-york/ui/badge';

	export let value: string;

	let displayValue = '';

	$: {
		switch (value) {
			case 'league':
				displayValue = 'League';
				break;
			case 'global':
				displayValue = 'Global';
				break;
			default:
				break;
		}
	}
</script>

<Badge variant="outline" class="bg-card">{displayValue}</Badge>
