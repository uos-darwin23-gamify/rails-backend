<script lang="ts">
	import { Badge } from '$lib/components/new-york/ui/badge';
	import { challengeTypes } from '../data/data';
	import * as HoverCard from '$lib/components/ui/hover-card';

	export let value: string;
	const icon = challengeTypes.find(({ value: _value }) => value === _value)?.icon;
	const label = challengeTypes.find(({ value: _value }) => value === _value)?.label;
</script>

<HoverCard.Root>
	<HoverCard.Trigger>
		<Badge variant="outline" class="bg-card"
			><svelte:component this={icon} class="mr-2 my-1" />
			<p class="sm:max-w-[160px] max-w-[72px] truncate font-medium">{label}</p></Badge
		>
	</HoverCard.Trigger>
	<HoverCard.Content class="w-fit h-fit py-1 px-2.5">
		<div class="text-xs flex items-center">
			<svelte:component this={icon} class="mr-2 my-1" />
			{label}
		</div>
	</HoverCard.Content>
</HoverCard.Root>
