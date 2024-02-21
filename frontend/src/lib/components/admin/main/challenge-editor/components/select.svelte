<script lang="ts">
	import * as Card from '$lib/components/ui/card';
  import ChallengeEditorUrls from '$lib/enums/ChallengeEditorUrls';
	import { Button as ButtonIcon, Hand, ListBullet, DotFilled } from 'radix-icons-svelte';
	import { Button } from '$lib/components/ui/button';
  import { createEventDispatcher } from 'svelte';

	export let slug: string | undefined;

	const dispatch = createEventDispatcher();
</script>

<Card.Header>
  <Card.Title>Challenges</Card.Title>
  <Card.Description>Select the challenge type you would like to edit.</Card.Description>
</Card.Header>
<Card.Content>
  <ul class="menu menu-lg p-4 min-h-full text-base-content flex-nowrap">
    <li>
      <Button
        variant={!slug ? 'secondary' : 'outline'}
        href={`/admin/challenge-editor${ChallengeEditorUrls.SCQ ? '/' + ChallengeEditorUrls.SCQ : ''}`}
        data-testid="scq-button"
        on:click={() => dispatch('sideMenuItemClicked')}
        class="flex items-center text-sm justify-start">
        <svelte:component this={DotFilled} class="mr-2 my-1" />
        Single Choice</Button
      >
    </li>
    <div class="my-1" />
    <li>
      <Button
        variant={!slug ? 'secondary' : 'outline'}
        href={`/admin/challenge-editor${ChallengeEditorUrls.MCQ ? '/' + ChallengeEditorUrls.MCQ : ''}`}
        data-testid="mcq-button"
        on:click={() => dispatch('sideMenuItemClicked')}
        class="flex items-center text-sm justify-start">
        <svelte:component this={ListBullet} class="mr-2 my-1" />
        Multiple Choice</Button
      >
    </li>
    <div class="my-1" />
    <li>
      <Button
        variant={!slug ? 'secondary' : 'outline'}
        href={`/admin/challenge-editor${ChallengeEditorUrls.CONNECT_BLOCKS ? '/' + ChallengeEditorUrls.CONNECT_BLOCKS : ''}`}
        data-testid="connect-blocks-button"
        on:click={() => dispatch('sideMenuItemClicked')}
        class="flex items-center text-sm justify-start">
        <svelte:component this={Hand} class="mr-2 my-1" />
        Connect Blocks</Button
      >
    </li>
    <div class="my-1" />
    <li>
      <Button
        variant={!slug ? 'secondary' : 'outline'}
        href={`/admin/challenge-editor${ChallengeEditorUrls.CODE_OUTPUT ? '/' + ChallengeEditorUrls.CODE_OUTPUT : ''}`}
        data-testid="code-output-button"
        on:click={() => dispatch('sideMenuItemClicked')}
        class="flex items-center text-sm justify-start">
        <svelte:component this={ButtonIcon} class="mr-2 my-1" />
        Code Output</Button
      >
    </li>
    <div class="my-1" />
  </ul>

</Card.Content>
<Card.Footer class="flex justify-end">
</Card.Footer>