<script lang="ts">
    import { onMount } from 'svelte';

	let successMessage = '';
	let dialog;
	let selectedForm = '';
	let file:File|null = null; // This will hold the uploaded file

	const forms = {
		'mcqChallenge': 'Multi Choice Question Challenge',
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

	function parseCsvLineWithQuotes(line) {
    const values = [];
    let current = '';
    let insideQuotes = false;
  
    for (let i = 0; i < line.length; i++) {
        const char = line[i];
      
        if (char === '"' && (i === 0 || line[i-1] !== '\\')) {
            insideQuotes = !insideQuotes;
            continue;
        }
      
        if (char === ',' && !insideQuotes) {
            values.push(current);
            current = '';
        } else {
            current += char;
        }
    }
  
    values.push(current); // Push the last value
  
    return values.map(value => value.trim().replace(/^"(.*)"$/, '$1')); // Remove surrounding quotes if present
	}

  function csvToConnectBlocksChallenges(csvText) {
        const lines = csvText.trim().split("\n");
        return lines.slice(1).map(line => {
            const values = parseCsvLineWithQuotes(line);
            return createConnectBlocksChallenge(values);
        });
    }

    function createConnectBlocksChallenge(values) {
        let challenge = {
            name: values[0],
            difficulty: values[9],
            question_overview: values[0],
            first_group: [values[1], values[3], values[5], values[7]],
            second_group: [values[2], values[4], values[6], values[8]],
            correct_answers: [[0,0],[1,1],[2,2],[3,3]],
            correct_answer_explanation: values[10],
            _type: 'ConnectBlocksChallenge',
        };
        console.log("---")
        console.log(challenge)
        return challenge;
    }

    async function parseAndSubmitCSV(file) {
        if (file) {
            const reader = new FileReader();
            reader.onload = async (e) => {
                const text = e.target.result.toString();
                const challenges = csvToConnectBlocksChallenges(text);
                const endpoint = '/api/admin/blocks-challenge-create'; // Adjust to your actual endpoint
                await postChallenges(challenges, endpoint);
            };
            reader.readAsText(file);
        }
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
  <h2>Upload MCQ Challenge CSV</h2>
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
