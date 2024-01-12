<script lang="ts">
	import { logIn } from '$lib/auth';
	import { authenticated } from '$lib/stores';
	import { Button, buttonVariants } from '$lib/components/ui/button';
	import * as Card from '$lib/components/ui/card';
	import { Input } from '$lib/components/ui/input';
	import { Label } from '$lib/components/ui/label';
	import { Separator } from '$lib/components/ui/separator';

	let formData = { email: '', password: '' };
	let emailOrPasswordInvalid = false;

	const handleSubmit = async () => {
		const loginSuccessful = await logIn(formData.email, formData.password);

		if (loginSuccessful) {
			authenticated.verify();
		} else {
			emailOrPasswordInvalid = true;
		}
	};
</script>

<Card.Root class="relative flex-shrink-0 grow max-w-sm m-4">
	<Card.Header>
		<Card.Title>Login</Card.Title>
		<Card.Description>Log into GamifyCoding&#8482;</Card.Description>
	</Card.Header>
	<Card.Content>
		<form class="grid w-full items-center gap-4" on:submit|preventDefault={handleSubmit}>
			<div class="flex flex-col space-y-1.5">
				<Label for="email">Email</Label>
				<Input
					id="email"
					placeholder="Email"
					bind:value={formData.email}
					on:input={() => (emailOrPasswordInvalid = false)}
				/>
			</div>
			<div class="flex flex-col space-y-1.5">
				<Label for="password">Password</Label>
				<Input
					id="password"
					placeholder="Password"
					bind:value={formData.password}
					on:input={() => (emailOrPasswordInvalid = false)}
				/>
			</div>
			{#if emailOrPasswordInvalid}
				<Label class="text-error">Email Or Password Invalid</Label>
			{/if}
			<Separator class="my-1" />
			<Button type="submit">Login</Button>
			<a href="/signup" class={buttonVariants({ variant: 'secondary' })}>Create An Account</a>
		</form>
	</Card.Content>
</Card.Root>
