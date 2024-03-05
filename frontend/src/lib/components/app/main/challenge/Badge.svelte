<script lang="ts">
	import { Badge } from '$lib/components/ui/badge';

	export let value: 'SIMPLE' | 'EASY' | 'MEDIUM' | 'HARD' | 'EXTREME';
	let bgColor = '';

	switch (value) {
		case 'HARD':
			bgColor = 'bg-red-900';
			break;
		case 'MEDIUM':
			bgColor = 'bg-yellow-900';
			break;
		case 'EASY':
			bgColor = 'bg-green-900';
			break;
		case 'SIMPLE':
			bgColor = 'bg-indigo-900';
			break;
		case 'EXTREME':
			bgColor = 'bg-pink-900';
			break;
		default:
			break;
	}
</script>

<Badge variant="outline" class={bgColor}>{value}</Badge>
