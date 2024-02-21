<script lang="ts">
	import ResetPasswordForm from '$lib/components/forms/ResetPasswordForm.svelte';
	import { Button } from '$lib/components/ui/button';
	import * as Card from '$lib/components/ui/card';
	import { Label } from '$lib/components/ui/label';
	import { Switch } from '$lib/components/ui/switch';
	import { onMount, tick } from 'svelte';
	import { toast } from 'svelte-sonner';

	let dialogOpen = false;

	let checked = true;
	let error: string | undefined = undefined;
	let loading = true;

	const getEmailNotificationsSetting = async () => {
		await tick();

		const response = await fetch('/api/email-notifications-setting');

		if (!response.ok) {
			loading = false;
			error = 'Failed to fetch email notifications settings status.';
			return;
		}

		error = undefined;
		const data = await response.json();
		checked = data.email_notifications_setting;
		loading = false;
	};

	const updateEmailNotificationsSetting = async () => {
		await tick();

		const response = await fetch('/api/email-notifications-setting', {
			method: 'POST',
			body: JSON.stringify({ email_notifications_setting: checked }),
			headers: {
				'Content-Type': 'application/json'
			}
		});

		if (!response.ok) {
			error = 'Failed to update email notifications settings status.';
			return;
		}

		error = undefined;
		toast.success((checked ? 'Enabled' : 'Disabled') + ' email notifications.');
		getEmailNotificationsSetting();
	};

	onMount(getEmailNotificationsSetting);
</script>

{#if loading}
	<div class="grow flex items-center justify-center">
		<span class="loading loading-ring loading-lg" />
	</div>
{:else}
	<div class="p-4 relative flex grow">
		<div class="h-full flex grow overflow-y-auto">
			<Card.Root class="flex grow flex-col">
				<Card.Header>
					<Card.Title>Settings</Card.Title>
				</Card.Header>
				<Card.Content class="gap-4 flex flex-col items-start">
					<div class="flex items-center space-x-2">
						{#if error !== undefined}
							<Label class="text-error">{error}</Label>
						{:else}
							<Switch
								id="email-notifications"
								bind:checked
								onCheckedChange={updateEmailNotificationsSetting}
							/>
							<Label for="email-notifications"
								>Email Notifications {checked ? 'Enabled' : 'Disabled'}</Label
							>
						{/if}
					</div>
					<Button on:click={() => (dialogOpen = true)}>Change Password</Button>
					<ResetPasswordForm bind:dialogOpen />
				</Card.Content>
			</Card.Root>
		</div>
	</div>
{/if}
