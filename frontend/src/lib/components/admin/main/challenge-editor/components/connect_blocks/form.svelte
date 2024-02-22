<script>
  let challenge = {
      name: '',
      difficulty: '',
      question_overview: '',
      first_group: [],
      second_group: [],
      correct_answers: [],
      correct_answer_explanation: '',
      _type: 'ConnectBlocksChallenge',
  };

  // Function to parse group inputs and correct answers text
  function parseGroupsAndAnswers() {
      // Parse and assign first_group and second_group based on textarea inputs
      challenge.first_group = document.getElementById('first-group').value.split('\n').filter(Boolean);
      challenge.second_group = document.getElementById('second-group').value.split('\n').filter(Boolean);

      // Parse correct answers text to form pairs
      const pairsText = document.getElementById('correct-answers').value.split(';').filter(Boolean);
      challenge.correct_answers = pairsText.map(pair => pair.split(',').map(Number));
  }

  async function submitChallenge(event) {
      event.preventDefault(); // Prevent the form from traditional submission

      if (!challenge.name) {
          alert("Challenge Name is required.");
          return;
      }
      if (!challenge.difficulty) {
          alert("Difficulty level is required.");
          return;
      }
      if (!challenge.question_overview) {
          alert("Question Overview is required.");
          return;
      }
      if (challenge.first_group.length === 0) {
          alert("At least one item in the First Group is required.");
          return;
      }
      if (challenge.second_group.length === 0) {
          alert("At least one item in the Second Group is required.");
          return;
      }
      if (challenge.correct_answers.length === 0) {
          alert("At least one correct answer pairing is required.");
          return;
      }
      if (!challenge.correct_answer_explanation) {
          alert("Correct Answer Explanation is required.");
          return;
      }

      // Call the parsing function to update challenge object
      parseGroupsAndAnswers();

      console.log(challenge); // For demonstration, you should proceed with the fetch operation here

      // Add your fetch API call here to submit 'challenge' to your endpoint
  }
</script>

<form on:submit|preventDefault={submitChallenge} style="display: flex; flex-direction: column; gap: 20px;">
    <div>
        <label for="name">Challenge Name</label>
        <input id="name" on:input={e => challenge.name = e.target.value} />
    </div>

    <div>
        <label for="difficulty">Difficulty</label>
        <select id="difficulty" on:change={e => challenge.difficulty = e.target.value}>
            <option value="">Select difficulty</option>
            <option value="EASY">Easy</option>
            <option value="MEDIUM">Medium</option>
            <option value="HARD">Hard</option>
        </select>
    </div>

    <div>
        <label for="overview">Question Overview</label>
        <textarea id="overview" on:input={e => challenge.question_overview = e.target.value}></textarea>
    </div>

    <div style="display: flex; gap: 10px;">
        <div>
            <label for="first-group">First Group Items (One per line)</label>
            <textarea id="first-group"></textarea>
        </div>
        <div>
            <label for="second-group">Second Group Items (One per line)</label>
            <textarea id="second-group"></textarea>
        </div>
    </div>

    <div>
        <label for="correct-answers">Correct Answers (Format: "index1,index2; index3,index4; etc.")</label>
        <textarea id="correct-answers" placeholder="0,1; 2,3; etc."></textarea>
    </div>

    <div>
        <label for="explanation">Correct Answer Explanation</label>
        <textarea id="explanation" on:input={e => challenge.correct_answer_explanation = e.target.value}></textarea>
    </div>

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
