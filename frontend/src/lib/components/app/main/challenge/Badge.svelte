<script lang="ts">
	import { Badge } from '$lib/components/ui/badge';

	export let value: 'HARD' | 'MEDIUM' | 'EASY';
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
		default:
			break;
	}
</script>

<Badge variant="outline" class={bgColor + ' ml-2'}>{value}</Badge>
