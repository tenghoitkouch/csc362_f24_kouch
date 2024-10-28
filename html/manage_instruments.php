<?php
    // Show all errors from the PHP interpreter.
    ini_set('display_errors', 1);
    ini_set('display_startup_errors', 1);
    error_reporting(E_ALL);

    // Show all errors from the MySQLi Extension.
    mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);  
?>

<?php

    function result_to_html_table($result) {
        $qryres = $result->fetch_all();
        $n_rows = $result->num_rows;
        $n_cols = $result->field_count;
        $fields = $result->fetch_fields();
        ?>
        <!-- Description of table - - - - - - - - - - - - - - - - - - - - -->
        <!-- <p>This table has <?php //echo $n_rows; ?> and <?php //echo $n_cols; ?> columns.</p> -->
        
        <!-- Begin header - - - - - - - - - - - - - - - - - - - - -->
        <!-- Using default action (this page). -->
        <table>
        <thead>
        <tr>
        <?php for ($i=0; $i<$n_cols; $i++){ ?>
            <td><b><?php echo $fields[$i]->name; ?></b></td>
        <?php } ?>
        </tr>
        </thead>
        
        <!-- Begin body - - - - - - - - - - - - - - - - - - - - - -->
        <tbody>
        <?php for ($i=0; $i<$n_rows; $i++){ ?>
            <?php $id = $qryres[$i][0]; ?>
            <tr>     
            <?php for($j=0; $j<$n_cols; $j++){ ?>
                <td><?php echo $qryres[$i][$j]; ?></td>
            <?php } ?>
            </tr>
        <?php } ?>
        </tbody></table>
    <?php } 
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    
    <?php
        $config = parse_ini_file('/home/tenghoitkouch/mysql.ini');
        $dbname = 'instrument_rentals';
        $conn = new mysqli(
                    $config['mysqli.default_host'],
                    $config['mysqli.default_user'],
                    $config['mysqli.default_pw'],
                    $dbname);

        if ($conn->connect_errno) {
            echo "Error: Failed to make a MySQL connection, here is why: ". "<br>";
            echo "Errno: " . $conn->connect_errno . "\n";
            echo "Error: " . $conn->connect_error . "\n";
            exit; // Quit this PHP script if the connection fails.
        } 
        

    ?>

</body>
</html>