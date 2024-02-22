<script>
// @ts-nocheck

	import { onMount, createEventDispatcher } from 'svelte';
	import ScqForm from './scq/form.svelte';
	import CodeOutputForm from './code_output/form.svelte'
	import ConnectBlocksForm from './connect_blocks/form.svelte'
  export let showModal = false;
  let dialog;

	let csrfToken;

  onMount(() => {
    const meta = document.querySelector('meta[name="csrf-token"]');
    csrfToken = meta ? meta.getAttribute('content') : '';
  });

  $: if (showModal && dialog) {

    dialog.showModal();
  } else if (dialog) {
    dialog.close();
  }
	let selectedForm = 'Option 1'; // This will hold the value of the selected option
	const forms = {
		form1: 'Single Choice Questions',
		form2: 'Option 2',
		form3: 'Code',
		form4: 'Connect Blocks',
	};
</script>

<dialog bind:this={dialog}>
  <!-- Modal content -->
</dialog>
<!-- svelte-ignore a11y-click-events-have-key-events a11y-no-noninteractive-element-interactions -->
<dialog bind:this={dialog} on:close={() => (showModal = false)} on:click|self={() => dialog.close()}>
	<div on:click|stopPropagation>
		<slot name="header" />
		<hr />
		<!-- Dropdown for selecting the form -->
		<select bind:value={selectedForm}>
			<option value="">Please select</option>
			{#each Object.entries(forms) as [formKey, formValue]}
				<option value={formKey}>{formValue}</option>
			{/each}
		</select>	
		<!-- Conditional rendering of forms based on selectedForm -->
		{#if selectedForm === 'form1'}
			<ScqForm/>
		{:else if selectedForm === 'form3'}
			<CodeOutputForm/>
		{:else if selectedForm === 'form4'}
			<ConnectBlocksForm/>
		{/if}
		<hr />
		<!-- svelte-ignore a11y-autofocus -->
		<button autofocus on:click={() => dialog.close()}>close modal</button>
	</div>
</dialog>

<style>
	dialog {
		max-width: 32em;
		border-radius: 0.2em;
		border: none;
		padding: 0;
	}
	dialog::backdrop {
		background: rgba(0, 0, 0, 0.3);
	}
	dialog > div {
		padding: 1em;
	}
	dialog[open] {
		animation: zoom 0.3s cubic-bezier(0.34, 1.56, 0.64, 1);
	}
	@keyframes zoom {
		from {
			transform: scale(0.95);
		}
		to {
			transform: scale(1);
		}
	}
	dialog[open]::backdrop {
		animation: fade 0.2s ease-out;
	}
	@keyframes fade {
		from {
			opacity: 0;
		}
		to {
			opacity: 1;
		}
	}
	button {
		display: block;
	}
</style>
