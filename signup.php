<?php

include 'connection.php';

$username = $_POST['username'];
$email = $_POST['email'];
$password = $_POST['password'];

$sql = "INSERT INTO users (username, email, password) VALUES ('$username', '$email', '$password')";

if ($con->query($sql) === TRUE) {
    echo "User registered successfully";
} else {
    echo "Error: " . $sql . "<br>" . $con->error;
}

$con->close();

?>