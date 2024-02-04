<script lang="ts">
	import type { CodeOutputChallengeSolutionType } from '$lib/types/challenge-solution';
	import type { CodeOutputChallengeDataType } from '$lib/types/challenge-data';

	export let data: CodeOutputChallengeDataType;
	export let solutionState: CodeOutputChallengeSolutionType;
</script>

{JSON.stringify(data)}
