<?php

include 'connection.php';

$id = $_POST['id'];

$sql = "DELETE * FROM notes WHERE id = $id";

if ($con->query($sql) === TRUE) {
    echo "User registered successfully";
} else {
    echo "Error: " . $sql . "<br>" . $con->error;
}

$con->close();

?>