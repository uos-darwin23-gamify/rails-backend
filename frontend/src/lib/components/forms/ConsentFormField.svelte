<script lang="ts">
	import * as Form from '$lib/components/ui/form';

	export let config: any;
	export let name: string;
	export let label: string;
</script>

<Form.Field {config} {name}>
	<Form.Item>
		<div class="label-checkbox-container">
			<Form.Label class="label">{label}</Form.Label>
			<div class="checkbox-container">
				<Form.Checkbox />
			</div>
		</div>
	</Form.Item>
</Form.Field>

<style>
    .label-checkbox-container {
        display: flex;
        align-items: center;
    }

    .checkbox-container {
        display: flex;
        align-items: center;
        margin-left: auto;
        padding-left: 2em;
    }
</style>
