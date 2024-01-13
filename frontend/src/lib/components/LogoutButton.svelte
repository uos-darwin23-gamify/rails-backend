<script lang="ts">
	import { logOut } from '$lib/auth';
	import { authenticated } from '$lib/stores';
	import { Button } from '$lib/components/ui/button';

	const handleLogout = async () => {
		const logoutSuccessful = await logOut();
		logoutSuccessful && authenticated.verify();
	};
</script>

<Button on:click={handleLogout}>Logout</Button>
