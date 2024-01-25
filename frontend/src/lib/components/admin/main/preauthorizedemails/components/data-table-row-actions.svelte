<script lang="ts">
	import { DotsHorizontal } from 'radix-icons-svelte';
	import { Button } from '$lib/components/new-york/ui/button';
	import * as DropdownMenu from '$lib/components/new-york/ui/dropdown-menu';
	// import { labels } from "../data/data";
	import { preAuthorizedEmailsSchema, type PreAuthorizedEmail } from '../data/schemas';

	export let row: PreAuthorizedEmail;
	const email = preAuthorizedEmailsSchema.parse(row);
	export let deleteEmail: (id: number) => Promise<void>;
	export let rowId: number;
</script>

<DropdownMenu.Root>
	<DropdownMenu.Trigger asChild let:builder>
		<Button
			variant="ghost"
			builders={[builder]}
			class="flex h-8 w-8 p-0 data-[state=open]:bg-muted"
		>
			<DotsHorizontal class="h-4 w-4" />
			<span class="sr-only">Open menu</span>
		</Button>
	</DropdownMenu.Trigger>
	<DropdownMenu.Content class="w-[160px]" align="end">
		<!-- <DropdownMenu.Item>Edit</DropdownMenu.Item>
		<DropdownMenu.Item>Make a copy</DropdownMenu.Item>
		<DropdownMenu.Item>Favorite</DropdownMenu.Item> -->
		<DropdownMenu.Item
			class="bg-destructive text-destructive-foreground hover:bg-destructive/90 data-[highlighted]:bg-destructive data-[highlighted]:text-destructive-foreground data-[highlighted]:bg-destructive/90"
			on:click={() => deleteEmail(rowId)}>Delete</DropdownMenu.Item
		>
		<!-- <DropdownMenu.Separator />
		<DropdownMenu.Sub>
			<DropdownMenu.SubTrigger>Labels</DropdownMenu.SubTrigger>
			<DropdownMenu.SubContent>
				<DropdownMenu.RadioGroup value={email.email}>
					{#each labels as label}
						<DropdownMenu.RadioItem value={label.value}>
							{label.label}
						</DropdownMenu.RadioItem>
					{/each}
				</DropdownMenu.RadioGroup>
			</DropdownMenu.SubContent>
		</DropdownMenu.Sub>
		<DropdownMenu.Separator />
		<DropdownMenu.Item>
			Delete
			<DropdownMenu.Shortcut>⌘⌫</DropdownMenu.Shortcut>
		</DropdownMenu.Item> -->
	</DropdownMenu.Content>
</DropdownMenu.Root>
