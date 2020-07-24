<template>
   <div class="Register">
    <form >
        <label for="firstname">First Name:</label>
	<input id="firstname" type="text" name="firstname" placeholder="John">

	<label for="lastname">Last Name:</label>
	<input id="lastname" type="text" name="lastname" placeholder="Smith">

	<label for="male">Male</label>
	<input id="male" type="radio" name="genderOption">

	<label for="female">Female</label>
	<input id="female" type="radio" name="genderOption">

	<label for="other">Other</label>
	<input id="other" type="radio" name="genderOption">


	<label for="email">Email:</label>
	<input id="email" type="email" name="email" placeholder="your email">

	<label for="password">Password:</label>
	<input id="password" type="password" name="password" placeholder="your password">

	<label for="birthday">Birthday:</label>
	<select id="birthday" placeholder="Month">
		<option>January</option>
		<option>February</option>
		<option>March</option>
		<option>April</option>
		<option>May</option>
		<option>June</option>
		<option>July</option>
		<option>August</option>
	</select>
	<select placeholder="Day">
		<option>1</option>
		<option>2</option>
		<option>3</option>
		<option>4</option>
		<option>5</option>
	</select>
	<select placeholder="Year">
		<option>2000</option>
		<option>2001</option>
		<option>2003</option>
	</select>
	<label for="agree">I agree to the terms and coditions</label>
	<input id="agree" type="checkbox" name="agreement">

	<button>Submit</button>
    </form>
    </div>
</template>

<script>
export default {
    
}
</script>

<style scoped>

</style>