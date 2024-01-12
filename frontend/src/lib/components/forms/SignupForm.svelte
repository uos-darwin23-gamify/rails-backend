<script lang="ts">
	import { signUp } from '$lib/auth';
	import { authenticated } from '$lib/stores';
	import { Button, buttonVariants } from '$lib/components/ui/button';
	import * as Card from '$lib/components/ui/card';
	import { Input } from '$lib/components/ui/input';
	import { Label } from '$lib/components/ui/label';
	import { Separator } from '$lib/components/ui/separator';
	import { Info } from 'lucide-svelte';
	import * as Popover from '$lib/components/ui/popover';

	// const EMAIL_REGEX = /^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z0-9]+$/;
	const EMAIL_REGEX = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

	let formData = { email: '', password: '', confirmPassword: '' };

	type FormValidation = null | false | true;

	let formValidation: {
		emailValid: FormValidation;
		emailNotTaken: FormValidation;
		passwordMin8: FormValidation;
		passwordsMatch: FormValidation;
	} = {
		emailValid: null,
		emailNotTaken: null,
		passwordMin8: null,
		passwordsMatch: null
	};

	const validateData = (): boolean => {
		let isOk = true;

		if (!EMAIL_REGEX.test(formData.email)) {
			isOk = false;
			formValidation.emailValid = false;
		}

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
			return;
		}

		const signupSuccessful = await signUp(formData.email, formData.password);

		if (signupSuccessful) {
			authenticated.verify();
		} else {
			formValidation.emailNotTaken = false;
		}
	};

	$: {
		if (formValidation.emailValid !== null) {
			formValidation.emailValid = EMAIL_REGEX.test(formData.email);
		}

		if (formValidation.passwordMin8 !== null) {
			formValidation.passwordMin8 = formData.password.length >= 8;
		}

		if (formValidation.passwordsMatch !== null) {
			formValidation.passwordsMatch = formData.password === formData.confirmPassword;
		}
	}
</script>

<Card.Root class="relative flex-shrink-0 w-full max-w-sm">
	<Card.Header>
		<div class="flex justify-between">
			<div class="flex flex-col">
				<Card.Title>Signup</Card.Title>
				<Card.Description>Create an account for GamifyCoding&#8482;</Card.Description>
			</div>
			<Popover.Root portal={null}>
				<Popover.Trigger asChild let:builder>
					<Button builders={[builder]} variant="outline" size="icon"
						><Info className="h-4 w-4" /></Button
					>
				</Popover.Trigger>
				<Popover.Content class="w-80">
					<div class="flex justify-between space-x-4">
						<div class="shrink-0">
							<Info className="h-4 w-4" />
						</div>
						<div class="space-y-1">
							<h4 class="text-sm font-semibold">Note</h4>
							<p class="text-sm">
								This platform is for a research experiment. You need a pre-authorized email to sign
								up.
							</p>
						</div>
					</div>
				</Popover.Content>
			</Popover.Root>
		</div>
	</Card.Header>
	<Card.Content>
		<form class="grid w-full items-center gap-4" on:submit|preventDefault={handleSubmit}>
			<div class="flex flex-col space-y-1.5">
				<Label for="email">Email</Label>
				<Input
					id="email"
					placeholder="Email"
					bind:value={formData.email}
					on:input={() => {
						if (formValidation.emailValid === null) {
							formValidation.emailValid = false;
						}

						formValidation.emailNotTaken = null;
					}}
				/>
				<div class="flex flex-col gap-2">
					{#if formValidation.emailValid === false}
						<Label class="text-error">Email Not Valid</Label>
					{:else if formValidation.emailValid === true}
						<Label class="text-success">Email Valid</Label>
					{/if}
					{#if formValidation.emailNotTaken === false}
						<Label class="text-error">Email Is Not Pre-Authorized Or Belongs To Another User</Label>
					{/if}
				</div>
			</div>
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
			<Button type="submit">Create Account</Button>
			<a href="/login" class={buttonVariants({ variant: 'secondary' })}>Back</a>
		</form>
	</Card.Content>
</Card.Root>
