<script>
	let challenge = {
		name: '',
		difficulty: '',
		question_overview: '',
		answers: ['', '', '', ''],
		correct_answer: null,
		correct_answer_explanation: '',
		_type: 'ScqChallenge',
		// `updated_at` and `created_at` will be handled server-side
	};

	async function submitChallenge() {
    // Prevent the form from submitting traditionally
    event.preventDefault();
    console.log("HI")

    // Endpoint where you want to submit the form data
    const endpoint = '/api/admin/challenges'; // Adjust this to your actual endpoint

    const data = {
        challenge: challenge // Wrap your challenge data within a challenge key
    };
    // Use fetch API to submit the form data
    try {
        const response = await fetch(endpoint, {
            method: 'POST', // or 'PUT'
            headers: { 
                'Content-Type': 'application/json',
            },

            body: JSON.stringify(data) // Your form data
          

        });

        if (response.ok) {
            const jsonResponse = await response.json();
            console.log('Success:', jsonResponse);
            // Handle success (e.g., showing a success message or redirecting)
        } else {
            throw new Error('Network response was not ok.');
        }
    } catch (error) {
        console.error('Error:', error);
        // Handle error (e.g., showing an error message)
    }
	
	}


</script>


<form on:submit|preventDefault={submitChallenge}>
	<label for="name">Challenge Name</label>
	<input id="name" bind:value={challenge.name} />

	<label for="difficulty">Difficulty</label>
	<select id="difficulty" bind:value={challenge.difficulty}>
		<option value="">Select difficulty</option>
		<option value="EASY">Easy</option>
		<option value="MEDIUM">Medium</option>
		<option value="HARD">Hard</option>
	</select>

	<label for="overview">Question Overview</label>
	<textarea id="overview" bind:value={challenge.question_overview}></textarea>

	{#each challenge.answers as answer, index (index)}
		<label for={`answer-${index}`}>Answer {index + 1}</label>
		<input id={`answer-${index}`} bind:value={challenge.answers[index]} />
	{/each}

	<label for="correct-answer">Correct Answer</label>
	<select id="correct-answer" bind:value={challenge.correct_answer}>
		<option value="">Select the correct answer</option>
		{#each challenge.answers as _, index (index)}
			<option value={index}>{index + 1}</option>
		{/each}
	</select>

	<label for="explanation">Correct Answer Explanation</label>
	<textarea id="explanation" bind:value={challenge.correct_answer_explanation}></textarea>

	<button type="submit">Submit Challenge</button>
</form>

<style>
	form {
		max-width: 600px;
		margin: auto;
		padding: 20px;
		box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		border-radius: 8px;
		background: gray;
	}

	label {
		display: block;
		margin-top: 20px;
		font-weight: bold;
	}

	input, select, textarea {
		width: 100%;
		padding: 10px;
		margin-top: 5px;
		border: 1px solid #ccc;
		border-radius: 4px;
		box-sizing: border-box; /* Makes sure padding doesn't affect overall width */
	}

	button {
		display: block;
		background-color: #007bff;
		color: white;
		padding: 10px 15px;
		border: none;
		border-radius: 4px;
		margin-top: 20px;
		cursor: pointer;
		width: 100%;
	}

	button:hover {
		background-color: #0056b3;
	}

	textarea {
		height: 100px; /* Adjust height of the textarea */
	}

	/* Additional styles for form responsiveness and aesthetics */
	@media (max-width: 640px) {
		form {
			width: 90%;
			padding: 10px;
		}
	}
</style>
