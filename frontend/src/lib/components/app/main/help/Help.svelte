<script lang="ts">
	import * as Card from '$lib/components/ui/card';
	import { Button } from '$lib/components/ui/button';
</script>

<div class="flex grow p-4 relative overflow-x-auto">
	<Card.Root class="flex grow relative overflow-x-auto"
		><div class="grow w-full">
			<Card.Header>
				<Card.Title>Help &amp; Support</Card.Title>
				<!-- <Card.Description></Card.Description> -->
			</Card.Header>
			<Card.Content>
				<div class="flex flex-col gap-4 items-start">
					<p>
						Email to contact in case of any issues or queries: <a
							href="mailto:support@gamifycoding.me">support@gamifycoding.me</a
						>
					</p>
					<Button>View Consent Form</Button>
				</div></Card.Content
			>
		</div>
	</Card.Root>
</div>
