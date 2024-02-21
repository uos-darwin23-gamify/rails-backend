<script lang="ts">
	import { Button } from '$lib/components/ui/button';
	import * as Card from '$lib/components/ui/card';
	import { Input } from '$lib/components/ui/input';
	import { Label } from '$lib/components/ui/label';
	import { Separator } from '$lib/components/ui/separator';
	import { dev } from '$app/environment';
	import { goto } from '$app/navigation';

	let formData = { email: '' };

	const handleSubmit = async () => {
		await fetch('/api/auth/password', {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({
				user: {
					email: formData.email
				},
				redirect_url: dev ? 'localhost:5173/new-password' : 'gamifycoding.me/new-password'
			})
		});

		goto('/forgot-password/next');
	};
</script>

<Card.Root class="relative flex-shrink-0 grow max-w-sm m-4">
	<Card.Header>
		<Card.Title>Reset Password</Card.Title>
		<Card.Description>Please enter your email address.</Card.Description>
	</Card.Header>
	<Card.Content>
		<form class="grid w-full items-center gap-4" on:submit|preventDefault={handleSubmit}>
			<div class="flex flex-col space-y-1.5">
				<Label for="email">Email</Label>
				<Input id="email" placeholder="Email" bind:value={formData.email} />
			</div>
			<Separator class="my-1" />
			<Button type="submit">Send Password Reset Link</Button>
			<Button href="/login" variant="secondary">Back</Button>
		</form>
	</Card.Content>
</Card.Root>
