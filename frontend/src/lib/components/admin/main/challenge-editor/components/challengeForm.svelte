<form on:submit|preventDefault={handleSubmit}>
  <div class="form-group">
    <label for="challengeName">Challenge Name</label>
    <input type="text" id="challengeName" bind:value={challengeName} required>
  </div>
  <div class="form-group">
    <label for="challengeDescription">Description</label>
    <textarea id="challengeDescription" bind:value={challengeDescription} rows="3" required></textarea>
  </div>
  <button type="submit" class="submit-btn">Add Challenge</button>
</form>

<script>
  let challengeName = '';
  let challengeDescription = '';

  const handleSubmit = () => {
    // Implement your submission logic here.
    // For example, send a POST request to your backend API with the challenge data
    console.log({ challengeName, challengeDescription });
    
    // After submission, you may want to clear the form or provide feedback to the user
    challengeName = '';
    challengeDescription = '';
    
    // Optionally close the modal if needed
    // toggleModal(); // Uncomment if you want to automatically close the modal on submit
  };
</script>

<style>
  .form-group {
    margin-bottom: 1rem;
  }
  .form-group label {
    display: block;
    margin-bottom: 0.5rem;
  }
  .form-group input, .form-group textarea {
    width: 100%;
    padding: 0.5rem;
    margin-bottom: 0.5rem;
    box-sizing: border-box;
  }
  .submit-btn {
    background-color: #007bff;
    color: white;
    padding: 0.5rem 1rem;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }
  .submit-btn:hover {
    background-color: #0056b3;
  }
</style>
