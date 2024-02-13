<script lang="ts">
	import * as Form from '$lib/components/ui/form';

	export let config: any;
	export let name: string;
	export let label: string;
	export let allChecked: boolean;

</script>

<Form.Field {config} {name}>
	<Form.Item>
		<div class="flex justify-center">
			<Form.Label class="label" >{label}</Form.Label>
			<div class="flex items-center ml-auto pl-8">
				<Form.Checkbox bind:checked={allChecked}/>
			</div>
		</div>
	</Form.Item>
</Form.Field>