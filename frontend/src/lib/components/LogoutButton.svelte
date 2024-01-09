<script lang="ts">
	import { logOut } from '$lib/auth';
	import { authenticated } from '$lib/stores';

	const handleLogout = async () => {
		const logoutSuccessful = await logOut();
		logoutSuccessful && authenticated.verify();
	};
</script>

<button class="btn" on:click={handleLogout}>Logout</button>
