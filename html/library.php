<?php

    function session_display(){
        if(isset($_SESSION['username'])){
            ?><p>Welocome <?php echo $_SESSION['username']; ?></p>
            <form action="manage_instruments.php" method="POST">
                <input type="submit" name="logout" value="Logout">
            </form><?php
        }else{
            ?><p>Enter name to start/resume session: </p>
            <form action="manage_instruments.php" method="POST">
                <input type="text" name="username" placeholder="Enter name...">
                <input type="submit" value="Remember Me">
            </form><?php 
        }
    }
    
?>