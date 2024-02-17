<script lang="ts">
	import { Button } from '$lib/components/ui/button';
	import * as Card from '$lib/components/ui/card';
	import { Input } from '$lib/components/ui/input';
	import { Label } from '$lib/components/ui/label';
	import { Separator } from '$lib/components/ui/separator';

	let formData = { password: '', confirmPassword: '' };
	type FormValidation = null | false | true;

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

	const handleSubmit = async () => {
		if (!validateData()) {
			console.log('Password reset failed');
		}
		else {
			console.log('Password reset successful');
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
