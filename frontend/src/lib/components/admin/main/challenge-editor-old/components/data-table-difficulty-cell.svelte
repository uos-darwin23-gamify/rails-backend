<script lang="ts">
	import { Badge } from '$lib/components/new-york/ui/badge';
	// import { challengeDifficulties } from '../data/data';

	export let value: string;
	// const color = challengeDifficulties.find(({ value: _value }) => value === _value)?.color;
	// const label = challengeDifficulties.find(({ value: _value }) => value === _value)?.label;
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

<Badge variant="outline" class={bgColor}>{value}</Badge>
