<script lang="ts">
	import { Form as FormPrimitive } from 'formsnap';
	import { cn } from '$lib/utils/ui';
	import type { HTMLAttributes } from 'svelte/elements';

	type $$Props = HTMLAttributes<HTMLParagraphElement>;
	let className: string | undefined | null = undefined;
	export { className as class };
</script>

<FormPrimitive.Validation
	class={cn('text-[0.8rem] font-medium text-destructive', className)}
	{...$$restProps}
/>
