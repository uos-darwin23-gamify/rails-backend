<script lang="ts">
	import * as Popover from '$lib/components/ui/popover';
	import { FlaskConical, Check, X } from 'lucide-svelte';
	import { Button } from '$lib/components/ui/button';
	import { Input } from '$lib/components/ui/input';
	import { Separator } from '$lib/components/ui/separator';

	export let regexPattern: string;
	let testValue = '';
	let regexMatchesTestValue: boolean;
	let regexPatternError = false;
	$: {
		regexPatternError = false;
		try {
			new RegExp(regexPattern);
		} catch (error) {
			regexPatternError = true;
		}

		if (!regexPatternError) {
			regexMatchesTestValue = new RegExp(regexPattern).test(testValue);
		}
	}
</script>

<Popover.Root>
	<Popover.Trigger>
		<Button size="icon" variant="outline"><FlaskConical class="h-5 w-5" /></Button></Popover.Trigger
	>
	<Popover.Content class="w-80" align="end">
		<div class="flex flex-col">
			<p class="text-sm text-muted-foreground">
				Regex predicate for correct answer matching for challenge submissions.
			</p>
			<Separator class="my-2" />
			<p class="text-muted-foreground">Example Patterns:</p>
			<ul class="list-disc text-sm text-muted-foreground pl-4 pb-2 h-20 overflow-y-auto">
				<li>
					^Answer is 42$
					<br />
					↑ Only EXACT answer will match.
				</li>
				<li>
					Answer is 42<br />
					↑ Matches if answer exists as a substring.
				</li>
				<li>
					^(Answer is 42|Another answer)$<br />
					↑ Allow multiple answers.
				</li>
				<li>
					^[Aa][Nn][Ss][W][Ee][Rr]$<br />
					↑ Case-insensitive match.
				</li>
			</ul>
			<Separator />
			<div
				class="flex justify-center items-center pt-2"
				class:text-green-500={regexMatchesTestValue}
				class:text-red-500={regexPatternError || !regexMatchesTestValue}
			>
				{#if regexPatternError}
					<p>Regex Pattern Invalid</p>
					<X class="h-5 w-5" />
				{:else if regexMatchesTestValue}
					<p>Answer is Correct</p>
					<Check class="h-5 w-5" />
				{:else}
					<p>Answer is Incorrect</p>
					<X class="h-5 w-5" />
				{/if}
			</div>
			<p class="py-2">Test Answer:</p>
			<Input class="mb-2" bind:value={testValue} />
			<p class="mb-2">Regex Pattern:</p>
			<Input bind:value={regexPattern} />
		</div>
	</Popover.Content>
</Popover.Root>
