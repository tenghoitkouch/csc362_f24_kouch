<?php $user_name = "John"; ?>

<h1>Hello <?= $user_name ?></h1>

<?php 
echo $_SERVER['HTTP_USER_AGENT'];

if(str_contains($_SERVER['HTTP_USER_AGENT'], 'Firefox')){
	echo 'You are using Firefox.';
}else{
	echo 'You are not using Firefox';
}
?>

<form action="action.php" method="post">
    <label for="name">Your name:</label>
    <input name="name" id="name" type="text">

    <label for="age">Your age:</label>
    <input name="age" id="age" type="number">

    <button type="submit">Submit</button>
</form>

Hi <?php echo htmlspecialchars($_POST['name']); ?>.
You are <?php echo (int) $_POST['age']; ?> years old.