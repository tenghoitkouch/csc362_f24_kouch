<?php
    // Show all errors from the PHP interpreter.
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);

    // Show all errors from the MySQLi Extension.
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);  
?>

<!DOCTYPE html>
<html>
<head>
    <title>Table Details View</title>
</head>
<body>
    <a href="connect.php">Back to Available Databases Page</a>
    <h1>Tables in the <u style="font-family:monospace"><?php echo $_GET['dbname']; ?></u> Database</h1>

    <?php

        $dbhost = 'localhost';
        $dbuser = 'tenghoitkouch'; // Hard-coding credentials directly in code is not ideal: (1) we might have to 
        $dbpass = 'amumu';
        $dbname = $_GET["dbname"];       // change them in multiple places, and (2) this creates security concerns. 
                                    // We'll fix that in the next lab.

        $conn = new mysqli($dbhost, $dbuser, $dbpass, $dbname);

        if ($conn->connect_errno) {
            echo "Error: Failed to make a MySQL connection, here is why: ". "<br>";
            echo "Errno: " . $conn->connect_errno . "\n";
            echo "Error: " . $conn->connect_error . "\n";
            exit; // Quit this PHP script if the connection fails.
        } 

        //hard codeded
        $query = "SHOW TABLES";
        $stmt = $conn->prepare($query); //what does prepare() do
        if (!$stmt) {
            echo "Couldn't prepare statement!";
            echo exit;
        }

        $stmt->execute();
        $result = $stmt->get_result();

        $conn->close();
    
        // Make sure our query didn't fail.
        if (!$result) {
            echo "Query failed!" . "<br>";
            echo "Unable to execute query: " . $query;
            exit;
        }

    ?>

    <p>
        <?php
            echo $result->field_count . " field(s) in results.<br>";
            echo $result->num_rows . " row(s) in results.";
        ?>
    </p>

    <h2>Here is some detail about each field:</h2>
    <?php
        while ($field = $result->fetch_field() ) {
            echo "<h3>" . "Field Name: " . $field->name . "</h3>";
            echo "  Field Type: " . $field->type . "<br>";
            echo "Field Length: " . $field->length . " bytes";
        }
    ?>

    <h3>Tables:</h3>
    <ul>        
        <?php
            while($rec = $result->fetch_array(MYSQLI_BOTH)){
                echo "<li>" . $rec[0] . "</li>";
            }        
        ?>
    </ul>
</body>
</html>

