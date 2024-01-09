<?php

include 'connection.php';

$email = $_POST['email'];
$password = $_POST['password'];

$sql = "SELECT * FROM users WHERE email = '$email'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    $hashedPassword = $row['password'];

    if (password_verify($password, $hashedPassword)) {
        echo "Login successful";
    } else {
        echo "Login failed. Incorrect password";
    }
} else {
    echo "Login failed. User not found";
}

$conn->close();
?>