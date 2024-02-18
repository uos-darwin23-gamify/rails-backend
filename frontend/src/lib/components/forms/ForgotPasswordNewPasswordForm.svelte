<script lang="ts">
	import { goto } from '$app/navigation';
	import { Button } from '$lib/components/ui/button';
	import * as Card from '$lib/components/ui/card';
	import { Input } from '$lib/components/ui/input';
	import { Label } from '$lib/components/ui/label';
	import { Separator } from '$lib/components/ui/separator';
	import * as Dialog from '$lib/components/ui/dialog';

	let formData = { password: '', confirmPassword: '' };
	type FormValidation = null | false | true;

	let successDialogOpen = false;

	let formValidation: {
		passwordMin8: FormValidation;
		passwordsMatch: FormValidation;
	} = {
		passwordMin8: null,
		passwordsMatch: null
	};

	const validateData = (): boolean => {
		let isOk = true;

		if (formData.password.length < 8) {
			isOk = false;
			formValidation.passwordMin8 = false;
		}

		if (formData.password !== formData.confirmPassword) {
			isOk = false;
			formValidation.passwordsMatch = false;
		}

		return isOk;
	};

	const accessToken = new URLSearchParams(window.location.search).get('reset-password-token');

	const handleSubmit = async () => {
		if (!validateData()) {
			console.error('Validation failed');
			return;
		}

		if (accessToken === null) {
			console.error('Token not found in URL');
			return;
		}

		const response = await fetch('api/auth/password', {
			method: 'PUT',
			headers: {
				'Content-Type': 'application/json',
				'access-token': accessToken
			},
			body: JSON.stringify({
				password: formData.password,
				password_confirmation: formData.confirmPassword,
				reset_password_token: accessToken
			})
		});

		if (!response.ok) {
			console.error('Failed to reset password');
		} else {
			successDialogOpen = true;
		}
	};

	$: {
		if (formValidation.passwordMin8 !== null) {
			formValidation.passwordMin8 = formData.password.length >= 8;
		}

		if (formValidation.passwordsMatch !== null) {
			formValidation.passwordsMatch = formData.password === formData.confirmPassword;
		}
	}
</script>

<Card.Root class="relative flex-shrink-0 grow max-w-sm m-4">
	<Card.Header>
		<Card.Title>Reset Password</Card.Title>
		<Card.Description>Please enter a new password.</Card.Description>
	</Card.Header>
	<Card.Content>
		<form class="grid w-full items-center gap-4" on:submit|preventDefault={handleSubmit}>
			<div class="flex flex-col space-y-1.5">
				<Label for="password">Password (min. 8 characters)</Label>
				<Input
					id="password"
					type="password"
					placeholder="Password"
					bind:value={formData.password}
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
				<Label for="confirm-password">Confirm Password</Label>
				<Input
					id="confirm-password"
					type="password"
					placeholder="Confirm Password"
					bind:value={formData.confirmPassword}
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
			<Separator class="my-1" />
			<Button type="submit">Confirm</Button>
		</form>
	</Card.Content>
</Card.Root>

{#if successDialogOpen}
	<Dialog.Root bind:open={successDialogOpen}>
		<Dialog.Content>
			<Dialog.Header>
				<Dialog.Title class="flex justify-center items-center">Password has been changed</Dialog.Title
				>
				<Dialog.Description class="text-left">
					Your password has been changed. Please log in to continue.</Dialog.Description
				>
			</Dialog.Header>
			<Dialog.Footer class="mt-4">
				<Button on:click={() => { successDialogOpen = false; goto('/login'); }}>Acknowledge</Button>
			</Dialog.Footer>
		</Dialog.Content>
	</Dialog.Root>
{/if}