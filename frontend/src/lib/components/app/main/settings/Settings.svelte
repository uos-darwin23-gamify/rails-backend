<script lang="ts">
	import ResetPasswordForm from '$lib/components/forms/ResetPasswordForm.svelte';
	import { Button } from '$lib/components/ui/button';
	import * as Card from '$lib/components/ui/card';

	let dialogOpen = false;
</script>

<div class="p-4 relative flex grow">
	<div class="h-full flex grow overflow-y-auto">
		<Card.Root class="flex grow flex-col">
			<Card.Header>
				<Card.Title>Settings</Card.Title>
			</Card.Header>
			<Card.Content>
				<Button on:click={() => (dialogOpen = true)}>Change Password</Button>
				<ResetPasswordForm bind:dialogOpen />
			</Card.Content>
		</Card.Root>
	</div>
</div>
