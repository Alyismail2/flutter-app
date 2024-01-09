<?php

include 'connection.php';

$result = mysqli_query($con, "SELECT * FROM notes");

$notes = array();
while ($row = mysqli_fetch_assoc($result)) {
    $notes[] = $row;
}

echo json_encode($notes);

mysqli_close($con);

?>