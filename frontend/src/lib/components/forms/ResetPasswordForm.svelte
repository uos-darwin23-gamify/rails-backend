<script lang="ts">
	import { Button } from '$lib/components/ui/button';
	import { Input } from '$lib/components/ui/input';
	import { Label } from '$lib/components/ui/label';
	import { Separator } from '$lib/components/ui/separator';
	import * as Dialog from '$lib/components/ui/dialog';
	import { toast } from 'svelte-sonner';

	export let dialogOpen: boolean;

	let formData = { currentPassword: '', newPassword: '', confirmNewPassword: '' };

	type FormValidation = null | false | true;

	let formValidation: {
		currentPasswordCorrect: FormValidation;
		passwordMin8: FormValidation;
		passwordsMatch: FormValidation;
	} = {
		currentPasswordCorrect: null,
		passwordMin8: null,
		passwordsMatch: null
	};

	const validateData = (): boolean => {
		let isOk = true;

		if (formData.newPassword.length < 8) {
			isOk = false;
			formValidation.passwordMin8 = false;
		}

		if (formData.newPassword !== formData.confirmNewPassword) {
			isOk = false;
			formValidation.passwordsMatch = false;
		}

		return isOk;
	};

	//let formData = { currentpassword: '', newpassword: '', newpassworddup: '' };

	$: {
		if (!dialogOpen) {
			formData.currentPassword = '';
			formData.newPassword = '';
			formData.confirmNewPassword = '';
			formValidation.currentPasswordCorrect = null;
			formValidation.passwordMin8 = null;
			formValidation.passwordsMatch = null;
		}
	}

	const handleSubmit = async () => {
		if (!validateData()) {
			return;
		}

		const response = await fetch('/api/change-password', {
			method: 'POST',
			body: JSON.stringify({ ...formData }),
			headers: {
				'Content-Type': 'application/json'
			}
		});

		if (!response.ok) {
			formValidation.currentPasswordCorrect = false;
			return;
		}

		dialogOpen = false;
		toast.success('Password Changed Successfully');
	};

	$: {
		if (formValidation.passwordMin8 !== null) {
			formValidation.passwordMin8 = formData.newPassword.length >= 8;
		}

		if (formValidation.passwordsMatch !== null) {
			formValidation.passwordsMatch = formData.newPassword === formData.confirmNewPassword;
		}
	}
</script>

<Dialog.Root bind:open={dialogOpen}>
	<Dialog.Content>
		<form on:submit|preventDefault={handleSubmit}>
			<Dialog.Header>
				<div class="flex flex-col space-y-1.5">
					<Label for="current-password">Current Password</Label>
					<Input
						id="current-password"
						type="password"
						placeholder="Current Password"
						bind:value={formData.currentPassword}
						on:input={() => {
							if (formValidation.passwordMin8 === null) {
								formValidation.passwordMin8 = false;
							}
						}}
					/>
					{#if formValidation.currentPasswordCorrect === false}
						<Label class="text-error">Current Password Incorrect</Label>
					{/if}
				</div>
				<div class="flex flex-col space-y-1.5">
					<Label for="new-password">New Password (min. 8 characters)</Label>
					<Input
						id="new-password"
						type="password"
						placeholder="Password"
						bind:value={formData.newPassword}
						on:input={() => {
							if (formValidation.passwordMin8 === null) {
								formValidation.passwordMin8 = false;
							}
						}}
					/>
					{#if formValidation.passwordMin8 === false}
						<Label class="text-error">Password Too Short (min. 8 characters)</Label>
					{:else if formValidation.passwordMin8 === true}
						<Label class="text-success">Password Length Ok</Label>
					{/if}
				</div>
				<div class="flex flex-col space-y-1.5">
					<Label for="confirm-new-password">Confirm New Password</Label>
					<Input
						id="confirm-new-password"
						type="password"
						placeholder="Confirm New Password"
						bind:value={formData.confirmNewPassword}
						on:input={() => {
							if (formValidation.passwordsMatch === null) {
								formValidation.passwordsMatch = false;
							}
						}}
					/>
					{#if formValidation.passwordsMatch === false}
						<Label class="text-error">Passwords Do Not Match</Label>
					{:else if formValidation.passwordsMatch === true}
						<Label class="text-success">Passwords Match</Label>
					{/if}
				</div>
			</Dialog.Header>
			<Dialog.Footer class="mt-4 flex sm:justify-between gap-2">
				<Button variant="secondary" on:click={() => (dialogOpen = false)}>Cancel</Button>
				<Button type="submit">Change Password</Button>
			</Dialog.Footer>
		</form>
	</Dialog.Content>
</Dialog.Root>
