<?php
    // Show all errors from the PHP interpreter.
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);

    // Show all errors from the MySQLi Extension.
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);  

    $dbhost = 'localhost';
    $dbuser = 'tenghoitkouch'; // Hard-coding credentials directly in code is not ideal: (1) we might have to 
    $dbpass = 'amumu';       // change them in multiple places, and (2) this creates security concerns. 
                                // We'll fix that in the next lab.

    $conn = new mysqli($dbhost, $dbuser, $dbpass);

    if ($conn->connect_errno) {
        echo "Error: Failed to make a MySQL connection, here is why: ". "<br>";
        echo "Errno: " . $conn->connect_errno . "\n";
        echo "Error: " . $conn->connect_error . "\n";
        exit; // Quit this PHP script if the connection fails.
    } else {
        echo "Connected Successfully!" . "<br>";
        echo "YAY!" . "<br>";
    }
?>

<!DOCTYPE html>
<html>
    <head>
        <title>Databases Available</title>
    </head>
    <body>
        <h1>Databases Available</h1>
        <?php
            $dblist = "SHOW databases";

            $result = $conn->query($dblist);
        ?>
        <ul>
            <?php
                while ($dbname = $result->fetch_array()) {
                    echo "<li>" . $dbname['Database'] . "</li>";
                }
            ?>
        </ul>
        <h2>Enter the name one of the databases above to learn more about it:</h2>
        <form action="details.php" method="GET">
            <p>Database name: <input type="text" name="dbname" /></p>
            <p><input type="submit" value="See Details"/></p>
        </form>
        <?php
            $conn->close();
        ?>

        <h2>Check back soon!</h2>
    </body>
</html>