<script lang="ts">
    import { onMount } from 'svelte';
	let challenge = {
		name: '',
		difficulty: '',
		question_overview: '',
		answers: ['', '', '', ''],
		correct_answer: null,
		correct_answer_explanation: '',
		_type: 'ScqChallenge'
		// `updated_at` and `created_at` will be handled server-side
	};

	let successMessage = '';
	let dialog;
	let selectedForm = '';
	let file:File|null = null; // This will hold the uploaded file

	const forms = {
		'scqChallenge': 'Single Choice Question Challenge',
		// Add other form types here if needed
	};

	async function handleFileChange(event: Event) {
    const target = event.target as HTMLInputElement
		file = target?.files && target?.files[0];
	}

  async function postChallenges(challenges, endpoint) {
    for (const challenge of challenges) {
      const data = {
        challenge: challenge // Wrap your challenge data within a challenge key
      };
      console.log(data)
      try {
        const response = await fetch(endpoint, {
          method: 'POST', // or 'PUT'
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify(data) // Convert your form data to JSON
        });

        if (response.ok) {
          const jsonResponse = await response.json();
          //console.log('Success:', jsonResponse);
          // Handle success here (e.g., showing a success message or redirecting)
        } else {
          throw new Error('Network response was not ok.');
        }
      } catch (error) {
        console.error('Error:', error);
        // Handle error here (e.g., showing an error message)
      }
    }
		successMessage = 'All challenges submitted successfully!';
  }

	async function parseAndSubmitCSV(file) {
    console.log("PARSING")
		const reader = new FileReader();
		reader.onload = async (e) => {
			const text = e.target.result;
			const challenges = csvToChallenges(text);
			// Submit challenges here, or set them to state variable to be submitted later
			// console.log(challenges);
      // Endpoint where you want to submit the form data
      const endpoint = '/api/admin/scq-challenge-create'; // Adjust this to your actual endpoint

      postChallenges(challenges, endpoint)

		};
		reader.readAsText(file);
	}

	function csvToChallenges(csvText) {
    console.log("SPLITING")
    const lines = csvText.trim().split("\r\n");
    console.log(lines)
		const challenges = lines.slice(1).map(line => {
        // Split each line by commas to get individual values
        const values = line.split(',');
				console.log(line)
        // Extract question, answers, booleans, difficulty, and explanation from the values
        const name = values[0];
        const question_overview = values[0]
        const answers = [
            {text: values[1], isCorrect: values[2] === 'true'},
            {text: values[3], isCorrect: values[4] === 'true'},
            {text: values[5], isCorrect: values[6] === 'true'},
            {text: values[7], isCorrect: values[8] === 'true'}
        ];
        const difficulty = values[9];
        const correct_answer_explanation = values[10];

        // Find the correct answer based on the boolean flags
        const correctIndex = answers.findIndex(answer => answer.isCorrect);

        return {
            name,
            answers: answers.map(answer => answer.text),
            correct_answer: correctIndex + 1, // Assuming correct_answer should be the index (1-based) of the correct answer
            difficulty,
            correct_answer_explanation,
            question_overview,
            _type: 'ScqChallenge'
        };
    });
		return challenges;
	}

  async function handleSubmit() {
      console.log("STARTING FILE")
      // event.preventDefault(); // Prevent the form from submitting in the traditional way
      if (file) {
          parseAndSubmitCSV(file);
          file = null
          handleFileChange
      }
    }
</script>


<form on:submit|preventDefault={handleSubmit}>
  <h2>Upload SCQ Challenge CSV</h2>
  <hr />
  <input type="file" accept=".csv" on:change={handleFileChange} />
  <hr />
	{#if successMessage != ''}
    <p>{successMessage}</p>
  {/if}
  <button type="submit">Submit</button>
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

	input,
	select,
	textarea {
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
