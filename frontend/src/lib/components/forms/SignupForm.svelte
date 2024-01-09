<script lang="ts">
	import { signUp } from '$lib/auth';
	import Icon from '@iconify/svelte';
	import validIcon from '@iconify-icons/mdi/checkbox-marked';
	import errorIcon from '@iconify-icons/mdi/close-box';
	import { authenticated } from '$lib/stores';

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

<form
	class="card flex-shrink-0 w-full max-w-sm shadow-2xl bg-base-100"
	on:submit|preventDefault={handleSubmit}
>
	<div class="card-body">
		<h2 class="card-title">Signup</h2>
		<div class="form-control">
			<label class="label" for="email">
				<span class="label-text">Email</span>
			</label>
			<input
				type="text"
				placeholder="email"
				class="input input-bordered"
				id="email"
				bind:value={formData.email}
				on:input={() => {
					if (formValidation.emailValid === null) {
						formValidation.emailValid = false;
					}

					formValidation.emailNotTaken = null;
				}}
			/>
		</div>
		<div class="form-control">
			<label class="label" for="password">
				<span class="label-text">Password (min. 8 characters)</span>
			</label>
			<input
				type="password"
				placeholder="password"
				class="input input-bordered"
				id="password"
				bind:value={formData.password}
				on:input={() => {
					if (formValidation.passwordMin8 === null) {
						formValidation.passwordMin8 = false;
					}
				}}
			/>
		</div>
		<div class="form-control">
			<label class="label" for="confirm-password">
				<span class="label-text">Confirm Password</span>
			</label>
			<input
				type="password"
				placeholder="confirm password"
				class="input input-bordered"
				id="confirm-password"
				bind:value={formData.confirmPassword}
				on:input={() => {
					if (formValidation.passwordsMatch === null) {
						formValidation.passwordsMatch = false;
					}
				}}
			/>
		</div>
		{#if formValidation.emailValid !== null || formValidation.emailNotTaken !== null || formValidation.passwordMin8 !== null || formValidation.passwordsMatch !== null}
			<div class="divider my-1" />
		{/if}
		{#if formValidation.emailValid === false}
			<div class="flex">
				<Icon icon={errorIcon} height={24} class="scale-125" color="oklch(var(--er))" />
				<p class="ml-3">Email Not Valid</p>
			</div>
		{:else if formValidation.emailValid === true}
			<div class="flex">
				<Icon icon={validIcon} height={24} class="scale-125" color="oklch(var(--su))" />
				<p class="ml-3">Email Valid</p>
			</div>
		{/if}
		{#if formValidation.emailNotTaken === false}
			<div class="flex">
				<Icon icon={errorIcon} height={24} class="scale-125" color="oklch(var(--er))" />
				<p class="ml-3">Email Belongs To Another User</p>
			</div>
		{/if}
		{#if formValidation.passwordMin8 === false}
			<div class="flex">
				<Icon icon={errorIcon} height={24} class="scale-125" color="oklch(var(--er))" />
				<p class="ml-3">Password Too Short (min. 8 characters)</p>
			</div>
		{:else if formValidation.passwordMin8 === true}
			<div class="flex">
				<Icon icon={validIcon} height={24} class="scale-125" color="oklch(var(--su))" />
				<p class="ml-3">Password Length Ok</p>
			</div>
		{/if}
		{#if formValidation.passwordsMatch === false}
			<div class="flex">
				<Icon icon={errorIcon} height={24} class="scale-125" color="oklch(var(--er))" />
				<p class="ml-3">Passwords Do Not Match</p>
			</div>
		{:else if formValidation.passwordsMatch === true}
			<div class="flex">
				<Icon icon={validIcon} height={24} class="scale-125" color="oklch(var(--su))" />
				<p class="ml-3">Passwords Match</p>
			</div>
		{/if}
		<div class="divider my-1" />
		<div class="form-control">
			<button class="btn btn-primary btn-sm">Create Account</button>
		</div>
		<div class="form-control">
			<a class="btn btn-neutral btn-sm mt-2" href="/login">Back</a>
		</div>
	</div>
</form>
