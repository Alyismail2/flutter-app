<?php

include 'connection.php';

if (isset($_POST['title']) && isset($_POST['note'])) {
    
    $title = mysqli_real_escape_string($con, $_POST['title']);
    $note = mysqli_real_escape_string($con, $_POST['note']);

    $query = "INSERT INTO notes (title, note) VALUES ('$title', '$note')";
    $result = mysqli_query($con, $query);

    if ($result) {
        echo "Note added successfully";
    } else {
        echo "Failed to add note";
    }
} else {
    echo "Invalid request. Please provide title and note.";
}

mysqli_close($con);

?>
