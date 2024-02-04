<script lang="ts">
	import type { ConnectBlocksChallengeSolutionType } from '$lib/types/challenge-solution';
	import type { ConnectBlocksChallengeDataType } from '$lib/types/challenge-data';

	export let data: ConnectBlocksChallengeDataType;
	export let solutionState: ConnectBlocksChallengeSolutionType;
</script>

{JSON.stringify(data)}
