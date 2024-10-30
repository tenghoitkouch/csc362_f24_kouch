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
         <form action="POST">
            <table>
                <thead>
                    <tr>
                        <td>Delete?</td>
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
                                <td><input type="checkbox" name="checkbox<?php echo $id; ?>" value="<?php echo $id; ?>" /></td>
                                <?php for($j=0; $j<$n_cols; $j++){ ?>
                                    <td><?php echo $qryres[$i][$j]; ?></td>
                                <?php } ?>
                            </tr>
                    <?php } ?>
                </tbody>
            </table>
            <p><input type="submit" name="delbtn" value="Delete Selected Records" /></p>
        </form>
    <?php } 
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instrument Rentals</title>
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
        $sql_location = '/home/tenghoitkouch/csc362_f24_kouch/html/';
        $sel_tbl = file_get_contents($sql_location . 'select_instruments.sql');
        // echo $sel_tbl;
        $result = $conn->query($sel_tbl);
        echo $result->field_count . " field(s) in results.<br>";
        echo $result->num_rows . " row(s) in results.";
        result_to_html_table($result);
    ?>

    <?php
        if(array_key_exists('delbtn', $_POST)){

            $get_all_instrument_ids = "SELECT instrument_id FROM instruments";
            $idlist = $conn->query($get_all_instrument_ids);

            for($i = 0; $i < count($idlist); $i++){
                $id = $idlist[0];
                if(in_array("checkbox" . $id, $_POST)){
                    $del_stmt = file_get_contents('/home/tenghoitkouch/csc362_f24_kouch/html/delete_instrument.sql');
                    $del_stmt = $conn->prepare("DELETE...");
                    $del_stmt->bind_param('i', $id);
                    $$del_stmt->execute();
                }
            }

            header("Location: {$_SERVER['REQUEST_URI']}", true, 303);
            exit();
        }
    ?>

    <form method="POST">
        <input type="submit" name="add_records" value="Add extra records" />  
    </form>

    <?php
        if(array_key_exists('add_records', $_POST)){

            $add_tbl = file_get_contents('/home/tenghoitkouch/csc362_f24_kouch/html/add_instruments.sql');
            $add_stmt = $conn->prepare($add_tbl);
            $add_stmt->execute();

            header("Location: {$_SERVER['REQUEST_URI']}", true, 303);
            exit();
        }
    ?>
</body>
</html>